import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:map_example/app/pages/map/layers/map_layer_job_pins.dart';
import 'package:map_example/app/pages/map/layers/map_layer_map_tiles.dart';
import 'package:map_example/app/pages/map/map_controller.dart';
import 'package:map_example/app/pages/map/layers/map_layer_device_location_indicator.dart';
import 'package:provider/provider.dart';

class Map extends StatelessWidget {
  const Map({super.key});

  @override
  Widget build(BuildContext context) {
    MyMapController controller = context.read<MyMapController>();

    return FlutterMap(
      key: const ValueKey('map-container'),
      mapController: controller.mapController,
      options: MapOptions(
        onPointerUp: (_, _) => controller.onMapPointerUp(),
        onTap: (_, _) => controller.onMapTap(),
        onPositionChanged: (_, hasGesture) => controller.onPositionChange(),
        initialCenter:
            controller.currentLocation?.latLng ??
            controller.defaultLocation.latLng,
        initialZoom: controller.zoom,
        initialRotation: 0,
        minZoom: 2,
        maxZoom: 18,
        interactionOptions: const InteractionOptions(
          flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
        ),
        backgroundColor: Colors.blue.withAlpha((0.635 * 255).toInt()),
      ),
      children: const [
        MapLayerMapTiles(),
        MapLayerMapItems(),
        MapLayerDeviceLocationIndicator(),
      ],
    );
  }
}
