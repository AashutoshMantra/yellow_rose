import 'package:collection/collection.dart';
import 'package:yellow_rose/core/utils/date_utils.dart';
import 'package:yellow_rose/core/utils/extensions.dart';
import 'package:yellow_rose/features/flight/data/models/airsearch/air_response_data.dart';
import 'package:yellow_rose/features/flight/data/models/airsearch/air_search_request.dart';
import 'package:yellow_rose/features/flight/data/models/airsearch/fare_details_with_type.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order/booking_request.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order/order_details.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order/order_traveller_details.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order/passenger_detiald.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order/segment.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order/user_booking_request.dart';
import 'package:yellow_rose/features/flight/data/models/booking/ssor_options.dart';
import 'package:yellow_rose/features/flight/domain/entities/flight_recent_search.dart';
import 'package:yellow_rose/features/flight/presentation/cubit/flight_booking/flight_booking_cubit.dart';

class AirMapperUtility {
  AirMapperUtility._();

  static OrderDetails mapFlightStateToFlightOrderDetails(
      List<AirResponseData> selectedItineraries,
      AirSearch airSearch,
      Map<int, FareDetailsWithType>? selectedFares) {
    var mappedItinaries = selectedItineraries.mapIndexed((idx, itinerary) {
      var mappedFlight = itinerary.flightDetailsList.map((flightDetail) {
        var bookingClassFiletred = flightDetail.bookingClasses
            .where((d) =>
                d.fareType
                    .equalsIgnoreCase(selectedFares?[idx]?.fareType ?? "") ==
                true)
            .toList();
        flightDetail.copyWith(bookingClasses: bookingClassFiletred);
        return flightDetail;
      }).toList();
      var filteredFare = itinerary.fare
          .where((fare) =>
              fare.fareType
                  .equalsIgnoreCase(selectedFares?[idx]?.fareType ?? "") ==
              true)
          .toList();
      return UserBookingRequest(
          fromAirport: itinerary.flightDetailsList.first.fromAirport,
          toAirport: itinerary.flightDetailsList.last.toAirport,
          otherData: itinerary.otherData,
          flightDetailsList: mappedFlight,
          source: itinerary.source,
          routeRequest: itinerary.routeRequest,
          fare: filteredFare,
          schDepartureTime: itinerary.schDepartureTime,
          schArrivalTime: itinerary.schArrivalTime,
          hopeCount: itinerary.hopCount,
          holdBooking: true);
    }).toList();
    var travellerDetails = OrderTravellerDetails(
        child: airSearch.childCount,
        adult: airSearch.adultCount,
        infantCount: airSearch.infantCount);
    var airSearchRequest =
        AirMapperUtility.mapFlightStateToAirSearchRequest(airSearch);
    return OrderDetails(
        flightBooking: mappedItinaries,
        airSearchRequest: airSearchRequest,
        requestUuid: airSearchRequest.requestId,
        travellerDetails: travellerDetails);
  }

  static AirSearchRequest mapFlightStateToAirSearchRequest(
      AirSearch airSearch) {
    List<AirSearchRequestBaseDetail> airSearchRequestBaseDetails =
        airSearch.sources.map((source) {
      return AirSearchRequestBaseDetail(
          fromAirport: source.source!.iataCode,
          toAirport: source.destination!.iataCode,
          requestedClass: airSearch.searchClass!.getRequestedClass(),
          requestedDate:
              CustomDateUtils.apiDayFormat(airSearch.sources[0].sourceDate!));
    }).toList();
    if (airSearch.sources.length == 1 &&
        airSearch.sources.first.returnDate != null) {
      airSearchRequestBaseDetails.add(AirSearchRequestBaseDetail(
          fromAirport: airSearch.sources.last.destination!.iataCode,
          toAirport: airSearch.sources.last.source!.iataCode,
          requestedClass: airSearch.searchClass!.getRequestedClass(),
          requestedDate: CustomDateUtils.apiDayFormat(
              airSearch.sources.last.returnDate!)));
    }
    return AirSearchRequest(
        adultCount: airSearch.adultCount,
        childCount: airSearch.childCount,
        infantCount: airSearch.infantCount,
        countryFrom: airSearch.sources[0].source!.country,
        countryTo: airSearch.sources.lastOrNull?.destination?.country!,
        paxCount: airSearch.adultCount + airSearch.childCount,
        requestId: airSearch.requestId,
        prefAirline: airSearch.preferredCarrier?.code,
        directFlight: airSearch.directFlight,
        journeyType: airSearch.sources.length == 1
            ? JourneyType.oneWay
            : JourneyType.Return,
        travelType: "AD",
        airSearchRequestBaseDetails: airSearchRequestBaseDetails);
  }

  static OrderDetails mapFlightStateToUpdatedOrderDetailWithPassengerDetails(
      FlightBookingLoaded flightBookingLoadedDetails) {
    // 'gstNumber':   this.billingDetail?.entityGST    ,
    //   'billingEntity':   this.billingDetail.entityRefId  ,
    //    'gstEmail':   this.billingDetail?.email   ,
    var billingEntity = flightBookingLoadedDetails.billingEntity;
    var passengerDetails = flightBookingLoadedDetails.passengerDetails;
    if (passengerDetails.isEmpty) {
      throw Exception("Passenger details are empty");
    }
    var firstPasseger = passengerDetails.first;
    var adultCount =
        passengerDetails.where((d) => d.passengerType.isAdult()).length;
    var childCount =
        passengerDetails.where((d) => d.passengerType.isChild()).length;
    var infantCount =
        passengerDetails.where((d) => d.passengerType.isInfant()).length;
    var paxCount = adultCount + childCount;
    var selectedSeats = flightBookingLoadedDetails.selectedSeats;
    var selectedSSr = flightBookingLoadedDetails.selectedSsr;
    var selectedBaggage = flightBookingLoadedDetails.selectedBaggage;
    var selectedSpecialRequests =
        flightBookingLoadedDetails.selectedSpecialRequests;

    var passengerDetailsList = passengerDetails.map((passenger) {
      var seatMeal = List<Segment>.empty(growable: true);

      // Handle seat selections
      if (selectedSeats.isNotEmpty) {
        for (var action in selectedSeats.entries) {
          var flightDetailsKey = action.key;
          var selectedSeatList = action.value;
          if (selectedSeatList.isNotEmpty) {
            var (carrierName, flightNumber, fromAirport, toAirport) =
                getFlightDetailFromSelectedSsrKeys(flightDetailsKey);
            seatMeal.add(Segment(
              carrierName: carrierName,
              flightNumber: flightNumber,
              from: fromAirport,
              to: toAirport,
              seatNumber: selectedSeatList.first.seat.column +
                  selectedSeatList.first.row,
              seatUnitKey: selectedSeatList.first.seat.unitKey,
              seatBasePrice: selectedSeatList.first.seat.baseFare,
            ));
            selectedSeats[flightDetailsKey]!.removeAt(0);
          }
        }
      }

      // Handle meal selections
      var passengerSsrs = extractPassengerSsrOptions(selectedSSr, passenger.id);
      passengerSsrs.forEach((segmentKey, ssrOptions) {
        if (ssrOptions.isNotEmpty) {
          for (var ssr in ssrOptions) {
            var (carrierName, flightNumber, fromAirport, toAirport) =
                getFlightDetailFromSelectedSsrKeys(segmentKey);
            seatMeal.add(Segment(
              carrierName: carrierName,
              flightNumber: flightNumber,
              from: fromAirport,
              to: toAirport,
              mealBasePrice: ssr.baseFare,
              mealPreferences: ssr.code,
              mealUnitKey: ssr.ssrKey,
            ));
          }
        }
      });

      // Handle baggage selections
      var passengerBaggage =
          extractPassengerSsrOptions(selectedBaggage, passenger.id);
      passengerBaggage.forEach((segmentKey, baggageOptions) {
        if (baggageOptions.isNotEmpty) {
          for (var baggage in baggageOptions) {
            var (carrierName, flightNumber, fromAirport, toAirport) =
                getFlightDetailFromSelectedSsrKeys(segmentKey);
            seatMeal.add(Segment(
              carrierName: carrierName,
              flightNumber: flightNumber,
              from: fromAirport,
              to: toAirport,
              baggageSsr: baggage.code,
              baggageSsrBasePrice: baggage.baseFare,
              baggageSsrUnitKey: baggage.ssrKey,
            ));
          }
        }
      });

      // Handle special request selections
      var passengerSpecialRequests =
          extractPassengerSsrOptions(selectedSpecialRequests, passenger.id);
      passengerSpecialRequests.forEach((segmentKey, specialRequestOptions) {
        if (specialRequestOptions.isNotEmpty) {
          for (var specialRequest in specialRequestOptions) {
            var (carrierName, flightNumber, fromAirport, toAirport) =
                getFlightDetailFromSelectedSsrKeys(segmentKey);
            seatMeal.add(Segment(
              carrierName: carrierName,
              flightNumber: flightNumber,
              from: fromAirport,
              to: toAirport,
              specialSsr: specialRequest.code,
              specialSsrBasePrice: specialRequest.baseFare,
              specialSsrUnitKey: specialRequest.ssrKey,
            ));
          }
        }
      });

      return PassengerDetails(
          firstName: passenger.name,
          lastName: passenger.lastName,
          passengerTitle: passenger.title.name,
          passengerType: passenger.passengerType.getPassengerTypeEnum,
          mobile: passenger.phoneNumber,
          gender: passenger.gender.name,
          dob: passenger.dob,
          reportingTags: [],
          seatMeal: seatMeal,
          email: passenger.email);
    }).toList();
    var bookingRequest = BookingRequest(
      adultCount: adultCount,
      childCount: childCount,
      infantCount: infantCount,
      paxCount: paxCount,
      passengerDetails: passengerDetailsList,
      gstEmail: billingEntity?.email,
      gstNumber: billingEntity?.entityGST,
      billingEntity: billingEntity?.entityRefId,
      contactNumber: firstPasseger.phoneNumber,
      email: firstPasseger.email,
    );
    return OrderDetails(
      bookingRequest: bookingRequest,
    );
  }

  static (String, String, String, String) getFlightDetailFromSelectedSsrKeys(
      String key) {
    // var key =
    //         "${flights.carrierName}-${flights.flightNumber}#${flights.fromAirport}#${flights.toAirport ?? ''}";
    var parts = key.split("#");
    if (parts.length < 3) {
      throw Exception("Invalid key format: $key");
    }
    String carrierName = parts[0].split("-").firstOrNull ?? "";
    String flightNumber = parts[0].split("-").lastOrNull ?? "";
    String fromAirport = parts[1];
    String toAirport = parts.length > 2 ? parts[2] : "";
    return (carrierName, flightNumber, fromAirport, toAirport);
  }

  static Map<String, List<SsrOption>> extractPassengerSsrOptions(
    Map<String, Map<String, SsrOption>> ssrMap,
    String passengerId,
  ) {
    return ssrMap.map((segmentId, passengerMap) {
      final ssrOption = passengerMap[passengerId];
      return MapEntry(segmentId, ssrOption != null ? [ssrOption] : []);
    });
  }
}
