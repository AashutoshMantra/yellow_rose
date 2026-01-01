part of 'trip_cubit.dart';

abstract class TripState extends Equatable {
  const TripState();

  @override
  List<Object?> get props => [];
}

final class TripInitial extends TripState {}

final class TripLoading extends TripState {}

final class TripLoaded extends TripState {
  final List<TripResponse> trips;
  final TripResponse? selectedTrip;

  const TripLoaded({
    required this.trips,
    this.selectedTrip,
  });

  TripLoaded copyWith({
    List<TripResponse>? trips,
    TripResponse? selectedTrip,
    bool clearSelectedTrip = false,
  }) {
    return TripLoaded(
      trips: trips ?? this.trips,
      selectedTrip:
          clearSelectedTrip ? null : selectedTrip ?? this.selectedTrip,
    );
  }

  @override
  List<Object?> get props => [trips, selectedTrip];
}

final class TripError extends TripState {
  final String message;

  const TripError({required this.message});

  @override
  List<Object?> get props => [message];
}
