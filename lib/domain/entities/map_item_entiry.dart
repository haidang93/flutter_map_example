import 'package:map_example/domain/entities/coordinate_entiry.dart';

enum MapItemTypeEnum {
  unknown('unknown', "Unknown"),
  services('services', "Services"),
  foodAndDrink('food_and_drink', "Food and Drink"),
  business('business', "Business"),
  shopping('shopping', "Shopping"),
  government('government', "Government");

  final String code;
  final String label;
  const MapItemTypeEnum(this.code, this.label);

  static MapItemTypeEnum parse(String? value) =>
      values.firstWhere((e) => e.code == value, orElse: () => unknown);
}

class MapItemEntiry {
  final String id;
  final String name;
  final MapItemTypeEnum type;
  final CoordinateEntiry coordinate;

  MapItemEntiry({
    required this.id,
    required this.name,
    required this.type,
    required this.coordinate,
  });
}
