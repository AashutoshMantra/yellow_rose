import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yellow_rose/dependncy_injection.dart';
import 'package:yellow_rose/features/auth/data/models/billing_entity.dart';
import 'package:yellow_rose/features/bus/data/models/bus_details/bus_detail_response.dart';
import 'package:yellow_rose/features/bus/data/models/order/block_bus_ticket.dart';
import 'package:yellow_rose/features/bus/data/models/order/bos_block_response.dart';
import 'package:yellow_rose/features/flight/domain/entities/passenger_details_entity.dart';
import 'package:yellow_rose/features/bus/data/models/bus_point.dart';
import 'package:yellow_rose/features/bus/data/models/order/bus_order__create_request.dart';
import 'package:yellow_rose/features/bus/data/models/order/bus_order_response.dart';
import 'package:yellow_rose/features/bus/data/models/search/bus_search_response.dart';
import 'package:yellow_rose/features/bus/domain/entities/bus_search.dart';
import 'package:yellow_rose/features/bus/domain/usecases/bus_usecase.dart';
import 'package:yellow_rose/features/bus/domain/usecases/bus_mapper_utility.dart';

part 'bus_book_state.dart';

class BusBookCubit extends Cubit<BusBookState> {
  BusBookCubit() : super(BusBookInitial());

  final _busUseCase = getIt<BusUseCase>();

  void createOrderAndUpdate(
    BusSearch busSearch,
    BusDetailResponse busDetail,
    BusSearchResponse busSearchResponse,
    Set<String> selectedSeats,
    BusPoint selectedBoardingPoint,
    BusPoint selectedDroppingPoint, {
    List<PassengerDetailsEntity>? initialPassengerDetails,
  }) async {
    try {
      emit(BusBookLoading());

      // Create booking request using mapper utility
      final bookingRequest = BusMapperUtility.createBusBookingRequest(
        busSearch,
        busSearchResponse,
        busDetail,
        selectedSeats,
        selectedBoardingPoint,
        selectedDroppingPoint,
      );

      var createOrderRequest = BusOrderCreateRequest(
        inventoryId: busSearchResponse.id,
        source: busSearchResponse.source,
        destination: busSearchResponse.destination,
        sourceId: busSearchResponse.sourceId?.toString(),
        destinationId: busSearchResponse.destinationId?.toString(),
        bookingRequest: bookingRequest,
        busBooking: bookingRequest.busBooking,
        whiteLabelId: 1, // TODO: Get from config
      );

      var createOrderResponse =
          await _busUseCase.createOrder(createOrderRequest);

      emit(BusBookLoaded(
        busDetailResponse: busDetail,
        busSearchResponse: busSearchResponse,
        busSearch: busSearch,
        selectedSeats: selectedSeats,
        selectedBoardingPoint: selectedBoardingPoint,
        selectedDroppingPoint: selectedDroppingPoint,
        busOrderResponse: createOrderResponse,
        passengers: initialPassengerDetails ?? [],
      ));
    } catch (e, s) {
      log("$e $s");
      emit(BusBookError(e.toString()));
    }
  }

  void onAddUpdatePassenger(PassengerDetailsEntity passenger) {
    if (state is BusBookLoaded) {
      var currentState = state as BusBookLoaded;
      var updatedPassengers =
          List<PassengerDetailsEntity>.from(currentState.passengers);

      var existingIndex =
          updatedPassengers.indexWhere((p) => p.id == passenger.id);
      if (existingIndex != -1) {
        updatedPassengers[existingIndex] = passenger;
      } else {
        updatedPassengers.add(passenger);
      }

      emit(currentState.copyWith(passengers: updatedPassengers));
    }
  }

  void onBillingEntityChange(BillingEntity? value) {
    if (state is BusBookLoaded) {
      emit((state as BusBookLoaded).copyWith(billingEntity: value));
    }
  }

  Future<BusBlockTicketResponse> updatePassengerDetailInOrder() async {
    if (state is BusBookLoaded) {
      var currentState = state as BusBookLoaded;

      try {
        // Create update request with passengers and billing entity
        var updateRequest = BusMapperUtility.createUpdateOrderRequest(
          currentState.busSearch,
          currentState.busSearchResponse,
          currentState.busDetailResponse,
          currentState.selectedSeats,
          currentState.selectedBoardingPoint!,
          currentState.selectedDroppingPoint!,
          currentState.passengers,
          currentState.billingEntity,
        );

        // Update order with passenger details
        var updatedOrder = await _busUseCase.updateOrder(
          currentState.busOrderResponse.orderNumber ?? '',
          updateRequest,
        );
        if (updatedOrder.priceData == null) {
          throw "Error updating order details";
        }

        // Create block ticket request
        var blockTicketRequest = BusMapperUtility.createBlockTicketRequest(
          currentState.busSearch,
          currentState.busSearchResponse,
          currentState.busDetailResponse,
          currentState.selectedSeats,
          currentState.selectedBoardingPoint!,
          currentState.selectedDroppingPoint!,
          currentState.passengers,
        );

        // Block the tickets
        var blockResponse = await _busUseCase.blockTicket(
          currentState.busOrderResponse.orderNumber ?? '',
          blockTicketRequest,
        );

        emit(currentState.copyWith(updateOrderDetailResponse: updatedOrder));
        return blockResponse;
      } catch (e, s) {
        log("$e, $s");
        rethrow;
      }
    }
    throw Exception("State not loaded for bus booking");
  }
}
