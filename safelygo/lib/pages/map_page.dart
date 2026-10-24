import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

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

  @override
  Widget build(BuildContext context) {
    getLocation();
    return Scaffold(
      body: StreamBuilder(
        stream: getLocation().asStream(),
        builder: (context, snapshots) {
          if (!snapshots.hasData) {
            return Column(
              children: [
                SpinKitRing(color: Colors.accents.first),
                Text("Loading"),
              ],
            );
          }
          double longitude = snapshots.data!.longitude;
          double latitude = snapshots.data!.latitude;

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
              MarkerLayer(
                markers: [
                  Marker(
                    point: LatLng(latitude, longitude),
                    child: Icon(Icons.person_2_rounded),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
