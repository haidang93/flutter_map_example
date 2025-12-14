import 'package:map_example/domain/entities/coordinate_entiry.dart';
import 'package:map_example/domain/entities/map_item_entiry.dart';

abstract class MapDataRepository {
  /// get map items that are inside the radius from the current location
  Future<List<MapItemEntiry>> getMapItems({required CoordinateEntity location});
}
