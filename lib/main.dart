import 'package:flutter/material.dart';
import 'package:map_example/app/pages/map/map_page.dart';
import 'package:map_example/core/app_composition_root.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => AppCompositionRoot()),
        // Provider(create: (context) => DeeplinkProvider(context)),
      ],
      child: MaterialApp(
        title: 'Example',
        debugShowCheckedModeBanner: false,
        home: MapPage(),
        // other app configurations
      ),
    );
  }
}
