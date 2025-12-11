import 'package:map_example/domain/entities/coordinate_entiry.dart';
import 'package:map_example/domain/entities/map_item_entiry.dart';

class MapItemModel {
  final String id;
  final String name;
  final String type;
  final CoordinateEntiry coordinate;

  MapItemModel({
    required this.id,
    required this.name,
    required this.type,
    required this.coordinate,
  });

  factory MapItemModel.fromJson(Map<String, dynamic> json) {
    return MapItemModel(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      coordinate: CoordinateEntiry(
        lat: json['coordinate']['lat'],
        lng: json['coordinate']['lng'],
      ),
    );
  }

  MapItemEntiry toEntity() => MapItemEntiry(
    id: id,
    name: name,
    type: MapItemTypeEnum.parse(type),
    coordinate: coordinate,
  );
}
