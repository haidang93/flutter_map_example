import 'package:flutter/material.dart';
import 'package:map_example/app/pages/map/map_controller.dart';
import 'package:provider/provider.dart';

class MapLocationInfo extends StatelessWidget {
  const MapLocationInfo({super.key});
  @override
  Widget build(BuildContext context) {
    final watch = context.watch<MyMapController>();

    final lat = watch.currentLocation?.lat.toStringAsFixed(4);
    final lng = watch.currentLocation?.lng.toStringAsFixed(4);
    final zoom = watch.zoom.toStringAsFixed(2);

    return Positioned(
      bottom: MediaQuery.of(context).padding.bottom,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
        child: Text(
          [lat, lng, zoom].join(', '),
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
        ),
      ),
    );
  }
}
