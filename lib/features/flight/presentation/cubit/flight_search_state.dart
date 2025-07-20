part of 'flight_search_cubit.dart';

class FlightSearchState extends Equatable {
  final int childCount;
  final int adultCount;
  final int infantCount;
  final String? error;
  final bool isLoading;

  final List<SourceDestinationDatePair> sources;
  final FlightSearchClass searchClass;
  const FlightSearchState({
    this.childCount = 0,
    this.adultCount = 1,
    this.error,
    this.infantCount = 0,
    required this.sources,
    this.isLoading = true,
    this.searchClass = FlightSearchClass.Economy,
  });
  factory FlightSearchState.initial({AirSearch? airSearch}) {
    if (airSearch?.sources.isNotEmpty == true) {
      return FlightSearchState(
          sources: airSearch!.sources,
          adultCount: airSearch.adultCount,
          childCount: airSearch.childCount,
          infantCount: airSearch.infantCount,
          isLoading: false,
          searchClass: airSearch.searchClass ?? FlightSearchClass.Economy);
    }
    return FlightSearchState(sources: [
      SourceDestinationDatePair(
          source: Airport(name: "New Delhi", iataCode: "DEL"),
          destination: Airport(name: "Mumbai", iataCode: "BOM"),
          sourceDate: DateTime.now().add(const Duration(days: 1)))
    ]);
  }

  FlightSearchState copyWith({
    int? childCount,
    int? adultCount,
    int? infantCount,
    String? error,
    bool? isLoading,
    List<SourceDestinationDatePair>? sources,
    FlightSearchClass? searchClass,
  }) {
    return FlightSearchState(
      childCount: childCount ?? this.childCount,
      adultCount: adultCount ?? this.adultCount,
      infantCount: infantCount ?? this.infantCount,
      sources: sources ?? this.sources,
      searchClass: searchClass ?? this.searchClass,
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [
        childCount,
        adultCount,
        infantCount,
        sources,
        searchClass,
        error,
        isLoading
      ];
}
