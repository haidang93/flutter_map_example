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
    required CoordinateEntity location,
    required double radius,
  }) async {
    var res = <MapItemEntiry>[];

    res = await mapDataRepository.getMapItems(location: location);

    return res
        .where((e) => calculateDistance(location, e.coordinate) < radius)
        .toList();
  }

  double calculateDistance(CoordinateEntity coor1, CoordinateEntity coor2) {
    return Geolocator.distanceBetween(
      coor1.lat,
      coor1.lng,
      coor2.lat,
      coor2.lng,
    );
  }

  Future<CoordinateEntity> getDeviceLocation() async {
    final res = await locationRepository.getDeviceLocation();
    return CoordinateEntity(lat: res.latitude, lng: res.longitude);
  }

  Future<StreamSubscription> getLocationStream(
    void Function(CoordinateEntity message) onData,
  ) async {
    final res = await locationRepository.getLocationStream();
    return res.listen((message) {
      onData(CoordinateEntity(lat: message.latitude, lng: message.longitude));
    });
  }
}
