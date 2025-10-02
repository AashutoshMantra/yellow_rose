import 'dart:developer';
import 'dart:collection';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yellow_rose/core/constants/supported_service.dart';
import 'package:yellow_rose/dependncy_injection.dart';
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

      // Deduplicate loaded lists using structural equality while preserving order
      final dedupedAir =
          LinkedHashSet<AirSearch>.from(airRecentSearch).toList();
      final dedupedHotel =
          LinkedHashSet<HotelSearch>.from(hotelRecentSearch).toList();

      // If duplicates were removed, persist the cleaned lists
      if (dedupedAir.length != airRecentSearch.length) {
        await _recentSearchRepo.saveAirRecentSearches(dedupedAir);
      }
      if (dedupedHotel.length != hotelRecentSearch.length) {
        await _recentSearchRepo.saveHotelRecentSearches(dedupedHotel);
      }

      emit(HomeScreenLoaded(0,
          recentAirSearch: dedupedAir, recentHotelSearch: dedupedHotel));
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
    }
    return recentSearches;
  }

  void setSelectedPage(int idx) {
    if (state is HomeScreenLoaded) {
      emit((state as HomeScreenLoaded).copyWith(selectedPage: idx));
    }
  }
}
