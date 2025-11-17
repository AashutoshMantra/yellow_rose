import 'package:yellow_rose/features/bus/data/models/search/bus_search_request.dart';
import 'package:yellow_rose/features/bus/domain/entities/bus_search.dart';
import 'package:yellow_rose/features/bus/data/models/order/bus_booking_request.dart';
import 'package:yellow_rose/features/bus/data/models/order/user_bus_booking_request.dart';
import 'package:yellow_rose/features/bus/data/models/bus_details/bus_detail_response.dart';
import 'package:yellow_rose/features/bus/data/models/search/bus_search_response.dart';
import 'package:yellow_rose/features/bus/data/models/bus_point.dart';
import 'package:yellow_rose/features/bus/data/models/order/bus_inventory_item.dart';
import 'package:yellow_rose/features/bus/data/models/bus_passenger.dart';
import 'package:yellow_rose/features/bus/data/models/order/block_bus_ticket.dart';
import 'package:yellow_rose/features/bus/data/models/order/bus_order__create_request.dart';
import 'package:yellow_rose/features/auth/data/models/billing_entity.dart';
import 'package:yellow_rose/features/flight/domain/entities/passenger_details_entity.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order/passenger_detiald.dart';
import 'package:yellow_rose/features/flight/data/models/passenger_type_enum.dart';

class BusMapperUtility {
  BusMapperUtility._();

  static BusSearchRequest mapBusSearchToBusSearchRequest(BusSearch busSearch) {
    if (busSearch.source == null ||
        busSearch.destination == null ||
        busSearch.dateOfJourney == null) {
      throw Exception("Bus search source, destination and date are required");
    }

    return BusSearchRequest(
      requestId: busSearch.requestId,
      source: busSearch.source!.cityLabel ?? '',
      sourceId: busSearch.source!.id,
      destination: busSearch.destination!.cityLabel ?? '',
      destinationId: busSearch.destination!.id,
      dateOfJourney: busSearch.dateOfJourney!,
    );
  }

  static BusBookingRequest createBusBookingRequest(
    BusSearch busSearch,
    BusSearchResponse busSearchResponse,
    BusDetailResponse busDetail,
    Set<String> selectedSeats,
    BusPoint selectedBoardingPoint,
    BusPoint selectedDroppingPoint,
  ) {
    return BusBookingRequest(
      source: busSearchResponse.source,
      sourceId: busSearchResponse.sourceId,
      destination: busSearchResponse.destination,
      destinationId: busSearchResponse.destinationId,
      dateOfJourney: busSearchResponse.doj,
      requestId: busSearch.requestId,
      paxCount: selectedSeats.length,
      adultCount: selectedSeats.length,
      childCount: 0,
      infantCount: 0,
      busBooking: [
        UserBusBookingRequest(
          requestId: busSearch.requestId,
          source: busSearchResponse.source,
          sourceId: busSearchResponse.sourceId,
          destination: busSearchResponse.destination,
          destinationId: busSearchResponse.destinationId,
          doj: busSearchResponse.doj,
          id: busSearchResponse.id,
          boardingPoint: [selectedBoardingPoint],
          droppingPoint: [selectedDroppingPoint],
          seats: busDetail.seats
              .where((seat) => selectedSeats.contains(seat.name))
              .toList(),
          otherData: {},
          fare: [],
          cancellationChargeRules: [],
        )
      ],
      seats: busDetail.seats
          .where((seat) => selectedSeats.contains(seat.name))
          .toList(),
      passengerDetails: [],
      otherData: {},
    );
  }

  static BusOrderCreateRequest createUpdateOrderRequest(
    BusSearch busSearch,
    BusSearchResponse busSearchResponse,
    BusDetailResponse busDetail,
    Set<String> selectedSeats,
    BusPoint selectedBoardingPoint,
    BusPoint selectedDroppingPoint,
    List<PassengerDetailsEntity> passengers,
    BillingEntity? billingEntity,
  ) {
    // Convert passengers to API format for passengerDetails
    List<PassengerDetails> passengerDetails = [];
    List<String> seatList = selectedSeats.toList();

    for (int i = 0; i < passengers.length && i < seatList.length; i++) {
      var passenger = passengers[i];
      var seatName = seatList[i];
      var assignedSeat = busDetail.seats.firstWhere(
        (seat) => seat.name == seatName,
      );

      passengerDetails.add(PassengerDetails(
        passengerType: PassengerTypeEnum.ADT, // Assuming adult passengers
        passengerTitle: passenger.title.name,
        firstName: passenger.name,
        lastName: passenger.lastName,
        username: passenger.email,
        mobile: passenger.phoneNumber,
        email: passenger.email,
        gender: passenger.gender.name,

        dob: passenger.dob,
        seatNumber: assignedSeat.name,
      ));
    }

    return BusOrderCreateRequest(
      whiteLabelId: 1,
      inventoryId: busSearchResponse.id,
      requestId: busSearch.requestId,
      contactNumber:
          passengers.isNotEmpty ? passengers.first.phoneNumber : null,
      email: passengers.isNotEmpty ? passengers.first.email : null,
      billingEntity: billingEntity?.entityName,
      bookingRequest: BusBookingRequest(
        requestId: busSearch.requestId,
        source: busSearchResponse.source,
        sourceId: busSearchResponse.sourceId,
        destination: busSearchResponse.destination,
        destinationId: busSearchResponse.destinationId,
        dateOfJourney: busSearchResponse.doj,
        paxCount: selectedSeats.length,
        adultCount: selectedSeats.length,
        gstEmail: billingEntity?.email,
        gstNumber: billingEntity?.entityGST,
        childCount: 0,
        infantCount: 0,
        contactNumber:
            passengers.isNotEmpty ? passengers.first.phoneNumber : null,
        email: passengers.isNotEmpty ? passengers.first.email : null,
        billingEntity: billingEntity?.entityRefId,
        seats: busDetail.seats
            .where((seat) => selectedSeats.contains(seat.name))
            .toList(),
        passengerDetails: passengerDetails,
      ),
    );
  }

  static BusBlockTicketRequest createBlockTicketRequest(
    BusSearch busSearch,
    BusSearchResponse busSearchResponse,
    BusDetailResponse busDetail,
    Set<String> selectedSeats,
    BusPoint selectedBoardingPoint,
    BusPoint selectedDroppingPoint,
    List<PassengerDetailsEntity> passengers,
  ) {
    // Convert passengers to API format
    List<BusPassenger> apiPassengers = passengers
        .map((passenger) => BusPassenger(
              title: passenger.title.name,
              name: '${passenger.name} ${passenger.lastName}',
              age: passenger.dob != null
                  ? DateTime.now().year - passenger.dob!.year
                  : 30, // Default age if DOB not available
              gender: passenger.gender.name.toLowerCase(),
              email: passenger.email,
              mobile: int.tryParse(passenger.phoneNumber) ?? 0,
              primary: passengers.indexOf(passenger) == 0 ? 'true' : 'false',
            ))
        .toList();

    // Create inventory items with passengers assigned to seats
    List<BusInventoryItem> inventoryItems = [];
    List<String> seatList = selectedSeats.toList();

    for (int i = 0; i < seatList.length && i < apiPassengers.length; i++) {
      inventoryItems.add(BusInventoryItem(
        seatName: seatList[i],
        fare:
            busDetail.seats.firstWhere((seat) => seat.name == seatList[i]).fare,
        passenger: [apiPassengers[i]],
      ));
    }

    return BusBlockTicketRequest(
      availableTripId: busSearchResponse.id,
      boardingPointId: int.tryParse(selectedBoardingPoint.bpId ?? ''),
      droppingPointId: int.tryParse(selectedDroppingPoint.dpId ?? ''),
      source: busSearchResponse.sourceId,
      destination: busSearchResponse.destinationId,
      inventoryItems: inventoryItems,
      requestId: busSearch.requestId,
    );
  }
}
