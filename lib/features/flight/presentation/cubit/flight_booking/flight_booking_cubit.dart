import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yellow_rose/dependncy_injection.dart';
import 'package:yellow_rose/features/auth/data/models/billing_entity.dart';
import 'package:yellow_rose/features/flight/data/models/airsearch/air_response_data.dart';
import 'package:collection/collection.dart';
import 'package:yellow_rose/features/flight/data/models/airsearch/fare_details_with_type.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order/order_details.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order/update_order_detail_response.dart';
import 'package:yellow_rose/features/flight/data/models/booking/ssor_options.dart';
import 'package:yellow_rose/features/flight/data/models/booking/ssr_response.dart';
import 'package:yellow_rose/features/flight/data/models/seat_map/air_seat.dart';
import 'package:yellow_rose/features/flight/data/models/seat_map/air_seat_map_request.dart';
import 'package:yellow_rose/features/flight/data/models/seat_map/air_seat_map_response.dart';
import 'package:yellow_rose/features/flight/data/models/seat_map/custom_pax_detail.dart';
import 'package:yellow_rose/features/flight/domain/entities/flight_recent_search.dart';
import 'package:yellow_rose/features/flight/domain/entities/gender.dart';
import 'package:yellow_rose/features/flight/domain/entities/passenger_details_entity.dart';
import 'package:yellow_rose/features/flight/domain/entities/passenger_title.dart';
import 'package:yellow_rose/features/flight/domain/entities/passenger_type.dart';
import 'package:yellow_rose/features/flight/domain/entities/seat_map/selected_seat.dart';
import 'package:yellow_rose/features/flight/domain/usecases/air_usecase.dart';
import 'package:yellow_rose/features/flight/domain/usecases/air_mapper_utility.dart';

part 'flight_booking_state.dart';

class FlightBookingCubit extends Cubit<FlightBookingState> {
  FlightBookingCubit() : super(FlightBookingInitial());
  final _airUseCase = getIt<AirUseCase>();

  void repriceAndLoadData(
      List<AirResponseData> selectedItineraries, AirSearch airSearch,
      {Map<int, FareDetailsWithType>? selectedFares}) async {
    try {
      emit(FlightBookingLoading());
      var mappedData = AirMapperUtility.mapFlightStateToFlightOrderDetails(
          selectedItineraries, airSearch, selectedFares);
      var orderCreatedDetails = await _airUseCase.createOrder(mappedData);
      var orderDetails =
          await _airUseCase.getOrderDetails(orderCreatedDetails.orderNumber);
      List<PassengerDetailsEntity> passengerDetais = [];

      emit(FlightBookingLoaded(
          selectedItineraries: selectedItineraries,
          selectedFares: selectedFares,
          orderDetails: orderDetails,
          airSearch: airSearch,
          passengerDetails: passengerDetais));
    } catch (e, stackTrace) {
      log("$e $stackTrace");
      emit(FlightBookingError(e.toString()));
    }
  }

  void loadSeatMapAndSsr() async {
    if (state is FlightBookingLoaded) {
      var currLoadedState = state as FlightBookingLoaded;
      var passengerDetails = currLoadedState.passengerDetails;
      emit(FlightBookingLoading());
      try {
        var paxDetails = passengerDetails.map((detail) {
          return CustomPaxDetails(
              paxType: detail.passengerType,
              title: detail.title.name,
              gender: detail.gender.name,
              firstName: detail.name,
              lastName: detail.lastName);
        }).toList();
        var flights = currLoadedState.selectedItineraries
            .expand((d) => d.flightDetailsList)
            .toList();
        var futureToLoadSeatMap = flights.map((flights) async {
          var key =
              "${flights.carrierName}-${flights.flightNumber}#${flights.fromAirport}#${flights.toAirport ?? ''}";
          AirSeatMapRequest request = AirSeatMapRequest(
              fromAirport: flights.fromAirport,
              toAirport: flights.toAirport ?? '',
              paxDetails: paxDetails);
          AirSeatMapResponse? seatMapResponse;
          try {
            seatMapResponse = await _airUseCase.getSeatMap(
                currLoadedState.orderDetails.orderId!, request);
          } catch (e, s) {
            log("$e $s");
          }

          return MapEntry(key, seatMapResponse);
        });
        var seatMapResponses =
            Map.fromEntries(await Future.wait(futureToLoadSeatMap));

        var futureToLoadSsr = flights.map((flights) async {
          var key =
              "${flights.carrierName}-${flights.flightNumber}#${flights.fromAirport}#${flights.toAirport ?? ''}";
          SsrResponse? seatMapResponse;
          AirSeatMapRequest request = AirSeatMapRequest(
              fromAirport: flights.fromAirport,
              toAirport: flights.toAirport ?? '',
              paxDetails: paxDetails);
          try {
            seatMapResponse = await _airUseCase.getSsr(
                currLoadedState.orderDetails.orderId!, request);
          } catch (e, s) {
            log("$e $s");
          }

          return MapEntry(key, seatMapResponse);
        });
        var ssrResponses = Map.fromEntries(await Future.wait(futureToLoadSsr));

        List<PassengerDetailsEntity> passengerDetais = [];

        emit(currLoadedState.copyWith(
            ssrOptions: ssrResponses, seatMaps: seatMapResponses));
      } catch (e, s) {
        log("$e $s");
        emit(currLoadedState);
      }
    }
  }

  bool doesPassengerExists(PassengerDetailsEntity passengerDetail) {
    if (state is FlightBookingLoaded) {
      var oldPassengerDetails = (state as FlightBookingLoaded).passengerDetails;

      var indexForSameName = oldPassengerDetails.indexWhere((pd) =>
          (pd.name + pd.lastName) ==
          passengerDetail.name + passengerDetail.lastName);
      if (indexForSameName != -1) {
        if (oldPassengerDetails[indexForSameName].id != passengerDetail.id) {
          return true;
        }
      }
    }
    return false;
  }

  void onAddUpdatePassenger(
      AirSearch airSearch, PassengerDetailsEntity passengerDetail) {
    if (state is FlightBookingLoaded) {
      var passengerWithGivenId = (state as FlightBookingLoaded)
          .passengerDetails
          .indexWhere((p) => p.id == passengerDetail.id);
      if (doesPassengerExists(passengerDetail)) {
        return;
      }
      var updatedPassengerDetails = [
        ...(state as FlightBookingLoaded).passengerDetails
      ];
      if (passengerWithGivenId != -1) {
        updatedPassengerDetails[passengerWithGivenId] = passengerDetail;
      } else {
        var adultCount = updatedPassengerDetails
            .where((p) => p.passengerType.isAdult())
            .length;
        var childCount = updatedPassengerDetails
            .where((p) => p.passengerType.isChild())
            .length;
        var infantCount = updatedPassengerDetails
            .where((p) => p.passengerType.isInfant())
            .length;
        if ((passengerDetail.passengerType.isAdult() &&
                adultCount < airSearch.adultCount) ||
            (passengerDetail.passengerType.isInfant() &&
                infantCount < airSearch.infantCount) ||
            (passengerDetail.passengerType.isChild() &&
                childCount < airSearch.childCount)) {
          updatedPassengerDetails.add(passengerDetail);
        }
      }
      emit((state as FlightBookingLoaded)
          .copyWith(passengerDetails: updatedPassengerDetails));
    }
  }

  double getTotalPrice() {
    if (state is FlightBookingLoaded) {
      var loadedState = state as FlightBookingLoaded;
      var selectedFLightCosts = loadedState.orderDetails.flightBooking!
          .expand((flightDetail) => (flightDetail.fare ?? []))
          .map((fare) => (fare as FareDetailsWithType).baseFare + fare.finalTax)
          .fold(0.0, (a, b) => a + b);
      var seatPrice = loadedState.selectedSeats.values
          .where((s) => s.isNotEmpty)
          .expand(
            (s) => s ?? [],
          )
          .map((s) => s.totalCost)
          .fold(0.0, (a, b) => a + b);
      var ssrPrice = loadedState.selectedSsr.values
          .where((s) => s.isNotEmpty)
          .expand((s) => s.values)
          .map((s) => s.totalCost)
          .fold(0.0, (a, b) => a + b);
      var baggagePrice = loadedState.selectedBaggage.values
          .where((s) => s.isNotEmpty)
          .expand((s) => s.values)
          .map((s) => s.totalCost)
          .fold(0.0, (a, b) => a + b);
      var specialRequestPrice = loadedState.selectedSpecialRequests.values
          .where((s) => s.isNotEmpty)
          .expand((s) => s.values)
          .map((s) => s.totalCost)
          .fold(0.0, (a, b) => a + b);
      return selectedFLightCosts +
          seatPrice +
          ssrPrice +
          baggagePrice +
          specialRequestPrice;
    }
    return 0;
  }

  onSeatSelect(AirSearch airSearch, String key, SelectedSeat seat) {
    int paxCount = airSearch.adultCount + airSearch.childCount;
    if (state is FlightBookingLoaded) {
      var currentSelectedSeat = Map<String, List<SelectedSeat>>.from(
          (state as FlightBookingLoaded).selectedSeats);
      if (currentSelectedSeat.containsKey(key)) {
        var selectedSeats = [...currentSelectedSeat[key]!];
        var foundIndex = selectedSeats.indexWhere(
            (s) => s.row == seat.row && s.seat.column == seat.seat.column);

        if (foundIndex != -1) {
          selectedSeats.removeAt(foundIndex);
        } else {
          if (paxCount == selectedSeats.length) {
            selectedSeats.removeAt(0);
          }
          selectedSeats.add(seat);
        }
        currentSelectedSeat[key] = selectedSeats;
      } else {
        currentSelectedSeat[key] = [seat];
      }
      emit((state as FlightBookingLoaded)
          .copyWith(selectedSeats: currentSelectedSeat));
    }
  }

  void resetSsrMap() {
    if (state is FlightBookingLoaded) {
      emit(FlightBookingLoaded(
        selectedFares: (state as FlightBookingLoaded).selectedFares,
        selectedItineraries: (state as FlightBookingLoaded).selectedItineraries,
        passengerDetails: (state as FlightBookingLoaded).passengerDetails,
        billingEntity: (state as FlightBookingLoaded).billingEntity,
        orderDetails: (state as FlightBookingLoaded).orderDetails,
        airSearch: (state as FlightBookingLoaded).airSearch,
      ));
    }
  }

  onMealSelect(String flightKey, String passengerId, SsrOption ssr) {
    if (state is FlightBookingLoaded) {
      var currSelectedMealSsr = Map<String, Map<String, SsrOption>>.from(
          (state as FlightBookingLoaded).selectedSsr);

      if (!currSelectedMealSsr.containsKey(flightKey)) {
        currSelectedMealSsr[flightKey] = <String, SsrOption>{};
      } else {
        currSelectedMealSsr[flightKey] =
            Map.fromEntries(currSelectedMealSsr[flightKey]!.entries);
      }
      currSelectedMealSsr[flightKey]![passengerId] = ssr;
      emit((state as FlightBookingLoaded)
          .copyWith(selectedSsr: currSelectedMealSsr));
    }
  }

  onBaggageSelect(String flightKey, String passengerId, SsrOption ssr) {
    if (state is FlightBookingLoaded) {
      var currSelectedBaggage = Map<String, Map<String, SsrOption>>.from(
          (state as FlightBookingLoaded).selectedBaggage);

      if (!currSelectedBaggage.containsKey(flightKey)) {
        currSelectedBaggage[flightKey] = <String, SsrOption>{};
      } else {
        currSelectedBaggage[flightKey] =
            Map.fromEntries(currSelectedBaggage[flightKey]!.entries);
      }
      currSelectedBaggage[flightKey]![passengerId] = ssr;
      emit((state as FlightBookingLoaded)
          .copyWith(selectedBaggage: currSelectedBaggage));
    }
  }

  onSpecialRequestSelect(String flightKey, String passengerId, SsrOption ssr) {
    if (state is FlightBookingLoaded) {
      var currSelectedSpecialRequests =
          Map<String, Map<String, SsrOption>>.from(
              (state as FlightBookingLoaded).selectedSpecialRequests);

      if (!currSelectedSpecialRequests.containsKey(flightKey)) {
        currSelectedSpecialRequests[flightKey] = <String, SsrOption>{};
      } else {
        currSelectedSpecialRequests[flightKey] =
            Map.fromEntries(currSelectedSpecialRequests[flightKey]!.entries);
      }
      currSelectedSpecialRequests[flightKey]![passengerId] = ssr;
      emit((state as FlightBookingLoaded)
          .copyWith(selectedSpecialRequests: currSelectedSpecialRequests));
    }
  }

  void onBillingEntityChange(BillingEntity? value) {
    emit((state as FlightBookingLoaded).copyWith(billingEntity: value));
  }

  Future<UpdateOrderDetailResponse> updatePassengerDetailsAndSssr() async {
    if (state is FlightBookingLoaded) {
      var mappedRequest = AirMapperUtility
          .mapFlightStateToUpdatedOrderDetailWithPassengerDetails(
        state as FlightBookingLoaded,
      );

      return await _airUseCase.updateOrder(
          (state as FlightBookingLoaded).orderDetails.orderId!, mappedRequest);
    }
    throw Exception("FlightBookingState is not loaded");
  }
}
