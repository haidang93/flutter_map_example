import 'package:latlong2/latlong.dart';

class CoordinateEntity {
  final double lat;
  final double lng;

  CoordinateEntity({required this.lat, required this.lng});

  /// convert [CoordinateEntity] into [LatLng] so flutter_map can use
  LatLng get latLng => LatLng(lat, lng);
}

extension LatLngExt on LatLng {
  CoordinateEntity get toEntity =>
      CoordinateEntity(lat: latitude, lng: longitude);
}
