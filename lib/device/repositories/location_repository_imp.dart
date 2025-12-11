import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:map_example/domain/repositories/device/location_repository.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationRepositoryImp implements LocationRepository {
  final locationSettings = LocationSettings(accuracy: LocationAccuracy.lowest);

  @override
  Future<Position> getDeviceLocation() async {
    await checkPermissionAndService();

    // Position position = await Geolocator.getCurrentPosition(
    //   locationSettings: locationSettings,
    // ).timeout(Duration(seconds: 3));

    return Position(
      longitude: 105.773113,
      latitude: 10.038636,
      timestamp: DateTime.now(),
      accuracy: 1,
      altitude: 0,
      altitudeAccuracy: 1,
      heading: 1,
      headingAccuracy: 1,
      speed: 1,
      speedAccuracy: 1,
    );
  }

  @override
  Future<Stream<Position>> getLocationStream() async {
    await checkPermissionAndService();

    return Geolocator.getPositionStream(locationSettings: locationSettings);
  }

  Future checkPermissionAndService() async {
    bool status = await Permission.location.request().isGranted;

    if (!status) {
      throw PermissionException();
    }

    final enabled = await Geolocator.isLocationServiceEnabled();

    if (!enabled) {
      throw LocationDisabledException();
    }
  }
}
