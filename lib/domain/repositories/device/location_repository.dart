import 'dart:async';

import 'package:geolocator/geolocator.dart';

// Custom Exceptions
class PermissionException implements Exception {}

class LocationDisabledException implements Exception {}

abstract class LocationRepository {
  /// get current location from device GPS
  Future<Position> getDeviceLocation();

  /// get location stream
  Future<Stream<Position>> getLocationStream();
}
