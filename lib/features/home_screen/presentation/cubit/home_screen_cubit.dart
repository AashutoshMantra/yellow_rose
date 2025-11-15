import 'dart:developer';
import 'dart:collection';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yellow_rose/core/constants/supported_service.dart';
import 'package:yellow_rose/dependncy_injection.dart';
import 'package:yellow_rose/features/bus/domain/entities/bus_search.dart';
import 'package:yellow_rose/features/flight/domain/entities/flight_recent_search.dart';
import 'package:yellow_rose/features/home_screen/domain/usecases/recent_search_usecase.dart';
import 'package:yellow_rose/features/hotel/domain/entities/hotel_search.dart';

part 'home_screen_state.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {
  HomeScreenCubit() : super(const HomeScreenInitial(0));
  final _recentSearchRepo = getIt<RecentSearchUseCase>();

  void loadRecentSearch() async {
    try {
      var airRecentSearch = await _recentSearchRepo.getAirRecentSearch();
      var hotelRecentSearch = await _recentSearchRepo.getHotelRecentSearch();
      var busRecentSearch = await _recentSearchRepo.getBusRecentSearch();

      // Deduplicate loaded lists using structural equality while preserving order
      final dedupedAir =
          LinkedHashSet<AirSearch>.from(airRecentSearch).toList();
      final dedupedHotel =
          LinkedHashSet<HotelSearch>.from(hotelRecentSearch).toList();
      final dedupedBus =
          LinkedHashSet<BusSearch>.from(busRecentSearch).toList();

      // If duplicates were removed, persist the cleaned lists
      if (dedupedAir.length != airRecentSearch.length) {
        await _recentSearchRepo.saveAirRecentSearches(dedupedAir);
      }
      if (dedupedHotel.length != hotelRecentSearch.length) {
        await _recentSearchRepo.saveHotelRecentSearches(dedupedHotel);
      }
      if (dedupedBus.length != busRecentSearch.length) {
        await _recentSearchRepo.saveBusRecentSearches(dedupedBus);
      }

      emit(HomeScreenLoaded(0,
          recentAirSearch: dedupedAir,
          recentHotelSearch: dedupedHotel,
          recentBusSearch: dedupedBus));
    } catch (e, stackTrace) {
      log(stackTrace.toString());
      emit(HomeScreenError(e.toString()));
    }
  }

  void saveAirRecentSearches(AirSearch airSearch) {
    if (state is HomeScreenLoaded) {
      var airRecentSearch = [...(state as HomeScreenLoaded).recentAirSearch];
      // Deduplicate using structural equality implemented on AirSearch
      airRecentSearch.removeWhere((e) => e == airSearch);
      // Insert most recent at front
      airRecentSearch.insert(0, airSearch);
      _recentSearchRepo.saveAirRecentSearches(airRecentSearch);
      emit(HomeScreenLoaded(0, recentAirSearch: airRecentSearch));
    }
  }

  void saveHotelRecentSearches(HotelSearch hotelSearch) {
    if (state is HomeScreenLoaded) {
      var hotelRecentSearch = [
        ...(state as HomeScreenLoaded).recentHotelSearch
      ];
      // Deduplicate using structural equality implemented on HotelSearch
      hotelRecentSearch.removeWhere((e) => e == hotelSearch);
      hotelRecentSearch.insert(0, hotelSearch);
      _recentSearchRepo.saveHotelRecentSearches(hotelRecentSearch);
      emit(HomeScreenLoaded(0, recentHotelSearch: hotelRecentSearch));
    }
  }

  void saveBusRecentSearches(BusSearch busSearch) {
    if (state is HomeScreenLoaded) {
      var busRecentSearch = [...(state as HomeScreenLoaded).recentBusSearch];
      // Deduplicate using structural equality implemented on BusSearch
      busRecentSearch.removeWhere((e) => e == busSearch);
      busRecentSearch.insert(0, busSearch);
      _recentSearchRepo.saveBusRecentSearches(busRecentSearch);
      emit(HomeScreenLoaded(0, recentBusSearch: busRecentSearch));
    }
  }

  List<dynamic> getRecentSearchesData(
      {List<SupportedService>? supportedService}) {
    List<dynamic> recentSearches = [];
    if (state is HomeScreenLoaded) {
      if (supportedService == null ||
          supportedService.contains(SupportedService.Flights)) {
        recentSearches.addAll((state as HomeScreenLoaded).recentAirSearch);
      }
      if (supportedService == null ||
          supportedService.contains(SupportedService.Hotels)) {
        recentSearches.addAll((state as HomeScreenLoaded).recentHotelSearch);
      }
      if (supportedService == null ||
          supportedService.contains(SupportedService.Buses)) {
        recentSearches.addAll((state as HomeScreenLoaded).recentBusSearch);
      }
    }
    return recentSearches;
  }

  void setSelectedPage(int idx) {
    if (state is HomeScreenLoaded) {
      emit((state as HomeScreenLoaded).copyWith(selectedPage: idx));
    }
  }
}
