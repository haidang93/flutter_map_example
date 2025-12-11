import 'package:flutter/material.dart';
import 'package:map_example/app/pages/map/map_controller.dart';
import 'package:provider/provider.dart';

class MapLoadingWidget extends StatelessWidget {
  const MapLoadingWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return context.watch<MyMapController>().loading
        ? const Positioned(
            top: 60,
            left: 10,
            child: SafeArea(
              child: SizedBox(
                height: 20,
                width: 20,
                child: Center(child: CircularProgressIndicator()),
              ),
            ),
          )
        : const SizedBox();
  }
}
