import 'package:flutter/material.dart';
import 'package:map_example/app/pages/map/map_controller.dart';
import 'package:provider/provider.dart';

class MapPanel extends StatelessWidget {
  const MapPanel({super.key});

  @override
  Widget build(BuildContext context) {
    MyMapController controller = context.read<MyMapController>();

    Widget smallButton(
      IconData icon,
      Function() onTap, {
      Color? background,
      Color? logoColor,
    }) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          color: Colors.grey[400],
          padding: EdgeInsets.all(5),
          child: Icon(icon, size: 22, color: logoColor),
        ),
      );
    }

    return Positioned(
      right: 20,
      left: 20,
      top: 0,
      bottom: 0,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              textDirection: TextDirection.ltr,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: smallButton(
                    Icons.location_searching_sharp,
                    controller.toUserLocation,
                  ),
                ),
                smallButton(Icons.add, controller.zoomIn),
                const SizedBox(height: 5),
                smallButton(Icons.remove, controller.zoomOut),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
