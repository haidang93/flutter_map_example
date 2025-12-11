import 'package:flutter/material.dart';
import 'package:map_example/app/pages/map/map_view.dart';
import 'package:map_example/app/pages/map/map_controller.dart';
import 'package:map_example/core/app_composition_root.dart';
import 'package:provider/provider.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableProvider(
      create: (context) => MyMapController(
        context.read<AppCompositionRoot>().usecases.mapUsecase,
      ),
      child: const MapView(),
    );
  }
}
