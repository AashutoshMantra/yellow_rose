import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yellow_rose/core/nullable.dart';
import 'package:yellow_rose/features/flight/domain/entities/search_filter.dart';

part 'flight_search_filter_state.dart';

class FlightSearchFilterCubit extends Cubit<FlightSearchFilterState> {
  FlightSearchFilterCubit({FlightSearchFilterState? flightSearchState})
      : super(FlightSearchFilterState.initial(
            flightSearchState: flightSearchState));

  void onChangeSortBy(AirSortBy? sortBy) {
    if (sortBy == state.sortBy) {
      sortBy = null;
    }
    emit(state.copyWith(sortBy: Nullable(sortBy)));
  }

  void onClickDepartureTimingFilter(FlightTiming flightTiming) {
    var currentTiming = [...state.departure];
    if (currentTiming.contains(flightTiming)) {
      currentTiming.remove(flightTiming);
    } else {
      currentTiming.add(flightTiming);
    }
    emit(state.copyWith(departure: currentTiming));
  }

  void onClickArrivalTimingFilter(FlightTiming flightTiming) {
    var currentTiming = [...state.arrival];
    if (currentTiming.contains(flightTiming)) {
      currentTiming.remove(flightTiming);
    } else {
      currentTiming.add(flightTiming);
    }
    emit(state.copyWith(arrival: currentTiming));
  }

  void onClickAirlineFilter(String airlineCode) {
    var currentTiming = [...state.airlines];
    if (currentTiming.contains(airlineCode)) {
      currentTiming.remove(airlineCode);
    } else {
      currentTiming.add(airlineCode);
    }
    emit(state.copyWith(airlines: currentTiming));
  }
}
