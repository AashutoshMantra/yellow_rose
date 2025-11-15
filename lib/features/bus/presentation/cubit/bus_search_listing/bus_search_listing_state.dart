part of 'bus_search_listing_cubit.dart';

sealed class BusSearchListingState extends Equatable {
  final BusSearch? busSearch;

  const BusSearchListingState({
    this.busSearch,
  });

  @override
  List<Object?> get props => [busSearch];
}

class BusSearchListingInitial extends BusSearchListingState {
  const BusSearchListingInitial({required super.busSearch});
}

class BusSearchListingLoading extends BusSearchListingState {
  const BusSearchListingLoading({required super.busSearch});
}

class BusSearchListingLoaded extends BusSearchListingState {
  final List<BusSearchResponse> busSearchResponse;
  final BusSearchResponse? selectedBus;
  final BusSearchFilterState filterState;

  const BusSearchListingLoaded({
    required this.busSearchResponse,
    this.selectedBus,
    BusSearchFilterState? filterState,
    required super.busSearch,
  }) : filterState = filterState ?? const BusSearchFilterState();

  BusSearchListingLoaded copyWith({
    List<BusSearchResponse>? busSearchResponse,
    BusSearchResponse? selectedBus,
    BusSearchFilterState? filterState,
    BusSearch? busSearch,
  }) {
    return BusSearchListingLoaded(
      busSearchResponse: busSearchResponse ?? this.busSearchResponse,
      selectedBus: selectedBus ?? this.selectedBus,
      filterState: filterState ?? this.filterState,
      busSearch: busSearch ?? this.busSearch,
    );
  }

  @override
  List<Object?> get props =>
      [busSearchResponse, selectedBus, filterState, busSearch];
}

class BusSearchListingError extends BusSearchListingState {
  final String error;

  const BusSearchListingError(this.error, {required super.busSearch});

  @override
  List<Object?> get props => [error, busSearch];
}
