import 'package:flutter/material.dart';
import 'package:map_example/app/pages/map/widgets/map.dart';
import 'package:map_example/app/pages/map/widgets/map_loading.dart';
import 'package:map_example/app/pages/map/widgets/map_location_info.dart';
import 'package:map_example/app/pages/map/widgets/map_panel.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [Map(), MapLocationInfo(), MapLoadingWidget(), MapPanel()],
      ),
    );
  }
}
