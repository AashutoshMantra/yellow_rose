import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yellow_rose/features/bus/data/models/search/bus_operator_detail.dart';
import 'package:yellow_rose/features/bus/domain/entities/bus_search_filter.dart';

part 'bus_search_filter_state.dart';

class BusSearchFilterCubit extends Cubit<BusSearchFilterState> {
  BusSearchFilterCubit({BusSearchFilterState? busSearchState})
      : super(BusSearchFilterState.initial(busSearchState: busSearchState));

  void onChangeSortBy(BusSortBy? sortBy) {
    if (sortBy == state.sortBy) {
      sortBy = null;
    }
    emit(state.copyWith(sortBy: sortBy));
  }

  void onClickDepartureTimingFilter(BusTiming busTiming) {
    var currentTiming = [...state.departureTiming];
    if (currentTiming.contains(busTiming)) {
      currentTiming.remove(busTiming);
    } else {
      currentTiming.add(busTiming);
    }
    emit(state.copyWith(departureTiming: currentTiming));
  }

  void onClickBusTypeFilter(BusType busType) {
    var currentTypes = [...state.busTypes];
    if (currentTypes.contains(busType)) {
      currentTypes.remove(busType);
    } else {
      currentTypes.add(busType);
    }
    emit(state.copyWith(busTypes: currentTypes));
  }

  void onClickPickupPointFilter(String pickupPoint) {
    var currentPoints = [...state.pickupPoints];
    if (currentPoints.contains(pickupPoint)) {
      currentPoints.remove(pickupPoint);
    } else {
      currentPoints.add(pickupPoint);
    }
    emit(state.copyWith(pickupPoints: currentPoints));
  }

  void onClickDropPointFilter(String dropPoint) {
    var currentPoints = [...state.dropPoints];
    if (currentPoints.contains(dropPoint)) {
      currentPoints.remove(dropPoint);
    } else {
      currentPoints.add(dropPoint);
    }
    emit(state.copyWith(dropPoints: currentPoints));
  }

void onClickOperatorFilter(BusOperatorDetail operatorDetail) {
    var currentOperators = [...state.operators];
    if (currentOperators.contains(operatorDetail)) {
      currentOperators.remove(operatorDetail);
    } else {
      currentOperators.add(operatorDetail);
    }
    emit(state.copyWith(operators: currentOperators));
  }

  void clearAllFilters() {
    emit(const BusSearchFilterState());
  }
}
