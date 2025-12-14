import 'dart:async';

import 'package:flutter/material.dart';
import 'package:map_example/app/pages/map/utils.dart';
import 'package:map_example/core/config.dart';
import 'package:map_example/domain/entities/coordinate_entiry.dart';
import 'package:map_example/domain/entities/map_item_entiry.dart';
import 'package:map_example/domain/repositories/device/location_repository.dart';
import 'package:map_example/domain/usecases/map_usecase.dart';
import 'package:flutter_map/flutter_map.dart';

class MyMapController extends ChangeNotifier {
  final MapUsecase mapUsecase;
  MyMapController(this.mapUsecase) {
    onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onReady();
    });
  }

  final mapController = MapController();
  final defaultLocation = CoordinateEntity(lat: 10.038636, lng: 105.773113);
  CoordinateEntity? currentLocation;
  CoordinateEntity? deviceLocation;
  late double zoom = defaultInitialMapZoomValue;
  StreamSubscription? locationEvent;
  var items = <MapItemEntiry>[];
  MapItemEntiry? selectedItem;
  int runId = 0;
  int get newRunId {
    runId++;
    if (runId > 100000000) {
      runId = 0;
    }
    return runId;
  }

  StreamSubscription? getItemsTask;
  bool loading = false;
  var gettingUserLocation = false;

  void onInit() {}

  void onReady() async {
    initMap();
    _loadLocationStream();
    await _getDeviceLocation();
    _loadItems();
  }

  @override
  void dispose() {
    super.dispose();
    locationEvent?.cancel();
    mapController.dispose();
  }

  void initMap() {
    mapController.mapEventStream.listen((message) {
      currentLocation = message.camera.center.toEntity;
      zoom = message.camera.zoom;
      notifyListeners();
    });
  }

  Future _getDeviceLocation() async {
    try {
      final res = await mapUsecase.getDeviceLocation();

      deviceLocation = res;
      notifyListeners();
    } on PermissionException catch (_) {
      // handle permission error
    } on LocationDisabledException catch (_) {
      // handle location diabled error
    } on TimeoutException catch (_) {
      // handle time out error
    } catch (e) {
      // handle error
    }
  }

  void _loadLocationStream() async {
    try {
      locationEvent = await mapUsecase.getLocationStream((message) {
        currentLocation = message;
        notifyListeners();
      });
    } on PermissionException catch (_) {
      // handle permission error
    } on LocationDisabledException catch (_) {
      // handle location diabled error
    } catch (_) {
      // handle error
    }
  }

  void _loadItems() async {
    if (getItemsTask != null) {
      await getItemsTask?.cancel();
      getItemsTask = null;

      if (loading) {
        loading = false;
        notifyListeners();
      }
    }

    getItemsTask = _loadItemsProcess(newRunId).asStream().listen(
      (res) {
        loading = false;
        final list = res ?? [];
        items.clear();
        while (list.isNotEmpty) {
          final element = list.removeAt(0);

          list.removeWhere(
            (e) => checkOverLap(element.coordinate, e.coordinate, zoom),
          );

          items.add(element);
        }
        notifyListeners();
      },
      onError: (e) {
        // handle error
      },
      onDone: () {
        getItemsTask = null;
      },
    );
  }

  Future<List<MapItemEntiry>?> _loadItemsProcess(int inputRunId) async {
    if (runId != inputRunId) {
      return null;
    }

    if (!loading) {
      loading = true;
      notifyListeners();
    }

    final location = currentLocation ?? defaultLocation;

    final visibleBounds = mapController.camera.visibleBounds;
    final radius = mapUsecase.calculateDistance(
      visibleBounds.center.toEntity,
      visibleBounds.northEast.toEntity,
    );

    return await mapUsecase.getDataFromLocation(
      location: location,
      radius: radius,
    );
  }

  void onPositionChange() async {
    if (getItemsTask != null) {
      newRunId;
      await getItemsTask?.cancel();
      getItemsTask = null;
    }
    loading = false;
    notifyListeners();
  }

  void onMapPointerUp() {
    _loadItems();
  }

  void onMapTap() {
    selectedItem = null;
    notifyListeners();
  }

  void onItemTap(MapItemEntiry item) {
    // to make the marker appear on top
    final temp = item;
    items.remove(item);
    items.add(temp);

    selectedItem = item;
    notifyListeners();
  }

  Future animateTo(CoordinateEntity coordinate, [double? zoomValue]) async {
    zoomValue ??= zoom;
    final latTween = Tween<double>(
      begin: currentLocation?.lat,
      end: coordinate.lat,
    );
    final lngTween = Tween<double>(
      begin: currentLocation?.lng,
      end: coordinate.lng,
    );
    final zoomTween = Tween<double>(begin: zoom, end: zoomValue);
    double index = 0;
    for (var i = 0; i < 20; i++) {
      await Future.delayed(const Duration(milliseconds: 15));
      index = (i + 1) * 0.05;
      mapController.moveAndRotate(
        CoordinateEntity(
          lat: latTween.transform(index),
          lng: lngTween.transform(index),
        ).latLng,
        zoomTween.transform(index),
        0,
      );
    }
    await Future.delayed(Duration(milliseconds: 100));
    currentLocation = coordinate;
    zoom = mapController.camera.zoom;
    notifyListeners();
  }

  void moveTo(CoordinateEntity coordinate, [double? zoomValue]) {
    zoomValue ??= zoom;
    mapController.moveAndRotate(coordinate.latLng, zoomValue, 0);
    currentLocation = coordinate;
    notifyListeners();
  }

  Future animateOrJumpTo(
    CoordinateEntity coordinate, [
    double? zoomValue,
  ]) async {
    if (currentLocation == null) {
      return;
    }
    final distanceFromCurrentLocation = mapUsecase.calculateDistance(
      coordinate,
      currentLocation!,
    );
    if (distanceFromCurrentLocation > 50000) {
      moveTo(coordinate, zoomValue);
    } else {
      await animateTo(coordinate, zoomValue);
    }
  }

  void zoomIn() {
    zoom = mapController.camera.zoom;
    notifyListeners();
    mapController.move(
      currentLocation?.latLng ?? mapController.camera.center,
      zoom + 1,
    );
    _loadItems();
  }

  void zoomOut() {
    zoom = mapController.camera.zoom;
    notifyListeners();
    mapController.move(
      currentLocation?.latLng ?? mapController.camera.center,
      zoom - 1,
    );
    _loadItems();
  }

  Future toUserLocation() async {
    if (gettingUserLocation) {
      // handle notification busy process
    } else {
      gettingUserLocation = true;
      notifyListeners();
      final getUserLocation = await mapUsecase.getDeviceLocation();
      deviceLocation = getUserLocation;
      notifyListeners();
      await animateOrJumpTo(getUserLocation, defaultInitialMapZoomValue);
      _loadItems();
      gettingUserLocation = false;
    }
  }
}
