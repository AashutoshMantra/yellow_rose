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
  final List<TripResponse> teamTrips;
  final TripResponse? selectedTrip;
  final bool isViewingTeamTrip;

  const TripLoaded({
    required this.trips,
    this.teamTrips = const [],
    this.selectedTrip,
    this.isViewingTeamTrip = false,
  });

  TripLoaded copyWith({
    List<TripResponse>? trips,
    List<TripResponse>? teamTrips,
    TripResponse? selectedTrip,
    bool? isViewingTeamTrip,
    bool clearSelectedTrip = false,
  }) {
    return TripLoaded(
      trips: trips ?? this.trips,
      teamTrips: teamTrips ?? this.teamTrips,
      selectedTrip:
          clearSelectedTrip ? null : selectedTrip ?? this.selectedTrip,
      isViewingTeamTrip: isViewingTeamTrip ?? this.isViewingTeamTrip,
    );
  }

  @override
  List<Object?> get props =>
      [trips, teamTrips, selectedTrip, isViewingTeamTrip];
}

final class TripError extends TripState {
  final String message;

  const TripError({required this.message});

  @override
  List<Object?> get props => [message];
}
