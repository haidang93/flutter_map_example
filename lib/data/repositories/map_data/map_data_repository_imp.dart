import 'package:map_example/data/repositories/map_data/models/map_item_model.dart';
import 'package:map_example/data/repositories/map_items_fake_data.dart';
import 'package:map_example/domain/entities/coordinate_entiry.dart';
import 'package:map_example/domain/entities/map_item_entiry.dart';
import 'package:map_example/domain/repositories/map_data_repository.dart';

class MapDataRepositoryImp implements MapDataRepository {
  @override
  Future<List<MapItemEntiry>> getMapItems({
    required CoordinateEntiry location,
  }) async {
    final json = _mimicFetchDataFromServer();

    final data = json.map((e) => MapItemModel.fromJson(e));

    // simulate API call task
    await Future.delayed(const Duration(milliseconds: 1000));
    final res = List.generate(data.length, (i) => data.elementAt(i).toEntity());
    return res;
  }

  List<Map<String, dynamic>> _mimicFetchDataFromServer() => mapItemsFakeData;
}
