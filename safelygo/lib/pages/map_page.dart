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

  Future<void> _updateUserGeoLocation(String userID, GeoPoint location) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(userID) // Replaced the redundant .where query lookup
        .update({"Location": location});
  }

  Future<void> _getLocation() async {
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
          _updateUserGeoLocation(
            FirebaseAuth.instance.currentUser!.uid,
            GeoPoint(pos.latitude, pos.longitude),
          ); //Updates the user Position in the database
        });

    // Permissions are granted, call your original code safely
  }

  @override
  void initState() {
    super.initState();
    // Safely begin background geolocation tracking loops
    _getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(_currentUser)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Column(
              children: [
                SpinKitRing(color: Colors.accents.first),
                Text("Loading"),
              ],
            );
          }
          UserModel user = UserModel.fromDocument(snapshot.data!);

          List<String> trusted = user.trustedUsers;
          List<Marker> mapMarkers = [
            Marker(
              point: LatLng(user.location.latitude, user.location.longitude),
              child: const Icon(
                Icons.my_location,
                color: Colors.blue,
                size: 30,
              ),
            ),
          ];

          if (trusted.isEmpty) {
            return _buildMap(
              markers: mapMarkers,
              center: LatLng(user.location.latitude, (user.location.longitude)),
            );
          }
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
                  if (s.id == _currentUser) continue;

                  UserModel model = UserModel.fromDocument(s);

                  //checks to see if each user has each other trusted.
                  for (String s in model.trustedUsers) {
                    if (s == _currentUser) {
                      mapMarkers.add(
                        Marker(
                          point: LatLng(
                            model.location.latitude,
                            model.location.longitude,
                          ),
                          child: Icon(Icons.person),
                        ),
                      );
                    } else {
                      continue;
                    }
                  }
                }
                return _buildMap(
                  markers: mapMarkers,
                  center: LatLng(
                    user.location.latitude,
                    user.location.longitude,
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

Widget _buildMap({required List<Marker> markers, required LatLng center}) {
  return FlutterMap(
    options: MapOptions(
      initialZoom: 9.2,
      maxZoom: 18.0,
      minZoom: 3.0,
      initialCenter: center,
    ),
    children: [
      TileLayer(
        urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
        userAgentPackageName: "com.bpa.safelygo",
        minZoom: 3.0,
        maxZoom: 18.0,
      ),
      MarkerLayer(markers: markers),
    ],
  );
}
