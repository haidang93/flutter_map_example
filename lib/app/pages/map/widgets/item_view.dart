import 'package:flutter/material.dart';
import 'package:map_example/domain/entities/map_item_entiry.dart';

class ItemView extends StatelessWidget {
  const ItemView({super.key, required this.mapItem});
  final MapItemEntiry mapItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color.fromARGB(255, 227, 229, 230),
      ),
      child: Icon(icon(), color: iconColor()),
    );
  }

  IconData icon() {
    switch (mapItem.type) {
      case MapItemTypeEnum.business:
        return Icons.business_rounded;
      case MapItemTypeEnum.foodAndDrink:
        return Icons.fastfood_rounded;
      case MapItemTypeEnum.government:
        return Icons.account_balance_rounded;
      case MapItemTypeEnum.services:
        return Icons.local_laundry_service_rounded;
      case MapItemTypeEnum.shopping:
        return Icons.shopping_bag_rounded;
      default:
        return Icons.star;
    }
  }

  Color iconColor() {
    switch (mapItem.type) {
      case MapItemTypeEnum.business:
        return const Color.fromARGB(255, 26, 18, 146);
      case MapItemTypeEnum.foodAndDrink:
        return const Color.fromARGB(255, 194, 51, 51);
      case MapItemTypeEnum.government:
        return const Color.fromARGB(255, 163, 154, 22);
      case MapItemTypeEnum.services:
        return const Color.fromARGB(255, 44, 151, 67);
      case MapItemTypeEnum.shopping:
        return const Color.fromARGB(255, 138, 31, 129);
      default:
        return Colors.black;
    }
  }
}
