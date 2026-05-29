import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MovableMapWidget extends StatelessWidget {
  const MovableMapWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: FlutterMap(
        options: const MapOptions(
          initialCenter: LatLng(4.7110, -74.0721),
          initialZoom: 12,
        ),
        children: [
          TileLayer(
            urlTemplate:
                'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.mindpet.app',
          ),
        ],
      ),
    );
  }
}