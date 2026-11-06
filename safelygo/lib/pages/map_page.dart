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
  final String _currentUser = FirebaseAuth.instance.currentUser!.uid;
  /**Future<List> getAllTrustedUsers() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    //Gets the user in the firestore with the corresponding UID
    QuerySnapshot snapshot = await db
        .collection("users")
        .where("id", isEqualTo: _currentUser)
        .get();

    if (snapshot.docs.isEmpty) {
      print("No document found with $_currentUser,");
      return [];
    }

    final docID = snapshot.docs.first.id;

    await db.collection("users").doc(docID).get("Trusted-Users");
  }**/

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

  Future<void> getLocation() async {
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

    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 5, // Triggers stream update every 5 meters moved
    );

    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position pos) {
          updateUserGeoLocation(
            FirebaseAuth.instance.currentUser!.uid,
            GeoPoint(pos.latitude, pos.longitude),
          ); //Updates the user Position in the database
        });

    // Permissions are granted, call your original code safely
  }

  Future<UserModel> getUser(String userID) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    //Gets the user in the firestore with the corresponding UID
    QuerySnapshot snapshot = await db
        .collection("users")
        .where("id", isEqualTo: userID)
        .get();

    if (snapshot.docs.isEmpty) {
      print("No document found with $userID,");
    }

    DocumentSnapshot doc = snapshot.docs.first;
    UserModel model = UserModel.fromDocument(doc);

    return model;
  }

  @override
  Widget build(BuildContext context) {
    getLocation();
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(_currentUser)
            .snapshots(),
        builder: (context, snapshots) {
          if (!snapshots.hasData) {
            return Column(
              children: [
                SpinKitRing(color: Colors.accents.first),
                Text("Loading"),
              ],
            );
          }
          UserModel user = UserModel.fromDocument(snapshots.data!);

          List<Marker> mapMarkers = [];
          List<String> trusted = user.trustedUsers;
          mapMarkers.add(
            Marker(
              point: LatLng(user.location.latitude, user.location.longitude),
              child: Icon(Icons.person),
            ),
          );
          return Scaffold(
            body: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .where(FieldPath.documentId, whereIn: trusted)
                  .snapshots(),
              builder: (context, snapshots) {
                if (snapshots.hasError) {
                  return Center(child: Text("Error: ${snapshots.error}"));
                }
                if (!snapshots.hasData)
                  return const Center(child: CircularProgressIndicator());

                for (var s in snapshots.data!.docs) {
                  UserModel model = UserModel.fromDocument(s);

                  mapMarkers.add(
                    Marker(
                      point: LatLng(
                        model.location.latitude,
                        model.location.longitude,
                      ),
                      child: Icon(Icons.person),
                    ),
                  );
                }

                return FlutterMap(
                  options: MapOptions(
                    initialZoom: 9.2,
                    maxZoom: 18.0,
                    minZoom: 3.0,
                    initialCenter: LatLng(
                      user.location.latitude,
                      user.location.latitude,
                    ),
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: "com.bpa.safelygo",
                      minZoom: 3.0,
                      maxZoom: 18.0,
                    ),
                    MarkerLayer(markers: mapMarkers),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
