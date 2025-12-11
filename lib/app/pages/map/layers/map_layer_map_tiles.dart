import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:map_example/core/config.dart';

class MapLayerMapTiles extends StatelessWidget {
  const MapLayerMapTiles({super.key});

  @override
  Widget build(BuildContext context) {
    return TileLayer(
      urlTemplate: defaultMapURL,
      subdomains: defaultMapSubdomain,
      additionalOptions: {},
      userAgentPackageName: "www.mykibbi.com",
    );
  }
}
