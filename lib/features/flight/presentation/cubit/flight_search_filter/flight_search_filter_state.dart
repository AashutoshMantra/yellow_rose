part of 'flight_search_filter_cubit.dart';

class FlightSearchFilterState extends Equatable {
  final AirSortBy? sortBy;
  final List<FlightTiming> departure;
  final List<FlightTiming> arrival;
  final List<String> airlines;
  FlightSearchFilterState({
    this.sortBy,
    List<FlightTiming>? departure,
    List<FlightTiming>? arrival,
    List<String>? airlines,
  })  : departure = departure ?? [],
        arrival = arrival ?? [],
        airlines = airlines ?? [];

  @override
  List<Object?> get props => [sortBy, departure, arrival, airlines];

  factory FlightSearchFilterState.initial(
      {FlightSearchFilterState? flightSearchState}) {
    if (flightSearchState != null) {
      return flightSearchState;
    }
    return FlightSearchFilterState();
  }

  FlightSearchFilterState copyWith({
    Nullable<AirSortBy>? sortBy,
    List<FlightTiming>? departure,
    List<FlightTiming>? arrival,
    List<String>? airlines,
  }) {
    return FlightSearchFilterState(
      sortBy: sortBy == null ? this.sortBy : sortBy.value,
      departure: departure ?? this.departure,
      arrival: arrival ?? this.arrival,
      airlines: airlines ?? this.airlines,
    );
  }
}
