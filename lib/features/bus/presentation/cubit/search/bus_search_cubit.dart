import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yellow_rose/dependncy_injection.dart';
import 'package:yellow_rose/features/bus/data/models/search/bus_city_response.dart';
import 'package:yellow_rose/features/bus/domain/entities/bus_search.dart';
import 'package:yellow_rose/features/bus/domain/usecases/bus_usecase.dart';

part 'bus_search_state.dart';

class BusSearchCubit extends Cubit<BusSearchState> {
  BusSearchCubit() : super(BusSearchState.initial());
  final busUseCase = getIt<BusUseCase>();

  void loadInitial({BusSearch? busSearch}) async {
    try {
      var busCities = await busUseCase.getBusCities();
      if (busSearch != null) {
        emit(BusSearchState.initial(busSearch: busSearch));
        return;
      }
      var source = busCities.firstWhere(
        (city) => city.cityLabel?.toLowerCase().contains("hyderabad") == true,
        orElse: () =>
            busCities.isNotEmpty ? busCities[0] : BusCityResponse(id: 0),
      );
      var destination = busCities.firstWhere(
        (city) => city.cityLabel?.toLowerCase().contains("bangalore") == true,
        orElse: () =>
            busCities.length > 1 ? busCities[1] : BusCityResponse(id: 0),
      );
      emit(BusSearchState(
        source: source,
        destination: destination,
        dateOfJourney: DateTime.now().add(const Duration(days: 1)),
        isLoading: false,
      ));
    } catch (e, s) {
      log("$e, $s");
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }

  void onSourceChange(BusCityResponse source) {
    emit(state.copyWith(source: source));
  }

  void onDestinationChange(BusCityResponse destination) {
    emit(state.copyWith(destination: destination));
  }

  void onDateChange(DateTime date) {
    emit(state.copyWith(dateOfJourney: date));
  }

  void updateFromBusSearch(BusSearch busSearch) {
    emit(state.copyWith(
      source: busSearch.source,
      destination: busSearch.destination,
      dateOfJourney: busSearch.dateOfJourney,
    ));
  }

  BusSearch getBusSearch() {
    return BusSearch(
      source: state.source,
      destination: state.destination,
      dateOfJourney: state.dateOfJourney,
    );
  }
}
