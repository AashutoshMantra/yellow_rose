part of 'bus_search_cubit.dart';

class BusSearchState extends Equatable {
  final BusCityResponse? source;
  final BusCityResponse? destination;
  final DateTime? dateOfJourney;
  final String? error;
  final bool isLoading;

  const BusSearchState({
    this.source,
    this.destination,
    this.dateOfJourney,
    this.error,
    this.isLoading = true,
  });

  factory BusSearchState.initial({BusSearch? busSearch}) {
    if (busSearch != null) {
      return BusSearchState(
        source: busSearch.source,
        destination: busSearch.destination,
        dateOfJourney: busSearch.dateOfJourney,
        isLoading: false,
      );
    }
    return BusSearchState(
      dateOfJourney: DateTime.now().add(const Duration(days: 1)),
      isLoading: true,
    );
  }

  BusSearchState copyWith({
    BusCityResponse? source,
    BusCityResponse? destination,
    DateTime? dateOfJourney,
    String? error,
    bool? isLoading,
  }) {
    return BusSearchState(
      source: source ?? this.source,
      destination: destination ?? this.destination,
      dateOfJourney: dateOfJourney ?? this.dateOfJourney,
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props =>
      [source, destination, dateOfJourney, error, isLoading];
}
