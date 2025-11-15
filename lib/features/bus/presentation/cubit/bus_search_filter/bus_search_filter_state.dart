part of 'bus_search_filter_cubit.dart';

class BusSearchFilterState extends Equatable {
  final BusSortBy? sortBy;
  final List<BusTiming> departureTiming;
  final List<BusType> busTypes;
  final List<String> pickupPoints;
  final List<String> dropPoints;
  final List<BusOperatorDetail> operators;

  const BusSearchFilterState({
    this.sortBy,
    this.departureTiming = const [],
    this.busTypes = const [],
    this.pickupPoints = const [],
    this.dropPoints = const [],
    this.operators = const [],
  });

  @override
  List<Object?> get props =>
      [sortBy, departureTiming, busTypes, pickupPoints, dropPoints, operators];

  factory BusSearchFilterState.initial({BusSearchFilterState? busSearchState}) {
    if (busSearchState != null) {
      return busSearchState;
    }
    return const BusSearchFilterState();
  }

  BusSearchFilterState copyWith({
    BusSortBy? sortBy,
    List<BusTiming>? departureTiming,
    List<BusType>? busTypes,
    List<String>? pickupPoints,
    List<String>? dropPoints,
    List<BusOperatorDetail>? operators,
  }) {
    return BusSearchFilterState(
      sortBy: sortBy ?? this.sortBy,
      departureTiming: departureTiming ?? this.departureTiming,
      busTypes: busTypes ?? this.busTypes,
      pickupPoints: pickupPoints ?? this.pickupPoints,
      dropPoints: dropPoints ?? this.dropPoints,
      operators: operators ?? this.operators,
    );
  }
}
