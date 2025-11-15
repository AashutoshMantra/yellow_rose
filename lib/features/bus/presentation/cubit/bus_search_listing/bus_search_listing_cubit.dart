import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yellow_rose/dependncy_injection.dart';
import 'package:yellow_rose/features/bus/data/models/search/bus_search_response.dart';
import 'package:yellow_rose/features/bus/domain/entities/bus_search.dart';
import 'package:yellow_rose/features/bus/domain/entities/bus_search_filter.dart';
import 'package:yellow_rose/features/bus/domain/usecases/bus_mapper_utility.dart';
import 'package:yellow_rose/features/bus/domain/usecases/bus_usecase.dart';
import 'package:yellow_rose/features/bus/presentation/cubit/bus_search_filter/bus_search_filter_cubit.dart';

part 'bus_search_listing_state.dart';

class BusSearchListingCubit extends Cubit<BusSearchListingState> {
  BusSearchListingCubit(BusSearch busSearch)
      : super(BusSearchListingInitial(busSearch: busSearch));

  final _busUseCase = getIt<BusUseCase>();

  void searchBuses(BusSearch busSearch) async {
    try {
      emit(BusSearchListingLoading(busSearch: busSearch));

      var busSearchResponse = await _busUseCase.getBusSearchResponse(busSearch);

      emit(BusSearchListingLoaded(
        busSearchResponse: busSearchResponse.busSearchResponse ?? [],
        busSearch: busSearch,
      ));
    } catch (e, stackTrace) {
      log("$e $stackTrace");
      emit(BusSearchListingError(e.toString(), busSearch: busSearch));
    }
  }

  void onSelectBus(BusSearchResponse bus) {
    if (state is BusSearchListingLoaded) {
      emit((state as BusSearchListingLoaded).copyWith(selectedBus: bus));
    }
  }

  void onApplyFilters(BusSearchFilterState filterState) {
    if (state is BusSearchListingLoaded) {
      emit(
          (state as BusSearchListingLoaded).copyWith(filterState: filterState));
    }
  }

  List<BusSearchResponse> getFilteredBuses() {
    if (state is! BusSearchListingLoaded) return [];

    final loadedState = state as BusSearchListingLoaded;
    var filteredBuses = loadedState.busSearchResponse;

    // Apply filters
    final filters = loadedState.filterState;

    // Filter by departure timing
    if (filters.departureTiming.isNotEmpty) {
      filteredBuses = filteredBuses.where((bus) {
        if (bus.departureTime == null) return false;
        final hour = bus.departureTime!.hour;
        return filters.departureTiming.any((timing) {
          switch (timing) {
            case BusTiming.EarlyMorning:
              return hour >= 0 && hour < 8;
            case BusTiming.Morning:
              return hour >= 8 && hour < 12;
            case BusTiming.Afternoon:
              return hour >= 12 && hour < 16;
            case BusTiming.Evening:
              return hour >= 16 && hour < 20;
            case BusTiming.Night:
              return hour >= 20 && hour < 24;
          }
        });
      }).toList();
    }

    // Filter by bus type
    if (filters.busTypes.isNotEmpty) {
      filteredBuses = filteredBuses.where((bus) {
        return filters.busTypes.any((type) {
          switch (type) {
            case BusType.AC:
              return bus.aC == true;
            case BusType.NonAC:
              return bus.aC == false;
            case BusType.Seater:
              return bus.seater == true;
            case BusType.Sleeper:
              return bus.sleeper == true;
          }
        });
      }).toList();
    }

    // Filter by pickup points
    if (filters.pickupPoints.isNotEmpty) {
      filteredBuses = filteredBuses.where((bus) {
        return bus.boardingPoint?.any((point) =>
                filters.pickupPoints.contains(point.location ?? '')) ??
            false;
      }).toList();
    }

    // Filter by drop points
    if (filters.dropPoints.isNotEmpty) {
      filteredBuses = filteredBuses.where((bus) {
        return bus.droppingPoint?.any(
                (point) => filters.dropPoints.contains(point.location ?? '')) ??
            false;
      }).toList();
    }

    // Apply sorting
    if (filters.sortBy != null) {
      filteredBuses.sort((a, b) {
        switch (filters.sortBy!) {
          case BusSortBy.EarlyDeparture:
            if (a.departureTime == null || b.departureTime == null) return 0;
            return a.departureTime!.compareTo(b.departureTime!);
          case BusSortBy.LateDeparture:
            if (a.departureTime == null || b.departureTime == null) return 0;
            return b.departureTime!.compareTo(a.departureTime!);
          case BusSortBy.Price:
            final aPrice = a.fare?.first.totalFare ?? 0;
            final bPrice = b.fare?.first.totalFare ?? 0;
            return aPrice.compareTo(bPrice);
        }
      });
    }

    return filteredBuses;
  }

  double getSelectedBusPrice() {
    if (state is BusSearchListingLoaded) {
      final selectedBus = (state as BusSearchListingLoaded).selectedBus;
      return selectedBus?.fare?.first.totalFare ?? 0.0;
    }
    return 0.0;
  }
}
