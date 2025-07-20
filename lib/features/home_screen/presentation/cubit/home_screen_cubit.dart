import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yellow_rose/core/constants/supported_service.dart';
import 'package:yellow_rose/dependncy_injection.dart';
import 'package:yellow_rose/features/flight/domain/entities/flight_recent_search.dart';
import 'package:yellow_rose/features/home_screen/domain/usecases/recent_search_usecase.dart';

part 'home_screen_state.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {
  HomeScreenCubit() : super(const HomeScreenInitial(0));
  final _recentSearchRepo = getIt<RecentSearchUseCase>();

  void loadRecentSearch() async {
    try {
      var airRecentSearch = await _recentSearchRepo.getAirRecentSearch();
      emit(HomeScreenLoaded(0, recentAirSearch: airRecentSearch));
    } catch (e, stackTrace) {
      log(stackTrace.toString());
      emit(HomeScreenError(e.toString()));
    }
  }

  void saveAirRecentSearches(AirSearch airSearch) {
    if (state is HomeScreenLoaded) {
      var airRecentSearch = [...(state as HomeScreenLoaded).recentAirSearch];
      airRecentSearch.add(airSearch);
      _recentSearchRepo.saveAirRecentSearches(airRecentSearch);
      emit(HomeScreenLoaded(0, recentAirSearch: airRecentSearch));
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
    }
    return recentSearches;
  }

  void setSelectedPage(int idx) {
    if (state is HomeScreenLoaded) {
      emit((state as HomeScreenLoaded).copyWith(selectedPage: idx));
    }
  }
}
