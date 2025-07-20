import 'package:get_it/get_it.dart';
import 'package:yellow_rose/core/utils/dio_client.dart';
import 'package:yellow_rose/core/utils/shared_pref_repository.dart';
import 'package:yellow_rose/features/auth/data/datasources/auth_service.dart';
import 'package:yellow_rose/features/auth/data/datasources/auth_local_service.dart';
import 'package:yellow_rose/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:yellow_rose/features/auth/domain/repositories/auth_repo.dart';
import 'package:yellow_rose/features/auth/domain/usecases/auth_use_case.dart';
import 'package:yellow_rose/features/flight/data/datasources/air_local_service.dart';
import 'package:yellow_rose/features/flight/data/datasources/air_searvice.dart';
import 'package:yellow_rose/features/flight/data/repositories/air_repository_impl.dart';
import 'package:yellow_rose/features/flight/domain/repositories/air_repository.dart';
import 'package:yellow_rose/features/flight/domain/usecases/air_usecase.dart';
import 'package:yellow_rose/features/home_screen/data/datasources/recent_search_local_service.dart';
import 'package:yellow_rose/features/home_screen/data/repositories/recent_search_repo_impl.dart';
import 'package:yellow_rose/features/home_screen/domain/repositories/recent_search_repo.dart';
import 'package:yellow_rose/features/home_screen/domain/usecases/recent_search_usecase.dart';

final getIt = GetIt.instance;
Future setupDependencyInjection() async {
  getIt.registerLazySingleton<DioClient>(() => DioClient());
  getIt.registerLazySingleton<AuthService>(() => AuthServiceIml());
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl());
  getIt.registerLazySingleton<AuthLocalService>(() => AuthLocalServiceImpl());
  getIt.registerLazySingleton<IAuthUseCase>(() => AuthUseCase());
  getIt.registerLazySingleton<RecentSearchLocalService>(
      () => RecentSearchLocalServiceImpl());
  getIt.registerLazySingleton<RecentSearchRepo>(() => RecentSearchRepoImpl());
  getIt.registerLazySingleton<RecentSearchUseCase>(
      () => RecentSearchUseCaseImpl());

  getIt.registerLazySingleton<AirService>(() => AirServiceImpl());
  getIt.registerLazySingleton<AirLocalService>(() => AirLocalServiceImpl());

  getIt.registerLazySingleton<AirRepository>(() => AirRepositoryImpl());
  getIt.registerLazySingleton<AirUseCase>(() => AirUseCaseImpl());

  // getIt.registerLazySingleton<GoalRemindersUseCase>(
  //     () => GoalRemindersUseCaseImpl());

  var futures = [
    SharedPreferencesRepository.init(),
  ];
  await Future.wait(futures);
}
