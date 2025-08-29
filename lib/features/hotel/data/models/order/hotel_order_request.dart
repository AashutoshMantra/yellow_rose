import 'dart:convert';

import 'package:yellow_rose/features/flight/data/models/booking/order/booking_channel_enum.dart';
import 'package:yellow_rose/features/flight/data/models/payment.dart';
import 'package:yellow_rose/features/hotel/data/models/details/hotel_detail_resonse.dart';
import 'package:yellow_rose/features/hotel/data/models/order/hotel_booking_request.dart';
import 'package:yellow_rose/features/hotel/data/models/order/hotel_traveller_detail_count.dart';
import 'package:yellow_rose/features/hotel/data/models/order/order_hotel_request.dart';
import 'package:yellow_rose/features/hotel/data/models/search/hotel_search_request.dart';

class HotelOrderRequest {
  final BookingChannelEnum channel;
  final HotelListSearchRequest? hotelRequest;
  final String? orderId;
  final String? bookingId;
  final String? bookingStatus;
  final String? paymentMedium;
  final String? requestUuid;
  final HotelTravellerDetailCount? travellerDetails;
  final String? contactNumber;
  final String? email;
  final String? gstNumber;
  final String? billingEntity;
  final String? hotelContactEmail;
  final String? hotelContactNumber;
  final String? gstEmail;
  final Payment? payment;
  final String? bookedFor;
  final String? bookedBy;
  final String? branch;
  final String? userUid;
  final String? tripUid;
  final String? source;
  final String? supplier;
  final String? bookingPaymentType;
  final int? whiteLabelId;
  final HotelBookingRequest? hotelBookingRequest;
  final HotelDetailResponse? selectedHotelOrder;
  HotelOrderRequest({
    this.channel = BookingChannelEnum.APP,
    this.hotelRequest,
    this.orderId,
    this.bookingId,
    this.bookingStatus,
    this.paymentMedium,
    this.requestUuid,
    this.travellerDetails,
    this.contactNumber,
    this.email,
    this.gstNumber,
    this.billingEntity,
    this.hotelContactEmail,
    this.hotelContactNumber,
    this.gstEmail,
    this.payment,
    this.bookedFor,
    this.bookedBy,
    this.branch,
    this.userUid,
    this.tripUid,
    this.source,
    this.supplier,
    this.bookingPaymentType,
    this.whiteLabelId,
    this.hotelBookingRequest,
    this.selectedHotelOrder,
  });

  HotelOrderRequest copyWith({
    BookingChannelEnum? channel,
    HotelListSearchRequest? hotelRequest,
    String? orderId,
    String? bookingId,
    String? bookingStatus,
    String? paymentMedium,
    String? requestUuid,
    HotelTravellerDetailCount? travellerDetails,
    String? contactNumber,
    String? email,
    String? gstNumber,
    String? billingEntity,
    String? hotelContactEmail,
    String? hotelContactNumber,
    String? gstEmail,
    Payment? payment,
    String? bookedFor,
    String? bookedBy,
    String? branch,
    String? userUid,
    String? tripUid,
    String? source,
    String? supplier,
    String? bookingPaymentType,
    int? whiteLabelId,
    HotelBookingRequest? hotelBookingRequest,
    HotelDetailResponse? selectedHotelOrder,
  }) {
    return HotelOrderRequest(
      channel: channel ?? this.channel,
      hotelRequest: hotelRequest ?? this.hotelRequest,
      orderId: orderId ?? this.orderId,
      bookingId: bookingId ?? this.bookingId,
      bookingStatus: bookingStatus ?? this.bookingStatus,
      paymentMedium: paymentMedium ?? this.paymentMedium,
      requestUuid: requestUuid ?? this.requestUuid,
      travellerDetails: travellerDetails ?? this.travellerDetails,
      contactNumber: contactNumber ?? this.contactNumber,
      email: email ?? this.email,
      gstNumber: gstNumber ?? this.gstNumber,
      billingEntity: billingEntity ?? this.billingEntity,
      hotelContactEmail: hotelContactEmail ?? this.hotelContactEmail,
      hotelContactNumber: hotelContactNumber ?? this.hotelContactNumber,
      gstEmail: gstEmail ?? this.gstEmail,
      payment: payment ?? this.payment,
      bookedFor: bookedFor ?? this.bookedFor,
      bookedBy: bookedBy ?? this.bookedBy,
      branch: branch ?? this.branch,
      userUid: userUid ?? this.userUid,
      tripUid: tripUid ?? this.tripUid,
      source: source ?? this.source,
      supplier: supplier ?? this.supplier,
      bookingPaymentType: bookingPaymentType ?? this.bookingPaymentType,
      whiteLabelId: whiteLabelId ?? this.whiteLabelId,
      hotelBookingRequest: hotelBookingRequest ?? this.hotelBookingRequest,
      selectedHotelOrder: selectedHotelOrder ?? this.selectedHotelOrder,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'channel': channel.name});
    if (hotelRequest != null) {
      result.addAll({'hotelRequest': hotelRequest!.toMap()});
    }
    if (orderId != null) {
      result.addAll({'orderId': orderId});
    }
    if (bookingId != null) {
      result.addAll({'bookingId': bookingId});
    }
    if (bookingStatus != null) {
      result.addAll({'bookingStatus': bookingStatus});
    }
    if (paymentMedium != null) {
      result.addAll({'paymentMedium': paymentMedium});
    }
    if (requestUuid != null) {
      result.addAll({'requestUuid': requestUuid});
    }
    if (travellerDetails != null) {
      result.addAll({'travellerDetails': travellerDetails!.toMap()});
    }
    if (contactNumber != null) {
      result.addAll({'contactNumber': contactNumber});
    }
    if (email != null) {
      result.addAll({'email': email});
    }
    if (gstNumber != null) {
      result.addAll({'gstNumber': gstNumber});
    }
    if (billingEntity != null) {
      result.addAll({'billingEntity': billingEntity});
    }
    if (hotelContactEmail != null) {
      result.addAll({'hotelContactEmail': hotelContactEmail});
    }
    if (hotelContactNumber != null) {
      result.addAll({'hotelContactNumber': hotelContactNumber});
    }
    if (gstEmail != null) {
      result.addAll({'gstEmail': gstEmail});
    }
    if (payment != null) {
      result.addAll({'payment': payment!.toMap()});
    }
    if (bookedFor != null) {
      result.addAll({'bookedFor': bookedFor});
    }
    if (bookedBy != null) {
      result.addAll({'bookedBy': bookedBy});
    }
    if (branch != null) {
      result.addAll({'branch': branch});
    }
    if (userUid != null) {
      result.addAll({'userUid': userUid});
    }
    if (tripUid != null) {
      result.addAll({'tripUid': tripUid});
    }
    if (source != null) {
      result.addAll({'source': source});
    }
    if (supplier != null) {
      result.addAll({'supplier': supplier});
    }
    if (bookingPaymentType != null) {
      result.addAll({'bookingPaymentType': bookingPaymentType});
    }
    if (whiteLabelId != null) {
      result.addAll({'whiteLabelId': whiteLabelId});
    }
    if (hotelBookingRequest != null) {
      result.addAll({'hotelBookingRequest': hotelBookingRequest!.toMap()});
    }
    if (selectedHotelOrder != null) {
      result.addAll({'selectedHotelOrder': selectedHotelOrder!.toMap()});
    }

    return result;
  }

  factory HotelOrderRequest.fromMap(Map<String, dynamic> map) {
    return HotelOrderRequest(
      channel: BookingChannelEnum.values.firstWhere(
          (e) => e.name == map['channel'],
          orElse: () => BookingChannelEnum.APP),
      hotelRequest: HotelListSearchRequest.fromMap(map['hotelRequest']),
      orderId: map['orderId'],
      bookingId: map['bookingId'],
      bookingStatus: map['bookingStatus'],
      paymentMedium: map['paymentMedium'],
      requestUuid: map['requestUuid'],
      travellerDetails: map['travellerDetails'] != null
          ? HotelTravellerDetailCount.fromMap(map['travellerDetails'])
          : null,
      contactNumber: map['contactNumber'],
      email: map['email'],
      gstNumber: map['gstNumber'],
      billingEntity: map['billingEntity'],
      hotelContactEmail: map['hotelContactEmail'],
      hotelContactNumber: map['hotelContactNumber'],
      gstEmail: map['gstEmail'],
      payment: map['payment'] != null ? Payment.fromMap(map['payment']) : null,
      bookedFor: map['bookedFor'],
      bookedBy: map['bookedBy'],
      branch: map['branch'],
      userUid: map['userUid'],
      tripUid: map['tripUid'],
      source: map['source'],
      supplier: map['supplier'],
      bookingPaymentType: map['bookingPaymentType'],
      whiteLabelId: map['whiteLabelId']?.toInt(),
      hotelBookingRequest: map['hotelBookingRequest'] != null
          ? HotelBookingRequest.fromMap(map['hotelBookingRequest'])
          : null,
      selectedHotelOrder: map['selectedHotelOrder'] != null
          ? HotelDetailResponse.fromMap(map['selectedHotelOrder'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory HotelOrderRequest.fromJson(String source) =>
      HotelOrderRequest.fromMap(json.decode(source));

  @override
  String toString() {
    return 'HotelOrderRequest(channel: $channel, hotelRequest: $hotelRequest, orderId: $orderId, bookingId: $bookingId, bookingStatus: $bookingStatus, paymentMedium: $paymentMedium, requestUuid: $requestUuid, travellerDetails: $travellerDetails, contactNumber: $contactNumber, email: $email, gstNumber: $gstNumber, billingEntity: $billingEntity, hotelContactEmail: $hotelContactEmail, hotelContactNumber: $hotelContactNumber, gstEmail: $gstEmail, payment: $payment, bookedFor: $bookedFor, bookedBy: $bookedBy, branch: $branch, userUid: $userUid, tripUid: $tripUid, source: $source, supplier: $supplier, bookingPaymentType: $bookingPaymentType, whiteLabelId: $whiteLabelId, hotelBookingRequest: $hotelBookingRequest, selectedHotelOrder: $selectedHotelOrder)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HotelOrderRequest &&
        other.channel == channel &&
        other.hotelRequest == hotelRequest &&
        other.orderId == orderId &&
        other.bookingId == bookingId &&
        other.bookingStatus == bookingStatus &&
        other.paymentMedium == paymentMedium &&
        other.requestUuid == requestUuid &&
        other.travellerDetails == travellerDetails &&
        other.contactNumber == contactNumber &&
        other.email == email &&
        other.gstNumber == gstNumber &&
        other.billingEntity == billingEntity &&
        other.hotelContactEmail == hotelContactEmail &&
        other.hotelContactNumber == hotelContactNumber &&
        other.gstEmail == gstEmail &&
        other.payment == payment &&
        other.bookedFor == bookedFor &&
        other.bookedBy == bookedBy &&
        other.branch == branch &&
        other.userUid == userUid &&
        other.tripUid == tripUid &&
        other.source == source &&
        other.supplier == supplier &&
        other.bookingPaymentType == bookingPaymentType &&
        other.whiteLabelId == whiteLabelId &&
        other.hotelBookingRequest == hotelBookingRequest &&
        other.selectedHotelOrder == selectedHotelOrder;
  }

  @override
  int get hashCode {
    return channel.hashCode ^
        hotelRequest.hashCode ^
        orderId.hashCode ^
        bookingId.hashCode ^
        bookingStatus.hashCode ^
        paymentMedium.hashCode ^
        requestUuid.hashCode ^
        travellerDetails.hashCode ^
        contactNumber.hashCode ^
        email.hashCode ^
        gstNumber.hashCode ^
        billingEntity.hashCode ^
        hotelContactEmail.hashCode ^
        hotelContactNumber.hashCode ^
        gstEmail.hashCode ^
        payment.hashCode ^
        bookedFor.hashCode ^
        bookedBy.hashCode ^
        branch.hashCode ^
        userUid.hashCode ^
        tripUid.hashCode ^
        source.hashCode ^
        supplier.hashCode ^
        bookingPaymentType.hashCode ^
        whiteLabelId.hashCode ^
        hotelBookingRequest.hashCode ^
        selectedHotelOrder.hashCode;
  }
}
