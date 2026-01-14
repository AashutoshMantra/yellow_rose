import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:yellow_rose/core/nullable.dart';
import 'package:yellow_rose/core/utils/trip_validation_helper.dart';
import 'package:yellow_rose/dependncy_injection.dart';
import 'package:yellow_rose/features/bus/data/models/bus_details/bus_detail_request.dart';
import 'package:yellow_rose/features/bus/data/models/bus_details/bus_detail_response.dart';
import 'package:yellow_rose/features/bus/data/models/bus_details/bus_seats.dart';
import 'package:yellow_rose/features/bus/data/models/bus_point.dart';
import 'package:yellow_rose/features/bus/data/models/search/bus_search_response.dart';
import 'package:yellow_rose/features/bus/domain/usecases/bus_usecase.dart';
import 'package:yellow_rose/features/trip/data/models/trip_response.dart';

part 'bus_detail_state.dart';

class BusDetailCubit extends Cubit<BusDetailState> {
  BusDetailCubit({this.selectedTrip}) : super(BusDetailInitial());

  final _busUseCase = getIt<BusUseCase>();
  final TripResponse? selectedTrip;

  int? getMaxAllowedSeats() {
    if (selectedTrip == null) return null;

    final constraints =
        TripValidationHelper.getRequiredPassengerCounts(selectedTrip!);
    return constraints.adultCount;
  }

  void loadBusDetails(BusSearchResponse busSearchResponse) async {
    try {
      emit(BusDetailLoading());

      final request = BusDetailRequest(
        requestId: busSearchResponse.id ?? '',
        inventoryId: int.tryParse(busSearchResponse.id ?? '') ?? 0,
        doj: busSearchResponse.doj ?? '',
        callFareBreakUpAPI: false,
      );

      final busDetailResponse = await _busUseCase.getBusDetails(request);

      emit(BusDetailLoaded(busDetailResponse: busDetailResponse));
    } catch (e, stackTrace) {
      log("$e $stackTrace");
      emit(BusDetailError(e.toString()));
    }
  }

  void toggleSeat(String seatId) {
    if (state is BusDetailLoaded) {
      final currentState = state as BusDetailLoaded;
      final newSelected = Set<String>.from(currentState.selectedSeats);
      if (newSelected.contains(seatId)) {
        newSelected.remove(seatId);
      } else {
        final maxSeats = getMaxAllowedSeats();
        if (maxSeats != null && newSelected.length >= maxSeats) {
          return;
        }
        newSelected.add(seatId);
      }
      emit(currentState.copyWith(selectedSeats: newSelected));
    }
  }

  void addSeat(String seatId) {
    if (state is BusDetailLoaded) {
      final currentState = state as BusDetailLoaded;
      final newSelected = Set<String>.from(currentState.selectedSeats);

      final maxSeats = getMaxAllowedSeats();
      if (maxSeats != null && newSelected.length >= maxSeats) {
        return;
      }

      newSelected.add(seatId);
      emit(currentState.copyWith(selectedSeats: newSelected));
    }
  }

  void removeSeat(String seatId) {
    if (state is BusDetailLoaded) {
      final currentState = state as BusDetailLoaded;
      final newSelected = Set<String>.from(currentState.selectedSeats);
      newSelected.remove(seatId);
      emit(currentState.copyWith(selectedSeats: newSelected));
    }
  }

  void clearSeats() {
    if (state is BusDetailLoaded) {
      final currentState = state as BusDetailLoaded;
      emit(currentState.copyWith(selectedSeats: {}));
    }
  }

  double getTotalPrice() {
    if (state is BusDetailLoaded) {
      final currentState = state as BusDetailLoaded;
      return currentState.selectedSeats
          .map((seatId) => currentState.busDetailResponse.seats.firstWhere(
              (seat) => seat.name == seatId,
              orElse: () => BusSeats()))
          .where((seat) => seat.fare != null)
          .map((seat) => seat.fare!)
          .fold(0.0, (sum, fare) => sum + fare);
    }
    return 0.0;
  }

  void selectBoardingPoint(BusPoint? boardingPoint) {
    if (state is BusDetailLoaded) {
      final currentState = state as BusDetailLoaded;
      emit(currentState.copyWith(
          selectedBoardingPoint: Nullable(boardingPoint)));
    }
  }

  void selectDroppingPoint(BusPoint? droppingPoint) {
    if (state is BusDetailLoaded) {
      final currentState = state as BusDetailLoaded;
      emit(currentState.copyWith(
          selectedDroppingPoint: Nullable(droppingPoint)));
    }
  }

  void clearBoardingPoint() {
    if (state is BusDetailLoaded) {
      final currentState = state as BusDetailLoaded;
      emit(currentState.copyWith(selectedBoardingPoint: const Nullable(null)));
    }
  }

  void clearDroppingPoint() {
    if (state is BusDetailLoaded) {
      final currentState = state as BusDetailLoaded;
      emit(currentState.copyWith(selectedDroppingPoint: const Nullable(null)));
    }
  }
}
