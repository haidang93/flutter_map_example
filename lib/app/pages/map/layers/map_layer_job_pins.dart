import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:map_example/app/pages/map/map_controller.dart';
import 'package:map_example/app/pages/map/widgets/item_view.dart';
import 'package:map_example/core/config.dart';
import 'package:provider/provider.dart';

class MapLayerMapItems extends StatelessWidget {
  const MapLayerMapItems({super.key});
  final pinSize = 40.0;

  @override
  Widget build(BuildContext context) {
    MyMapController watch = context.watch<MyMapController>();
    MyMapController controller = context.read<MyMapController>();

    return MarkerLayer(
      key: const ValueKey('job-map-marker-layer'),
      markers: watch.items
          .map(
            (item) => Marker(
              point: item.coordinate.latLng,
              width: pinSize,
              height: pinSize,
              rotate: true,
              alignment: Alignment.topCenter,
              child: GestureDetector(
                onTap: () => controller.onItemTap(item),
                onDoubleTap: () {
                  controller.animateOrJumpTo(
                    item.coordinate,
                    defaultInitialMapZoomValue,
                  );
                },
                child: ItemView(mapItem: item),
              ),
            ),
          )
          .toList(),
    );
  }
}
