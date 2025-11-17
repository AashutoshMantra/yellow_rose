import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:yellow_rose/core/utils/date_time_parser.dart';
import 'package:yellow_rose/core/utils/extensions.dart';
import 'package:yellow_rose/features/bus/data/models/order/bus_order__create_request.dart';
import 'package:yellow_rose/features/bus/data/models/order/bus_order_itinerary.dart';
import 'package:yellow_rose/features/flight/data/models/airsearch/air_search_request.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order/booking_channel_enum.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order_status/air_booking_status.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order_status/air_order_iitinerary.dart';
import 'package:yellow_rose/features/hotel/data/models/order/hotel_order_request.dart';

class OrderStatus {
  final int? id;

  final String? uuid;

  final String? requestUuid;

  // final Object flightBooking;

  final HotelOrderRequest? hotelBooking;

  final String? email;

  // final Object dupeValidation;

  final String? hotelSource;

  final String? bookingPaymentType;

  final String? hotelSupplier;

  final String? hotelContactNumber;

  final String? hotelContactEmail;

  final String? segmentType;

  final String? specialRequest;

  final String? tripId;

  // final UserTypeEnum lob;

  final String? branch;

  final int whiteLabelId;

  final String? cartType;

  final BookingChannelEnum channel;

  final String? riskScore;

  final String? contactNumber;

  final String? gstNumber;

  final String? gstEmail;

  final String? billingEntity;

  final AirBookingStatusEnum? status;

  final String? ipAddress;

  final String? Latitude;

  final String? Longitude;

  final String? pnr;

  final String? bookingId;

  final String? cabinClass;

  final String? orderError;

  final String? paymentMedium;

  final bool? isAirGrouped;

  final List<AirOrderItinerary>? airItineraries;

  // final List<FinanceInvoice>? invoiceData;

  final String? invoiceStatus;

  final String? approvalStatus;

  final AirBookingStatusEnum? bookingStatus;

  final String? paymentStatus;

  final int? paymentTryCount;

  final String? bookingUser;

  final String? corporate;

  final String? createdBy;

  final String? DocNo;

  final String? CreditDocNo;

  final String? bookedFor;

  // final Object? businessConfig;
  // final Object? hotelDetailsConfig;

  // final Object? errorDetails;

  // final Object? priceData;

  // final Object? travellerDetail;

  final AirSearchRequest? searchRequest;

  final DateTime? creationTs;

  final DateTime? modTs;

  final DateTime? bookingTs;

  final DateTime? bookingRequestTs;

  final DateTime? invoicingTs;

  final String? tripApprovalStatus;

  final bool? emailAllowed;

  final bool? showTicketPricing;

  final String? userBookingContext;

  //BUS
  final BusOrderCreateRequest? busBooking;
  final String? busSource;
  final String? busSupplier;
  final String? busContactNumber;
  final String? busContactEmail;
  final List<BusOrderItinerary>? busOrderItineraries;

  OrderStatus({
    this.id,
    this.uuid,
    this.requestUuid,
    this.hotelBooking,
    this.email,
    this.hotelSource,
    this.bookingPaymentType,
    this.hotelSupplier,
    this.hotelContactNumber,
    this.hotelContactEmail,
    this.segmentType,
    this.specialRequest,
    this.tripId,
    this.branch,
    required this.whiteLabelId,
    this.cartType,
    required this.channel,
    this.riskScore,
    this.contactNumber,
    this.gstNumber,
    this.gstEmail,
    this.billingEntity,
    this.status,
    this.ipAddress,
    this.Latitude,
    this.Longitude,
    this.pnr,
    this.bookingId,
    this.cabinClass,
    this.orderError,
    this.paymentMedium,
    this.isAirGrouped,
    this.airItineraries,
    this.invoiceStatus,
    this.approvalStatus,
    this.bookingStatus,
    this.paymentStatus,
    this.paymentTryCount,
    this.bookingUser,
    this.corporate,
    this.createdBy,
    this.DocNo,
    this.CreditDocNo,
    this.bookedFor,
    this.searchRequest,
    this.creationTs,
    this.modTs,
    this.bookingTs,
    this.bookingRequestTs,
    this.invoicingTs,
    this.tripApprovalStatus,
    this.emailAllowed,
    this.showTicketPricing,
    this.userBookingContext,
    this.busBooking,
    this.busSource,
    this.busSupplier,
    this.busContactNumber,
    this.busContactEmail,
    this.busOrderItineraries,
  });

  OrderStatus copyWith({
    int? id,
    String? uuid,
    String? requestUuid,
    HotelOrderRequest? hotelBooking,
    String? email,
    String? hotelSource,
    String? bookingPaymentType,
    String? hotelSupplier,
    String? hotelContactNumber,
    String? hotelContactEmail,
    String? segmentType,
    String? specialRequest,
    String? tripId,
    String? branch,
    int? whiteLabelId,
    String? cartType,
    BookingChannelEnum? channel,
    String? riskScore,
    String? contactNumber,
    String? gstNumber,
    String? gstEmail,
    String? billingEntity,
    AirBookingStatusEnum? status,
    String? ipAddress,
    String? Latitude,
    String? Longitude,
    String? pnr,
    String? bookingId,
    String? cabinClass,
    String? orderError,
    String? paymentMedium,
    bool? isAirGrouped,
    List<AirOrderItinerary>? airItineraries,
    String? invoiceStatus,
    String? approvalStatus,
    AirBookingStatusEnum? bookingStatus,
    String? paymentStatus,
    int? paymentTryCount,
    String? bookingUser,
    String? corporate,
    String? createdBy,
    String? DocNo,
    String? CreditDocNo,
    String? bookedFor,
    AirSearchRequest? searchRequest,
    DateTime? creationTs,
    DateTime? modTs,
    DateTime? bookingTs,
    DateTime? bookingRequestTs,
    DateTime? invoicingTs,
    String? tripApprovalStatus,
    bool? emailAllowed,
    bool? showTicketPricing,
    String? userBookingContext,
    BusOrderCreateRequest? busBooking,
    String? busSource,
    String? busSupplier,
    String? busContactNumber,
    String? busContactEmail,
    List<BusOrderItinerary>? busOrderItineraries,
  }) {
    return OrderStatus(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      requestUuid: requestUuid ?? this.requestUuid,
      hotelBooking: hotelBooking ?? this.hotelBooking,
      email: email ?? this.email,
      hotelSource: hotelSource ?? this.hotelSource,
      bookingPaymentType: bookingPaymentType ?? this.bookingPaymentType,
      hotelSupplier: hotelSupplier ?? this.hotelSupplier,
      hotelContactNumber: hotelContactNumber ?? this.hotelContactNumber,
      hotelContactEmail: hotelContactEmail ?? this.hotelContactEmail,
      segmentType: segmentType ?? this.segmentType,
      specialRequest: specialRequest ?? this.specialRequest,
      tripId: tripId ?? this.tripId,
      branch: branch ?? this.branch,
      whiteLabelId: whiteLabelId ?? this.whiteLabelId,
      cartType: cartType ?? this.cartType,
      channel: channel ?? this.channel,
      riskScore: riskScore ?? this.riskScore,
      contactNumber: contactNumber ?? this.contactNumber,
      gstNumber: gstNumber ?? this.gstNumber,
      gstEmail: gstEmail ?? this.gstEmail,
      billingEntity: billingEntity ?? this.billingEntity,
      status: status ?? this.status,
      ipAddress: ipAddress ?? this.ipAddress,
      Latitude: Latitude ?? this.Latitude,
      Longitude: Longitude ?? this.Longitude,
      pnr: pnr ?? this.pnr,
      bookingId: bookingId ?? this.bookingId,
      cabinClass: cabinClass ?? this.cabinClass,
      orderError: orderError ?? this.orderError,
      paymentMedium: paymentMedium ?? this.paymentMedium,
      isAirGrouped: isAirGrouped ?? this.isAirGrouped,
      airItineraries: airItineraries ?? this.airItineraries,
      invoiceStatus: invoiceStatus ?? this.invoiceStatus,
      approvalStatus: approvalStatus ?? this.approvalStatus,
      bookingStatus: bookingStatus ?? this.bookingStatus,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      paymentTryCount: paymentTryCount ?? this.paymentTryCount,
      bookingUser: bookingUser ?? this.bookingUser,
      corporate: corporate ?? this.corporate,
      createdBy: createdBy ?? this.createdBy,
      DocNo: DocNo ?? this.DocNo,
      CreditDocNo: CreditDocNo ?? this.CreditDocNo,
      bookedFor: bookedFor ?? this.bookedFor,
      searchRequest: searchRequest ?? this.searchRequest,
      creationTs: creationTs ?? this.creationTs,
      modTs: modTs ?? this.modTs,
      bookingTs: bookingTs ?? this.bookingTs,
      bookingRequestTs: bookingRequestTs ?? this.bookingRequestTs,
      invoicingTs: invoicingTs ?? this.invoicingTs,
      tripApprovalStatus: tripApprovalStatus ?? this.tripApprovalStatus,
      emailAllowed: emailAllowed ?? this.emailAllowed,
      showTicketPricing: showTicketPricing ?? this.showTicketPricing,
      userBookingContext: userBookingContext ?? this.userBookingContext,
      busBooking: busBooking ?? this.busBooking,
      busSource: busSource ?? this.busSource,
      busSupplier: busSupplier ?? this.busSupplier,
      busContactNumber: busContactNumber ?? this.busContactNumber,
      busContactEmail: busContactEmail ?? this.busContactEmail,
      busOrderItineraries: busOrderItineraries ?? this.busOrderItineraries,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (uuid != null) {
      result.addAll({'uuid': uuid});
    }
    if (requestUuid != null) {
      result.addAll({'requestUuid': requestUuid});
    }
    if (hotelBooking != null) {
      result.addAll({'hotelBooking': hotelBooking!.toMap()});
    }
    if (email != null) {
      result.addAll({'email': email});
    }
    if (hotelSource != null) {
      result.addAll({'hotelSource': hotelSource});
    }
    if (bookingPaymentType != null) {
      result.addAll({'bookingPaymentType': bookingPaymentType});
    }
    if (hotelSupplier != null) {
      result.addAll({'hotelSupplier': hotelSupplier});
    }
    if (hotelContactNumber != null) {
      result.addAll({'hotelContactNumber': hotelContactNumber});
    }
    if (hotelContactEmail != null) {
      result.addAll({'hotelContactEmail': hotelContactEmail});
    }
    if (segmentType != null) {
      result.addAll({'segmentType': segmentType});
    }
    if (specialRequest != null) {
      result.addAll({'specialRequest': specialRequest});
    }
    if (tripId != null) {
      result.addAll({'tripId': tripId});
    }
    if (branch != null) {
      result.addAll({'branch': branch});
    }
    result.addAll({'whiteLabelId': whiteLabelId});
    if (cartType != null) {
      result.addAll({'cartType': cartType});
    }
    result.addAll({'channel': channel.name});
    if (riskScore != null) {
      result.addAll({'riskScore': riskScore});
    }
    if (contactNumber != null) {
      result.addAll({'contactNumber': contactNumber});
    }
    if (gstNumber != null) {
      result.addAll({'gstNumber': gstNumber});
    }
    if (gstEmail != null) {
      result.addAll({'gstEmail': gstEmail});
    }
    if (billingEntity != null) {
      result.addAll({'billingEntity': billingEntity});
    }
    if (status != null) {
      result.addAll({'status': status!.name});
    }
    if (ipAddress != null) {
      result.addAll({'ipAddress': ipAddress});
    }
    if (Latitude != null) {
      result.addAll({'Latitude': Latitude});
    }
    if (Longitude != null) {
      result.addAll({'Longitude': Longitude});
    }
    if (pnr != null) {
      result.addAll({'pnr': pnr});
    }
    if (bookingId != null) {
      result.addAll({'bookingId': bookingId});
    }
    if (cabinClass != null) {
      result.addAll({'cabinClass': cabinClass});
    }
    if (orderError != null) {
      result.addAll({'orderError': orderError});
    }
    if (paymentMedium != null) {
      result.addAll({'paymentMedium': paymentMedium});
    }
    if (isAirGrouped != null) {
      result.addAll({'isAirGrouped': isAirGrouped});
    }
    if (airItineraries != null) {
      result.addAll(
          {'airItineraries': airItineraries!.map((x) => x.toMap()).toList()});
    }
    if (invoiceStatus != null) {
      result.addAll({'invoiceStatus': invoiceStatus});
    }
    if (approvalStatus != null) {
      result.addAll({'approvalStatus': approvalStatus});
    }
    if (bookingStatus != null) {
      result.addAll({'bookingStatus': bookingStatus!.name});
    }
    if (paymentStatus != null) {
      result.addAll({'paymentStatus': paymentStatus});
    }
    if (paymentTryCount != null) {
      result.addAll({'paymentTryCount': paymentTryCount});
    }
    if (bookingUser != null) {
      result.addAll({'bookingUser': bookingUser});
    }
    if (corporate != null) {
      result.addAll({'corporate': corporate});
    }
    if (createdBy != null) {
      result.addAll({'createdBy': createdBy});
    }
    if (DocNo != null) {
      result.addAll({'DocNo': DocNo});
    }
    if (CreditDocNo != null) {
      result.addAll({'CreditDocNo': CreditDocNo});
    }
    if (bookedFor != null) {
      result.addAll({'bookedFor': bookedFor});
    }
    if (searchRequest != null) {
      result.addAll({'searchRequest': searchRequest!.toMap()});
    }
    if (creationTs != null) {
      result.addAll({'creationTs': creationTs!.millisecondsSinceEpoch});
    }
    if (modTs != null) {
      result.addAll({'modTs': modTs!.millisecondsSinceEpoch});
    }
    if (bookingTs != null) {
      result.addAll({'bookingTs': bookingTs!.millisecondsSinceEpoch});
    }
    if (bookingRequestTs != null) {
      result.addAll(
          {'bookingRequestTs': bookingRequestTs!.millisecondsSinceEpoch});
    }
    if (invoicingTs != null) {
      result.addAll({'invoicingTs': invoicingTs!.millisecondsSinceEpoch});
    }
    if (tripApprovalStatus != null) {
      result.addAll({'tripApprovalStatus': tripApprovalStatus});
    }
    if (emailAllowed != null) {
      result.addAll({'emailAllowed': emailAllowed});
    }
    if (showTicketPricing != null) {
      result.addAll({'showTicketPricing': showTicketPricing});
    }
    if (userBookingContext != null) {
      result.addAll({'userBookingContext': userBookingContext});
    }
    if (busBooking != null) {
      result.addAll({'busBooking': busBooking!.toMap()});
    }
    if (busSource != null) {
      result.addAll({'busSource': busSource});
    }
    if (busSupplier != null) {
      result.addAll({'busSupplier': busSupplier});
    }
    if (busContactNumber != null) {
      result.addAll({'busContactNumber': busContactNumber});
    }
    if (busContactEmail != null) {
      result.addAll({'busContactEmail': busContactEmail});
    }
    if (busOrderItineraries != null) {
      result.addAll({
        'busOrderItineraries':
            busOrderItineraries!.map((x) => x.toMap()).toList()
      });
    }

    return result;
  }

  factory OrderStatus.fromMap(Map<String, dynamic> map) {
    return OrderStatus(
      id: map['id']?.toInt(),
      uuid: map['uuid'],
      requestUuid: map['requestUuid'],
      hotelBooking: map['hotelBooking'] != null
          ? HotelOrderRequest.fromMap(map['hotelBooking'])
          : null,
      email: map['email'],
      hotelSource: map['hotelSource'],
      bookingPaymentType: map['bookingPaymentType'],
      hotelSupplier: map['hotelSupplier'],
      hotelContactNumber: map['hotelContactNumber'],
      hotelContactEmail: map['hotelContactEmail'],
      segmentType: map['segmentType'],
      specialRequest: map['specialRequest'],
      tripId: map['tripId'],
      branch: map['branch'],
      whiteLabelId: map['whiteLabelId']?.toInt() ?? 0,
      cartType: map['cartType'],
      channel: (map['channel'] as String?)?.toEnum(BookingChannelEnum.values) ??
          BookingChannelEnum.APP,
      riskScore: map['riskScore'],
      contactNumber: map['contactNumber'],
      gstNumber: map['gstNumber'],
      gstEmail: map['gstEmail'],
      billingEntity: map['billingEntity'],
      status: map['status'] != null
          ? AirBookingStatusEnum.getFromCode(map['status'])
          : AirBookingStatusEnum.NEW,
      ipAddress: map['ipAddress'],
      Latitude: map['Latitude'],
      Longitude: map['Longitude'],
      pnr: map['pnr'],
      bookingId: map['bookingId'],
      cabinClass: map['cabinClass'],
      orderError: map['orderError'],
      paymentMedium: map['paymentMedium'],
      isAirGrouped: map['isAirGrouped'],
      airItineraries: map['airItineraries'] != null
          ? List<AirOrderItinerary>.from(
              map['airItineraries']?.map((x) => AirOrderItinerary.fromMap(x)))
          : null,
      invoiceStatus: map['invoiceStatus'],
      approvalStatus: map['approvalStatus'],
      bookingStatus: map['bookingStatus'] != null
          ? AirBookingStatusEnum.getFromCode(map['bookingStatus'])
          : AirBookingStatusEnum.NEW,
      paymentStatus: map['paymentStatus'],
      paymentTryCount: map['paymentTryCount']?.toInt(),
      bookingUser: map['bookingUser'],
      corporate: map['corporate'],
      createdBy: map['createdBy'],
      DocNo: map['DocNo'],
      CreditDocNo: map['CreditDocNo'],
      bookedFor: map['bookedFor'],
      searchRequest: map['searchRequest'] != null
          ? AirSearchRequest.fromMap(map['searchRequest'])
          : null,
      creationTs: map['creationTs'] != null
          ? DateTime.tryParse(map['creationTs'])
          : null,
      modTs: map['modTs'] != null ? DateTime.tryParse(map['modTs']) : null,
      bookingTs:
          map['bookingTs'] != null ? DateTime.tryParse(map['bookingTs']) : null,
      bookingRequestTs: map['bookingRequestTs'] != null
          ? DateTime.tryParse(map['bookingRequestTs'])
          : null,
      invoicingTs: map['invoicingTs'] != null
          ? DateTime.tryParse(map['invoicingTs'])
          : null,
      tripApprovalStatus: map['tripApprovalStatus'],
      emailAllowed: map['emailAllowed'],
      showTicketPricing: map['showTicketPricing'],
      userBookingContext: map['userBookingContext'],
      busBooking: map['busBooking'] != null
          ? BusOrderCreateRequest.fromMap(map['busBooking'])
          : null,
      busSource: map['busSource'],
      busSupplier: map['busSupplier'],
      busContactNumber: map['busContactNumber'],
      busContactEmail: map['busContactEmail'],
      busOrderItineraries: map['busOrderItineraries'] != null
          ? List<BusOrderItinerary>.from(map['busOrderItineraries']
              ?.map((x) => BusOrderItinerary.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderStatus.fromJson(String source) =>
      OrderStatus.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OrderStatus(id: $id, uuid: $uuid, requestUuid: $requestUuid, hotelBooking: $hotelBooking, email: $email, hotelSource: $hotelSource, bookingPaymentType: $bookingPaymentType, hotelSupplier: $hotelSupplier, hotelContactNumber: $hotelContactNumber, hotelContactEmail: $hotelContactEmail, segmentType: $segmentType, specialRequest: $specialRequest, tripId: $tripId, branch: $branch, whiteLabelId: $whiteLabelId, cartType: $cartType, channel: $channel, riskScore: $riskScore, contactNumber: $contactNumber, gstNumber: $gstNumber, gstEmail: $gstEmail, billingEntity: $billingEntity, status: $status, ipAddress: $ipAddress, Latitude: $Latitude, Longitude: $Longitude, pnr: $pnr, bookingId: $bookingId, cabinClass: $cabinClass, orderError: $orderError, paymentMedium: $paymentMedium, isAirGrouped: $isAirGrouped, airItineraries: $airItineraries, invoiceStatus: $invoiceStatus, approvalStatus: $approvalStatus, bookingStatus: $bookingStatus, paymentStatus: $paymentStatus, paymentTryCount: $paymentTryCount, bookingUser: $bookingUser, corporate: $corporate, createdBy: $createdBy, DocNo: $DocNo, CreditDocNo: $CreditDocNo, bookedFor: $bookedFor, searchRequest: $searchRequest, creationTs: $creationTs, modTs: $modTs, bookingTs: $bookingTs, bookingRequestTs: $bookingRequestTs, invoicingTs: $invoicingTs, tripApprovalStatus: $tripApprovalStatus, emailAllowed: $emailAllowed, showTicketPricing: $showTicketPricing, userBookingContext: $userBookingContext, busBooking: $busBooking, busSource: $busSource, busSupplier: $busSupplier, busContactNumber: $busContactNumber, busContactEmail: $busContactEmail, busOrderItineraries: $busOrderItineraries)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrderStatus &&
        other.id == id &&
        other.uuid == uuid &&
        other.requestUuid == requestUuid &&
        other.hotelBooking == hotelBooking &&
        other.email == email &&
        other.hotelSource == hotelSource &&
        other.bookingPaymentType == bookingPaymentType &&
        other.hotelSupplier == hotelSupplier &&
        other.hotelContactNumber == hotelContactNumber &&
        other.hotelContactEmail == hotelContactEmail &&
        other.segmentType == segmentType &&
        other.specialRequest == specialRequest &&
        other.tripId == tripId &&
        other.branch == branch &&
        other.whiteLabelId == whiteLabelId &&
        other.cartType == cartType &&
        other.channel == channel &&
        other.riskScore == riskScore &&
        other.contactNumber == contactNumber &&
        other.gstNumber == gstNumber &&
        other.gstEmail == gstEmail &&
        other.billingEntity == billingEntity &&
        other.status == status &&
        other.ipAddress == ipAddress &&
        other.Latitude == Latitude &&
        other.Longitude == Longitude &&
        other.pnr == pnr &&
        other.bookingId == bookingId &&
        other.cabinClass == cabinClass &&
        other.orderError == orderError &&
        other.paymentMedium == paymentMedium &&
        other.isAirGrouped == isAirGrouped &&
        listEquals(other.airItineraries, airItineraries) &&
        other.invoiceStatus == invoiceStatus &&
        other.approvalStatus == approvalStatus &&
        other.bookingStatus == bookingStatus &&
        other.paymentStatus == paymentStatus &&
        other.paymentTryCount == paymentTryCount &&
        other.bookingUser == bookingUser &&
        other.corporate == corporate &&
        other.createdBy == createdBy &&
        other.DocNo == DocNo &&
        other.CreditDocNo == CreditDocNo &&
        other.bookedFor == bookedFor &&
        other.searchRequest == searchRequest &&
        other.creationTs == creationTs &&
        other.modTs == modTs &&
        other.bookingTs == bookingTs &&
        other.bookingRequestTs == bookingRequestTs &&
        other.invoicingTs == invoicingTs &&
        other.tripApprovalStatus == tripApprovalStatus &&
        other.emailAllowed == emailAllowed &&
        other.showTicketPricing == showTicketPricing &&
        other.userBookingContext == userBookingContext &&
        other.busBooking == busBooking &&
        other.busSource == busSource &&
        other.busSupplier == busSupplier &&
        other.busContactNumber == busContactNumber &&
        other.busContactEmail == busContactEmail &&
        listEquals(other.busOrderItineraries, busOrderItineraries);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        uuid.hashCode ^
        requestUuid.hashCode ^
        hotelBooking.hashCode ^
        email.hashCode ^
        hotelSource.hashCode ^
        bookingPaymentType.hashCode ^
        hotelSupplier.hashCode ^
        hotelContactNumber.hashCode ^
        hotelContactEmail.hashCode ^
        segmentType.hashCode ^
        specialRequest.hashCode ^
        tripId.hashCode ^
        branch.hashCode ^
        whiteLabelId.hashCode ^
        cartType.hashCode ^
        channel.hashCode ^
        riskScore.hashCode ^
        contactNumber.hashCode ^
        gstNumber.hashCode ^
        gstEmail.hashCode ^
        billingEntity.hashCode ^
        status.hashCode ^
        ipAddress.hashCode ^
        Latitude.hashCode ^
        Longitude.hashCode ^
        pnr.hashCode ^
        bookingId.hashCode ^
        cabinClass.hashCode ^
        orderError.hashCode ^
        paymentMedium.hashCode ^
        isAirGrouped.hashCode ^
        airItineraries.hashCode ^
        invoiceStatus.hashCode ^
        approvalStatus.hashCode ^
        bookingStatus.hashCode ^
        paymentStatus.hashCode ^
        paymentTryCount.hashCode ^
        bookingUser.hashCode ^
        corporate.hashCode ^
        createdBy.hashCode ^
        DocNo.hashCode ^
        CreditDocNo.hashCode ^
        bookedFor.hashCode ^
        searchRequest.hashCode ^
        creationTs.hashCode ^
        modTs.hashCode ^
        bookingTs.hashCode ^
        bookingRequestTs.hashCode ^
        invoicingTs.hashCode ^
        tripApprovalStatus.hashCode ^
        emailAllowed.hashCode ^
        showTicketPricing.hashCode ^
        userBookingContext.hashCode ^
        busBooking.hashCode ^
        busSource.hashCode ^
        busSupplier.hashCode ^
        busContactNumber.hashCode ^
        busContactEmail.hashCode ^
        busOrderItineraries.hashCode;
  }
}
