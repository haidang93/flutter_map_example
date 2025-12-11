import 'package:latlong2/latlong.dart';

class CoordinateEntiry {
  final double lat;
  final double lng;

  CoordinateEntiry({required this.lat, required this.lng});

  /// convert [CoordinateEntiry] into [LatLng] so flutter_map can use
  LatLng get latLng => LatLng(lat, lng);
}

extension LatLngExt on LatLng {
  CoordinateEntiry get toEntity =>
      CoordinateEntiry(lat: latitude, lng: longitude);
}
