import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yellow_rose/dependncy_injection.dart';
import 'package:yellow_rose/features/bus/data/models/order/bus_order_cancellation.dart';
import 'package:yellow_rose/features/bus/data/models/order/bus_order_itinerary.dart';
import 'package:yellow_rose/features/bus/domain/usecases/bus_usecase.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order_status/order_status.dart';

part 'bus_order_modify_state.dart';

class BusOrderModifyCubit extends Cubit<BusOrderModifyState> {
  final _busUsecase = getIt<BusUseCase>();

  BusOrderModifyCubit({
    required BusOrderItinerary busOrderItinerary,
    OrderStatus? orderStatus,
    required String orderId,
  }) : super(BusOrderModifyState.initial(
            busOrderItinerary: busOrderItinerary,
            orderStatus: orderStatus,
            orderId: orderId));

  void togglePassengerSelection(int passengerId) {
    final currentSelected = List<int>.from(state.selectedPassenger);
    if (currentSelected.contains(passengerId)) {
      currentSelected.remove(passengerId);
    } else {
      currentSelected.add(passengerId);
    }
    emit(state.copyWith(selectedPassenger: currentSelected));
  }

  void clearError() {
    emit(state.copyWith(errorMessage: "", isLoading: false));
  }

  Future<void> onCancel() async {
    try {
      emit(state.copyWith(isLoading: true, errorMessage: ""));

      // Get selected passengers
      var selectedPassengers = state.busOrderItinerary.busOrderPassengerDetails
              ?.where(
                  (passenger) => state.selectedPassenger.contains(passenger.id))
              .toList() ??
          [];

      if (selectedPassengers.isEmpty) {
        emit(state.copyWith(
            isLoading: false,
            errorMessage: "No passengers selected for cancellation"));
        return;
      }

      // Extract seat names from selected passengers
      List<String> seatNames = selectedPassengers
          .map((passenger) => passenger.seatNumber)
          .whereType<String>()
          .where((seat) => seat.isNotEmpty)
          .toList();

      if (seatNames.isEmpty) {
        emit(state.copyWith(
            isLoading: false,
            errorMessage: "No valid seat numbers found for cancellation"));
        return;
      }

      // Create cancellation request
      var busCancellationRequest = BusSeatCancellation(
        seatNames: seatNames,
        orderId: state.orderId,
        cancellationType: "FULL", // or "PARTIAL" based on business logic
        createdBy: "USER", // Update with actual user info if available
      );

      await _busUsecase.cancelOrder(busCancellationRequest);
      emit(state.copyWith(isLoading: false, done: true));
    } catch (e, s) {
      log("Bus cancellation error: $e $s");
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }
}
