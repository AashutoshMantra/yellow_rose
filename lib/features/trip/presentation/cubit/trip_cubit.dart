import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yellow_rose/dependncy_injection.dart';
import 'package:yellow_rose/features/trip/data/models/trip_create_request.dart';
import 'package:yellow_rose/features/trip/data/models/trip_response.dart';
import 'package:yellow_rose/features/trip/domain/usecases/trip_usecase.dart';

part 'trip_state.dart';

class TripCubit extends Cubit<TripState> {
  TripCubit() : super(TripInitial());

  final _tripUseCase = getIt<TripUseCase>();

  TripResponse? get selectedTrip {
    final currentState = state;
    if (currentState is TripLoaded) {
      return currentState.selectedTrip;
    }
    return null;
  }

  double getSelectedTripTotalPrice() {
    final trip = selectedTrip;
    if (trip == null) return 0.0;

    final airCost = trip.totalAirCost ?? 0.0;
    final hotelCost = trip.totalHotelCost ?? 0.0;
    return airCost + hotelCost;
  }

  Future<void> loadTrips(String userId) async {
    try {
      emit(TripLoading());
      final trips = await _tripUseCase.getTrips(userId);
      emit(TripLoaded(trips: trips));
    } catch (e, s) {
      log("$e $s");
      emit(TripError(message: e.toString()));
    }
  }

  Future<void> createTrip(TripCreateRequest request) async {
    final currentState = state;
    try {
      final trip = await _tripUseCase.createTrip(request);

      if (currentState is TripLoaded) {
        final updatedTrips = [trip, ...currentState.trips];
        emit(currentState.copyWith(trips: updatedTrips));
      } else {
        emit(TripLoaded(trips: [trip]));
      }
    } catch (e, s) {
      log("$e $s");
      rethrow;
    }
  }

  void selectTrip(TripResponse trip) {
    final currentState = state;
    if (currentState is TripLoaded) {
      emit(currentState.copyWith(selectedTrip: trip));
    }
  }

  void clearSelectedTrip() {
    final currentState = state;
    if (currentState is TripLoaded) {
      emit(currentState.copyWith(clearSelectedTrip: true));
    }
  }

  void refereshSelectedTrip() async {
    final currentState = state;
    if (currentState is TripLoaded) {
      final currentSelectedTrip = currentState.selectedTrip;
      if (currentSelectedTrip != null) {
        try {
          final refreshedTrip =
              await _tripUseCase.getTripById(currentSelectedTrip.tripUid!);
          emit(currentState.copyWith(selectedTrip: refreshedTrip));
        } catch (e, s) {
          log("Failed to refresh trip: $e $s");
        }
      }
    }
  }

  Future<void> addToTrip(String orderId) async {
    final currentSelectedTrip = selectedTrip;
    if (currentSelectedTrip == null) {
      throw Exception('No trip selected');
    }

    await _tripUseCase.addToTrip(orderId);
  }

  Future<void> sendTripForApproval() async {
    final currentSelectedTrip = selectedTrip;
    if (currentSelectedTrip == null) {
      throw Exception('No trip selected');
    }
    var currentState = state;

    emit(TripLoading());

    try {
      await _tripUseCase.sendTripForApproval(currentSelectedTrip.tripUid!);
      final refreshedTrip =
          await _tripUseCase.getTripById(currentSelectedTrip.tripUid!);

      currentState = state;
      if (currentState is TripLoaded) {
        final updatedTrips = currentState.trips.map((trip) {
          return trip.tripUid == refreshedTrip.tripUid ? refreshedTrip : trip;
        }).toList();
        emit(currentState.copyWith(
          trips: updatedTrips,
          selectedTrip: refreshedTrip,
        ));
      } else {
        emit(TripLoaded(trips: [refreshedTrip], selectedTrip: refreshedTrip));
      }
    } catch (e) {
      emit(currentState);

      rethrow;
    }
  }
}
