part of 'flight_search_listing_cubit.dart';

sealed class FlightSearchListingState extends Equatable {
  final AirSearch? airSearch;

  const FlightSearchListingState({
    this.airSearch,
  });

  @override
  List<Object?> get props => [];
}

class FlightSearchListingInitial extends FlightSearchListingState {
  const FlightSearchListingInitial({required super.airSearch});
}

class FlightSearchListingLoading extends FlightSearchListingState {
  const FlightSearchListingLoading({required super.airSearch});
}

class FlightSearchListingLoaded extends FlightSearchListingState {
  final List<AirSearchResponse> airSearchResponse;
  final Map<int, AirResponseData> selectedItineraries;
  final int currentIndex;
  final List<FlightSearchFilterState> flightSearchFilterState;

  FlightSearchListingLoaded({
    List<AirSearchResponse>? airSearchResponse,
    Map<int, AirResponseData>? selectedItineraries,
    List<FlightSearchFilterState>? flightSearchFilterState,
    required this.currentIndex,
    required super.airSearch,
  })  : flightSearchFilterState = flightSearchFilterState ?? List.filled(airSearchResponse?.length??0, FlightSearchFilterState()),
        airSearchResponse = airSearchResponse ?? [],
        selectedItineraries = selectedItineraries ?? HashMap();

  FlightSearchListingLoaded copyWith(
      {List<AirSearchResponse>? airSearchResponse,
      Map<int, AirResponseData>? selectedItineraries,
      int? currentIndex,
      List<FlightSearchFilterState>? flightSearchFilterState,
      AirSearch? airSearch}) {
    return FlightSearchListingLoaded(
        flightSearchFilterState:
            flightSearchFilterState ?? this.flightSearchFilterState,
        airSearchResponse: airSearchResponse ?? this.airSearchResponse,
        selectedItineraries: selectedItineraries ?? this.selectedItineraries,
        airSearch: airSearch ?? this.airSearch,
        currentIndex: currentIndex ?? this.currentIndex);
  }

  @override
  List<Object?> get props => [
        airSearchResponse,
        selectedItineraries,
        airSearch,
        currentIndex,
        flightSearchFilterState
      ];
}

class FlightSearchListingError extends FlightSearchListingState {
  final String errorMessage;

  const FlightSearchListingError(this.errorMessage, {required super.airSearch});

  @override
  List<Object> get props => [errorMessage];
}
