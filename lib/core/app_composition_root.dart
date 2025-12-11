import 'package:map_example/data/repositories/map_data/map_data_repository_imp.dart';
import 'package:map_example/device/repositories/location_repository_imp.dart';
import 'package:map_example/domain/usecases/map_usecase.dart';

class AppCompositionRoot {
  final repositories = AppRepositories();
  late final usecases = AppUsecases(repositories);
}

/// Declare repositories
class AppRepositories {
  final mapDataRepository = MapDataRepositoryImp();
  final locationRepository = LocationRepositoryImp();
}

/// Declare usecases
class AppUsecases {
  final AppRepositories appRepositories;

  AppUsecases(this.appRepositories);

  late final mapUsecase = MapUsecase(
    mapDataRepository: appRepositories.mapDataRepository,
    locationRepository: appRepositories.locationRepository,
  );
}
