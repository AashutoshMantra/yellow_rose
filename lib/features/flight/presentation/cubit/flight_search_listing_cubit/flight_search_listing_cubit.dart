import 'dart:collection';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';
import 'package:yellow_rose/core/utils/date_utils.dart';
import 'package:yellow_rose/dependncy_injection.dart';
import 'package:yellow_rose/features/flight/data/models/airsearch/air_response_data.dart';
import 'package:yellow_rose/features/flight/data/models/airsearch/air_search_request.dart';
import 'package:yellow_rose/features/flight/data/models/airsearch/air_search_response.dart';
import 'package:yellow_rose/features/flight/domain/entities/flight_recent_search.dart';
import 'package:yellow_rose/features/flight/domain/entities/search_filter.dart';
import 'package:yellow_rose/features/flight/domain/usecases/air_usecase.dart';
import 'package:yellow_rose/features/flight/domain/usecases/air_mapper_utility.dart';
import 'package:yellow_rose/features/flight/presentation/cubit/flight_search_filter/flight_search_filter_cubit.dart';
import 'package:yellow_rose/features/trip/data/models/trip_response.dart';

part 'flight_search_listing_state.dart';

class FlightSearchListingCubit extends Cubit<FlightSearchListingState> {
  FlightSearchListingCubit(AirSearch airSearch)
      : super(FlightSearchListingInitial(airSearch: airSearch));
  final _airUsecase = getIt<AirUseCase>();

  void searchFlights(AirSearch airSearch, {TripResponse? trip}) async {
    try {
      emit(FlightSearchListingLoading(airSearch: airSearch));

      var airSearchRequest = AirMapperUtility.mapFlightStateToAirSearchRequest(
          airSearch,
          trip: null);
      var airSearchResponse =
          await _airUsecase.getAirSearchResponse(airSearchRequest);
      var selectedItinararis = HashMap<int, AirResponseData>();
      if (airSearchResponse.isEmpty ||
          airSearchResponse.any((test) => test.flights.isEmpty)) {
        emit(FlightSearchListingLoaded(
            airSearch: airSearch,
            airSearchResponse: airSearchResponse,
            selectedItineraries: selectedItinararis,
            currentIndex: 0));
        return;
      }
      airSearchResponse.forEachIndexed((idx, searchResponse) {
        selectedItinararis[idx] = searchResponse.flights[0];
      });
      emit(FlightSearchListingLoaded(
          airSearch: airSearch,
          airSearchResponse: airSearchResponse,
          selectedItineraries: selectedItinararis,
          currentIndex: 0));
    } catch (e, stackTrace) {
      log("$e $stackTrace");
      emit(FlightSearchListingError(e.toString(), airSearch: airSearch));
    }
  }

  void onSelectItinerary(int index, AirResponseData itinerary) {
    if (state is FlightSearchListingLoaded) {
      var currSelected = Map<int, AirResponseData>.from(
          (state as FlightSearchListingLoaded).selectedItineraries);
      currSelected[index] = itinerary;
      emit((state as FlightSearchListingLoaded)
          .copyWith(selectedItineraries: currSelected));
    }
  }

  void onIndexChange(int index) {
    if (state is FlightSearchListingLoaded) {
      emit((state as FlightSearchListingLoaded).copyWith(currentIndex: index));
    }
  }

  bool isSelected(AirResponseData flights) {
    if (state is FlightSearchListingLoaded) {
      var currSelected =
          (state as FlightSearchListingLoaded).selectedItineraries;
      var joinedNameHere = flights.flightDetailsList
          .map((d) => d.carrierName + d.flightNumber)
          .join("");
      var isSeelcted = currSelected.values.any((selectedAir) {
        var joinedName = selectedAir.flightDetailsList
            .map((d) => d.carrierName + d.flightNumber)
            .join("");

        return joinedNameHere == joinedName;
      });
      return isSeelcted;
    }
    return false;
  }

  double getTotalCost() {
    if (state is FlightSearchListingLoaded) {
      var selectedFLightCosts = (state as FlightSearchListingLoaded)
          .selectedItineraries
          .values
          .map((flight) => flight.fare.first.totalCost)
          .reduce((a, b) => a + b);
      return selectedFLightCosts;
    }
    return 0.0;
  }

  double getTotalCostAtIndex(int index) {
    if (state is FlightSearchListingLoaded) {
      var selectedFLightCosts = (state as FlightSearchListingLoaded)
          .selectedItineraries[index]!
          .fare
          .first
          .totalCost;

      return selectedFLightCosts;
    }
    return 0.0;
  }

  void onFlightFilterChange(
    FlightSearchFilterState? flightSearchFilter,
  ) {
    if (state is FlightSearchListingLoaded) {
      int currentIdx = (state as FlightSearchListingLoaded).currentIndex;
      var newState = [
        ...(state as FlightSearchListingLoaded).flightSearchFilterState
      ];
      newState[currentIdx] = flightSearchFilter ?? FlightSearchFilterState();
      emit((state as FlightSearchListingLoaded)
          .copyWith(flightSearchFilterState: newState));
      var filteredData = getFilteredData();
      if (filteredData.isNotEmpty) {
        onSelectItinerary(currentIdx, filteredData.first);
      }
    }
  }

  bool isInFlightTiming(DateTime time, FlightTiming timing) {
    final hour = time.hour;
    switch (timing) {
      case FlightTiming.EarlyMorning:
        return hour >= 0 && hour < 8;
      case FlightTiming.Morning:
        return hour >= 8 && hour < 12;
      case FlightTiming.AfterMorning:
        return hour >= 12 && hour < 16;
      case FlightTiming.Evening:
        return hour >= 16 && hour < 20;
      case FlightTiming.Mignight:
        return hour >= 20 && hour < 24;
    }
  }

  List<AirResponseData> getFilteredData() {
    if (state is FlightSearchListingLoaded) {
      int currentIdx = (state as FlightSearchListingLoaded).currentIndex;
      var flights = (state as FlightSearchListingLoaded)
          .airSearchResponse[currentIdx]
          .flights;

      var criteria = (state as FlightSearchListingLoaded)
          .flightSearchFilterState[currentIdx];

      List<AirResponseData> filtered = flights.where((flight) {
        // Airline Filter
        if (criteria.airlines.isNotEmpty) {
          final airlineCodes =
              flight.flightDetailsList.map((f) => f.carrierName).toSet();
          if (airlineCodes.intersection(criteria.airlines.toSet()).isEmpty) {
            return false;
          }
        }

        // Departure Time Filter
        if (criteria.departure.isNotEmpty) {
          bool matches = criteria.departure.any(
            (timing) => isInFlightTiming(flight.schDepartureTime!, timing),
          );
          if (!matches) return false;
        }

        // Arrival Time Filter
        if (criteria.arrival.isNotEmpty) {
          bool matches = criteria.arrival.any(
            (timing) => isInFlightTiming(flight.schArrivalTime!, timing),
          );
          if (!matches) return false;
        }

        return true;
      }).toList();

      // Sorting
      if (criteria.sortBy != null) {
        switch (criteria.sortBy!) {
          case AirSortBy.EarlyDeparture:
            filtered.sort(
                (a, b) => a.schDepartureTime!.compareTo(b.schDepartureTime!));
            break;
          case AirSortBy.LateDeparture:
            filtered.sort(
                (a, b) => b.schDepartureTime!.compareTo(a.schDepartureTime!));
            break;
          case AirSortBy.EarlyArrival:
            filtered
                .sort((a, b) => a.schArrivalTime!.compareTo(b.schArrivalTime!));
            break;
          case AirSortBy.LateArrival:
            filtered
                .sort((a, b) => b.schArrivalTime!.compareTo(a.schArrivalTime!));
            break;
          case AirSortBy.Price:
            filtered.sort((a, b) {
              final aPrice = a.fare.firstOrNull?.baseFare ?? 0;
              final bPrice = b.fare.firstOrNull?.baseFare ?? 0;
              return aPrice.compareTo(bPrice);
            });
            break;
        }
      }

      return filtered;
    }
    return [];
  }
}
