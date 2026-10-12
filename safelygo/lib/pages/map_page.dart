import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';

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
    return await Geolocator.getCurrentPosition(
      locationSettings: locationSettings,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        options: MapOptions(
          initialZoom: 9.2,
          maxZoom: 18.0,
          minZoom: 3.0,
          cameraConstraint: CameraConstraint.unconstrained(),
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: "com.bpa.safelygo",
            minZoom: 3.0,
            maxZoom: 18.0,
          ),
        ],
      ),
    );
  }
}
