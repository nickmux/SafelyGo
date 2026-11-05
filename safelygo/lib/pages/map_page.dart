import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:safely_go/Models/UserModel.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  MapPageState createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  final LocationSettings locationSettings = LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 100,
  );

  Future<void> updateUserGeoLocation(String userID, GeoPoint location) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    //Gets the user in the firestore with the corresponding UID
    QuerySnapshot snapshot = await db
        .collection("users")
        .where("id", isEqualTo: userID)
        .get();

    if (snapshot.docs.isEmpty) {
      print("No document found with $userID,");
      return;
    }

    final docID = snapshot.docs.first.id;

    await db.collection("users").doc(docID).update({"Location": location});
  }

  Future<Position> getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    // Permissions are granted, call your original code safely
    return await Geolocator.getCurrentPosition(
      locationSettings: locationSettings,
    );
  }

  double longitude = 0;
  double latitude = 0;

  Future<List<Marker>> getTrustedUsersLocation(String userID) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    QuerySnapshot snapshot = await db
        .collection("users")
        .where("id", isEqualTo: userID)
        .get();

    if (snapshot.docs.isEmpty) {
      print("No document found with $userID,");
      return [];
    }

    UserModel user = UserModel.fromDocument(snapshot.docs.first);
    List<Marker> markers = [];

    Position currentUserPos = await getLocation();

    longitude = currentUserPos.longitude;
    latitude = currentUserPos.latitude;

    print(currentUserPos);

    markers.add(
      Marker(
        point: LatLng(currentUserPos.latitude, currentUserPos.longitude),
        child: Icon(Icons.person_2_rounded),
      ),
    );

    for (String i in user.trustedUsers) {
      QuerySnapshot trustedUser = await db
          .collection("users")
          .where("id", isEqualTo: i)
          .get();

      if (snapshot.docs.isEmpty) {
        print("No document found with $userID,");
        continue;
      }

      UserModel user = UserModel.fromDocument(snapshot.docs.first);

      markers.add(
        Marker(
          point: LatLng(user.location.latitude, user.location.longitude),
          child: Icon(Icons.person_2_rounded),
        ),
      );
    }

    return markers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: getTrustedUsersLocation(FirebaseAuth.instance.currentUser!.uid)
            .asStream(),
        builder: (context, snapshots) {
          if (!snapshots.hasData) {
            return Column(
              children: [
                SpinKitRing(color: Colors.accents.first),
                Text("Loading"),
              ],
            );
          }

          return FlutterMap(
            options: MapOptions(
              initialZoom: 9.2,
              maxZoom: 18.0,
              minZoom: 3.0,
              initialCenter: LatLng(latitude, longitude),
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: "com.bpa.safelygo",
                minZoom: 3.0,
                maxZoom: 18.0,
              ),
              MarkerLayer(markers: snapshots.data!),
            ],
          );
        },
      ),
    );
  }
}
