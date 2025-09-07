import 'dart:collection';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yellow_rose/dependncy_injection.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order/order_cancel.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order_status/air_order_iitinerary.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order_status/order_status.dart';
import 'package:yellow_rose/features/flight/domain/usecases/air_usecase.dart';
import 'package:yellow_rose/features/home_screen/presentation/widgets/air/air_order_detail_card.dart';

part 'flight_order_modify_state.dart';

class FlightOrderModifyCubit extends Cubit<FlightOrderModifyState> {
  final _airUsecase = getIt<AirUseCase>();
  FlightOrderModifyCubit(
      {required AirOrderItinerary airOrderItinerary,
      OrderStatus? orderStatus,
      required String orderId})
      : super(FlightOrderModifyState.initial(
            airOrderItinerary: airOrderItinerary,
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

  Future onCancel() async {
    try {
      emit(state.copyWith(isLoading: true, errorMessage: ""));
      var selectedPassenger = state.airOrderItinerary.orderPassengerDetails
          .where((passenger) => state.selectedPassenger.contains(passenger.id));

      var orderCancelrequest = OrderCancelRequest(
          itineraryId: state.airOrderItinerary.uuid!,
          passengerDetails: selectedPassenger.toList(),
          pnr: selectedPassenger.first.pnr,
          comment: "");
      await _airUsecase.cancelOrder(orderCancelrequest, state.orderId);
      emit(state.copyWith(isLoading: false, done: true));
    } catch (e, s) {
      log("$e $s");
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }
}
