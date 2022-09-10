import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:tyba_test/src/repository/endpoints/university_repository.dart';

import 'src/repository/network/api_repository.dart';

late GetIt global;

void setUpGlobalLocator() {
  global = GetIt.I;
  global.registerLazySingleton<Logger>(() => Logger());
  global.registerLazySingleton<APIRepository>(() => DefaultAPIRepository());
  global.registerLazySingleton<UniversityRepository>(
      () => UniversityRepositoryDefault());
}
