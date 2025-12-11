import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:map_example/domain/entities/coordinate_entiry.dart';
import 'package:map_example/domain/entities/map_item_entiry.dart';
import 'package:map_example/domain/repositories/device/location_repository.dart';
import 'package:map_example/domain/repositories/map_data_repository.dart';

class MapUsecase {
  final MapDataRepository mapDataRepository;
  final LocationRepository locationRepository;

  MapUsecase({
    required this.mapDataRepository,
    required this.locationRepository,
  });

  Future<List<MapItemEntiry>> getDataFromLocation({
    required CoordinateEntiry location,
    required double radius,
  }) async {
    var res = <MapItemEntiry>[];

    res = await mapDataRepository.getMapItems(location: location);

    return res
        .where((e) => calculateDistance(location, e.coordinate) < radius)
        .toList();
  }

  double calculateDistance(CoordinateEntiry coor1, CoordinateEntiry coor2) {
    return Geolocator.distanceBetween(
      coor1.lat,
      coor1.lng,
      coor2.lat,
      coor2.lng,
    );
  }

  Future<CoordinateEntiry> getDeviceLocation() async {
    final res = await locationRepository.getDeviceLocation();
    return CoordinateEntiry(lat: res.latitude, lng: res.longitude);
  }

  Future<StreamSubscription> getLocationStream(
    void Function(CoordinateEntiry message) onData,
  ) async {
    final res = await locationRepository.getLocationStream();
    return res.listen((message) {
      onData(CoordinateEntiry(lat: message.latitude, lng: message.longitude));
    });
  }
}
