import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  MapPageState createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
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
            urlTemplate: ' 	https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: "com.bpa.safelygo",
            minZoom: 3.0,
            maxZoom: 18.0,
          ),
        ],
      ),
    );
  }
}
