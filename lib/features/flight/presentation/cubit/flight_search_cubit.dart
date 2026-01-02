import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:yellow_rose/core/nullable.dart';
import 'package:yellow_rose/dependncy_injection.dart';
import 'package:yellow_rose/features/flight/data/models/airports.dart';
import 'package:yellow_rose/features/flight/domain/entities/flight_recent_search.dart';
import 'package:yellow_rose/features/flight/domain/entities/name_code.dart';
import 'package:yellow_rose/features/flight/domain/entities/source_date_pair.dart';
import 'package:yellow_rose/features/flight/domain/usecases/air_usecase.dart';

part 'flight_search_state.dart';

class FlightSearchCubit extends Cubit<FlightSearchState> {
  FlightSearchCubit() : super(FlightSearchState.initial());
  final airUseCase = getIt<AirUseCase>();

  void loadInitial({AirSearch? airSearch}) async {
    try {
      var airPorts = await airUseCase.getAirports();
      if (airSearch != null) {
        emit(FlightSearchState.initial(airSearch: airSearch));
        return;
      }
      var sources = List<SourceDestinationDatePair>.empty(growable: true);
      var source =
          airPorts.firstWhereOrNull((airport) => airport.iataCode == "DEL");
      var destination =
          airPorts.firstWhereOrNull((airport) => airport.iataCode == "BOM");
      if (source == null && airPorts.isNotEmpty) {
        source = airPorts[0];
      }
      if (destination == null && airPorts.isNotEmpty) {
        destination = airPorts.last;
      }
      sources.add(
          SourceDestinationDatePair(source: source, destination: destination));
      if (sources.isNotEmpty) {
        sources[0] = sources[0].copyWith(
            sourceDate: state.sources[0].sourceDate,
            returnDate: Nullable(state.sources[0].returnDate));
      }

      emit(FlightSearchState(
          sources: sources,
          isLoading: false,
          adultCount: 1,
          searchClass: FlightSearchClass.Economy));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  void onSourceChange(Airport airport, int idx) {
    var currState = state;
    var sources = currState.sources;

    var newSource = [...sources];
    // If selecting same airport as destination, clear destination
    if (sources[idx].destination?.iataCode == airport.iataCode) {
      newSource[idx] = SourceDestinationDatePair(
        source: airport,
        destination: null,
        sourceDate: sources[idx].sourceDate,
        returnDate: sources[idx].returnDate,
      );
    } else {
      newSource[idx] = sources[idx].copyWith(source: airport);
    }
    emit(currState.copyWith(sources: newSource));
  }

  void onDestinationChange(Airport airport, idx) {
    var currState = state;
    var sources = currState.sources;

    var newSource = [...sources];
    // If selecting same airport as source, clear source
    if (sources[idx].source?.iataCode == airport.iataCode) {
      newSource[idx] = SourceDestinationDatePair(
        source: null,
        destination: airport,
        sourceDate: sources[idx].sourceDate,
        returnDate: sources[idx].returnDate,
      );
    } else {
      newSource[idx] = sources[idx].copyWith(destination: airport);
    }
    emit(currState.copyWith(sources: newSource));
  }

  void swapSourceDestination(int idx) {
    var currState = state;
    var sources = currState.sources;
    if (sources[idx].source == null || sources[idx].destination == null) {
      return;
    }
    var newSource = [...sources];
    newSource[idx] = sources[idx].copyWith(
      source: sources[idx].destination,
      destination: sources[idx].source,
    );
    emit(currState.copyWith(sources: newSource));
  }

  void onSourceDateChange(DateTime? date) {
    var currState = state;
    var sources = currState.sources;

    var newSource = [...sources];

    newSource[0] = sources[0].copyWith(sourceDate: date);

    emit(currState.copyWith(sources: newSource));
  }

  void onReturnDateChange(DateTime? date) {
    var currState = state;
    var sources = currState.sources[0];
    var newSource = [
      ...[sources]
    ];

    newSource[0] = [sources][0].copyWith(returnDate: Nullable(date));

    emit(currState.copyWith(sources: newSource));
  }

  void onMultiCityChange() {
    var currState = state;
    var sources = currState.sources;
    var newSource = [...sources];
    if (sources[0].returnDate != null) {
      newSource[0] = sources[0].copyWith(returnDate: const Nullable(null));
    }
    if (sources[sources.length - 1].destination != null &&
        sources[sources.length - 1].sourceDate != null) {
      var addedSource = SourceDestinationDatePair(
          source: sources[sources.length - 1].destination,
          sourceDate: sources[sources.length - 1]
              .sourceDate!
              .add(const Duration(days: 2)));
      newSource.add(addedSource);

      emit(currState.copyWith(sources: newSource));
    } else {
      throw "Please Enter Destination And Date of previous selection";
    }
  }

  void removeMultiCity(int idx) {
    var currState = state;
    var sources = currState.sources;
    if (sources.length > 1) {
      var newSource = [...sources];
      newSource.removeAt(idx);
      emit(currState.copyWith(sources: newSource));
    }
  }

  void onChildChange(int count) {
    var currState = state;
    emit(currState.copyWith(childCount: count));
  }

  void onAdultChange(int count) {
    var currState = state;
    emit(currState.copyWith(adultCount: count));
  }

  void onInfantChange(int count) {
    var currState = state;
    emit(currState.copyWith(infantCount: count));
  }

  void onClassChange(FlightSearchClass classs) {
    var currState = state;
    emit(currState.copyWith(searchClass: classs));
  }

  void onPreferredCarrierChange(NameCode? carrier) {
    var currState = state;
    emit(currState.copyWith(preferredCarrier: Nullable(carrier)));
  }

  void onDirectFlightChange(bool value) {
    var currState = state;
    emit(currState.copyWith(directFlight: value));
  }

  void clearError() {
    emit(state.copyWith(error: null));
  }

  AirSearch getAirSearch() {
    return AirSearch(
      adultCount: state.adultCount,
      sources: state.sources,
      childCount: state.childCount,
      infantCount: state.infantCount,
      searchClass: state.searchClass,
      preferredCarrier: state.preferredCarrier,
      directFlight: state.directFlight,
    );
  }
}
