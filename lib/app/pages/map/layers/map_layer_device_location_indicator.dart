import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:map_example/app/pages/map/map_controller.dart';
import 'package:provider/provider.dart';

class MapLayerDeviceLocationIndicator extends StatelessWidget {
  const MapLayerDeviceLocationIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceLocation = context.watch<MyMapController>().deviceLocation;
    if (deviceLocation == null) {
      return const SizedBox();
    }
    return MarkerLayer(
      markers: [
        Marker(
          point: deviceLocation.latLng,
          child: const Icon(
            Icons.my_location_rounded,
            color: Colors.blue,
            size: 30,
          ),
        ),
      ],
    );
  }
}
