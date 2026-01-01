import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_google_maps_webservices/places.dart';
import 'package:get_it/get_it.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:yellow_rose/core/app_config.dart';
import 'package:yellow_rose/core/utils/dio_client.dart';
import 'package:yellow_rose/core/utils/remote_config_service.dart';
import 'package:yellow_rose/core/utils/shared_pref_repository.dart';
import 'package:yellow_rose/features/auth/data/datasources/auth_service.dart';
import 'package:yellow_rose/features/auth/data/datasources/auth_local_service.dart';
import 'package:yellow_rose/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:yellow_rose/features/auth/domain/repositories/auth_repo.dart';
import 'package:yellow_rose/features/auth/domain/usecases/auth_use_case.dart';
import 'package:yellow_rose/features/bus/data/datasources/bus_local_service.dart';
import 'package:yellow_rose/features/bus/data/datasources/bus_service.dart';
import 'package:yellow_rose/features/bus/data/repositories/bus_repo_impl.dart';
import 'package:yellow_rose/features/bus/domain/repositories/bus_repository.dart';
import 'package:yellow_rose/features/bus/domain/usecases/bus_usecase.dart';
import 'package:yellow_rose/features/flight/data/datasources/air_local_service.dart';
import 'package:yellow_rose/features/flight/data/datasources/air_searvice.dart';
import 'package:yellow_rose/features/flight/data/repositories/air_repository_impl.dart';
import 'package:yellow_rose/features/flight/domain/repositories/air_repository.dart';
import 'package:yellow_rose/features/flight/domain/usecases/air_usecase.dart';
import 'package:yellow_rose/features/home_screen/data/datasources/recent_search_local_service.dart';
import 'package:yellow_rose/features/home_screen/data/repositories/recent_search_repo_impl.dart';
import 'package:yellow_rose/features/home_screen/domain/repositories/recent_search_repo.dart';
import 'package:yellow_rose/features/home_screen/domain/usecases/recent_search_usecase.dart';
import 'package:yellow_rose/features/hotel/data/datasources/hotel_service.dart';
import 'package:yellow_rose/features/hotel/data/datasources/place_service.dart';
import 'package:yellow_rose/features/hotel/data/repositories/hotel_repositoy_impl.dart';
import 'package:yellow_rose/features/hotel/data/repositories/place_repository_impl.dart';
import 'package:yellow_rose/features/hotel/domain/repositories/hotel_repository.dart';
import 'package:yellow_rose/features/hotel/domain/repositories/place_repository.dart';
import 'package:yellow_rose/features/hotel/domain/usecases/hotel_book_use_case.dart';
import 'package:yellow_rose/features/hotel/domain/usecases/hotel_search_case.dart';
import 'package:yellow_rose/features/trip/data/datasources/trip_service.dart';
import 'package:yellow_rose/features/trip/data/repositories/trip_repository_impl.dart';
import 'package:yellow_rose/features/trip/domain/repositories/trip_repository.dart';
import 'package:yellow_rose/features/trip/domain/usecases/trip_usecase.dart';
import 'package:yellow_rose/features/trip/domain/usecases/trip_usecase_impl.dart';

final getIt = GetIt.instance;
Future setupDependencyInjection() async {
  var headers = await const GoogleApiHeaders().getHeaders();
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

  //HOTEL
  getIt.registerLazySingleton<HotelService>(() => HotelServiceImpl());
  getIt.registerLazySingleton<HotelRepository>(() => HotelRepositoryImpl());
  getIt.registerLazySingleton<PlaceDataSource>(() => PlaceDataSourceImpl());
  getIt.registerLazySingleton<PlaceRepository>(() => PlaceRepositoryImpl());
  getIt.registerLazySingleton<HotelSearchCase>(() => HotelSearchCaseImpl());
  getIt.registerLazySingleton<GoogleMapsPlaces>(() => GoogleMapsPlaces(
        apiKey: AppConfig.instance.googleApiKey,
      ));
  getIt.registerLazySingleton<HotelBookUseCase>(() => HotelBookUseCaseImpl());

  //BUS
  //TRIP
  getIt.registerLazySingleton<TripService>(() => TripServiceImpl());
  getIt.registerLazySingleton<TripRepository>(() => TripRepositoryImpl());
  getIt.registerLazySingleton<TripUseCase>(() => TripUseCaseImpl());

  getIt.registerLazySingleton<BusService>(() => BusServiceImpl());
  getIt.registerLazySingleton<BusLocalService>(() => BusLocalServiceImpl());
  getIt.registerLazySingleton<BusRepository>(() => BusRepositoryImpl());
  getIt.registerLazySingleton<BusUseCase>(() => BusUseCaseImpl());

  try {
    await Firebase.initializeApp();
  } catch (e, s) {
    log("$e $s");
  }
  var futures = [
    RemoteConfigService().initialize(),
    SharedPreferencesRepository.init(),
  ];
  await Future.wait(futures);
}
