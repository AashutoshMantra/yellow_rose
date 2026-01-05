import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:yellow_rose/features/flight/data/models/booking/order/customer_payment.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order/order_passenger_details.dart';

class HotelOrderItems {
  final int? id;

  final String? uuid;

  final String? orderUuid;

  final String? destination;

  final String? hotel;

  final String? segmentType;

  final String? bookingNumber;

  final String? type;

  final String? city;

  final String? state;

  final String? itineraryReqId;

  final String? country;

  final String? pinCode;

  final String? address;

  final String? longitude;

  final String? latitude;

  final String? cancellationType;

  final String? status;

  final String? bookingStatus;

  // final BookingOrder orderId;

  final List<OrdersPassengersDetails>? orderPassengerDetails;

  // final List<HoteltineraryPayment> payment;

  // private Object hotelConfirmation;

  // private Object dealCode;

  // private Object hotelRoomRequest;

  // private Object hotelDetails;

  final CustomerPayment? customerPayment;

  final Map<String, Object>? errorDetails;

  final DateTime? travelDate;
  HotelOrderItems({
    this.id,
    this.uuid,
    this.orderUuid,
    this.destination,
    this.hotel,
    this.segmentType,
    this.bookingNumber,
    this.type,
    this.city,
    this.state,
    this.itineraryReqId,
    this.country,
    this.pinCode,
    this.address,
    this.longitude,
    this.latitude,
    this.cancellationType,
    this.status,
    this.bookingStatus,
    this.orderPassengerDetails,
    this.customerPayment,
    this.errorDetails,
    this.travelDate,
  });

  HotelOrderItems copyWith({
    int? id,
    String? uuid,
    String? orderUuid,
    String? destination,
    String? hotel,
    String? segmentType,
    String? bookingNumber,
    String? type,
    String? city,
    String? state,
    String? itineraryReqId,
    String? country,
    String? pinCode,
    String? address,
    String? longitude,
    String? latitude,
    String? cancellationType,
    String? status,
    String? bookingStatus,
    List<OrdersPassengersDetails>? orderPassengerDetails,
    CustomerPayment? customerPayment,
    Map<String, Object>? errorDetails,
    DateTime? travelDate,
  }) {
    return HotelOrderItems(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      orderUuid: orderUuid ?? this.orderUuid,
      destination: destination ?? this.destination,
      hotel: hotel ?? this.hotel,
      segmentType: segmentType ?? this.segmentType,
      bookingNumber: bookingNumber ?? this.bookingNumber,
      type: type ?? this.type,
      city: city ?? this.city,
      state: state ?? this.state,
      itineraryReqId: itineraryReqId ?? this.itineraryReqId,
      country: country ?? this.country,
      pinCode: pinCode ?? this.pinCode,
      address: address ?? this.address,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
      cancellationType: cancellationType ?? this.cancellationType,
      status: status ?? this.status,
      bookingStatus: bookingStatus ?? this.bookingStatus,
      orderPassengerDetails:
          orderPassengerDetails ?? this.orderPassengerDetails,
      customerPayment: customerPayment ?? this.customerPayment,
      errorDetails: errorDetails ?? this.errorDetails,
      travelDate: travelDate ?? this.travelDate,
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
    if (orderUuid != null) {
      result.addAll({'orderUuid': orderUuid});
    }
    if (destination != null) {
      result.addAll({'destination': destination});
    }
    if (hotel != null) {
      result.addAll({'hotel': hotel});
    }
    if (segmentType != null) {
      result.addAll({'segmentType': segmentType});
    }
    if (bookingNumber != null) {
      result.addAll({'bookingNumber': bookingNumber});
    }
    if (type != null) {
      result.addAll({'type': type});
    }
    if (city != null) {
      result.addAll({'city': city});
    }
    if (state != null) {
      result.addAll({'state': state});
    }
    if (itineraryReqId != null) {
      result.addAll({'itineraryReqId': itineraryReqId});
    }
    if (country != null) {
      result.addAll({'country': country});
    }
    if (pinCode != null) {
      result.addAll({'pinCode': pinCode});
    }
    if (address != null) {
      result.addAll({'address': address});
    }
    if (longitude != null) {
      result.addAll({'longitude': longitude});
    }
    if (latitude != null) {
      result.addAll({'latitude': latitude});
    }
    if (cancellationType != null) {
      result.addAll({'cancellationType': cancellationType});
    }
    if (status != null) {
      result.addAll({'status': status});
    }
    if (bookingStatus != null) {
      result.addAll({'bookingStatus': bookingStatus});
    }
    if (orderPassengerDetails != null) {
      result.addAll({
        'orderPassengerDetails':
            orderPassengerDetails!.map((x) => x.toMap()).toList()
      });
    }
    if (customerPayment != null) {
      result.addAll({'customerPayment': customerPayment!.toMap()});
    }
    if (errorDetails != null) {
      result.addAll({'errorDetails': errorDetails});
    }
    if (travelDate != null) {
      result.addAll({'travelDate': travelDate!.millisecondsSinceEpoch});
    }

    return result;
  }

  factory HotelOrderItems.fromMap(Map<String, dynamic> map) {
    return HotelOrderItems(
      id: map['id']?.toInt(),
      uuid: map['uuid'],
      orderUuid: map['orderUuid'],
      destination: map['destination'],
      hotel: map['hotel'],
      segmentType: map['segmentType'],
      bookingNumber: map['bookingNumber'],
      type: map['type'],
      city: map['city'],
      state: map['state'],
      itineraryReqId: map['itineraryReqId'],
      country: map['country'],
      pinCode: map['pinCode'],
      address: map['address'],
      longitude: map['longitude'],
      latitude: map['latitude'],
      cancellationType: map['cancellationType'],
      status: map['status'],
      bookingStatus: map['bookingStatus'],
      orderPassengerDetails: map['orderPassengerDetails'] != null
          ? List<OrdersPassengersDetails>.from(map['orderPassengerDetails']
              ?.map((x) => OrdersPassengersDetails.fromMap(x)))
          : null,
      customerPayment: map['customerPayment'] != null
          ? CustomerPayment.fromMap(map['customerPayment'])
          : null,
      errorDetails: map['errorDetails'] != null
          ? Map<String, Object>.from(map['errorDetails'])
          : null,
      travelDate: map['travelDate'] != null
          ? DateTime.tryParse(map['travelDate'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory HotelOrderItems.fromJson(String source) =>
      HotelOrderItems.fromMap(json.decode(source));

  @override
  String toString() {
    return 'HotelOrderItems(id: $id, uuid: $uuid, orderUuid: $orderUuid, destination: $destination, hotel: $hotel, segmentType: $segmentType, bookingNumber: $bookingNumber, type: $type, city: $city, state: $state, itineraryReqId: $itineraryReqId, country: $country, pinCode: $pinCode, address: $address, longitude: $longitude, latitude: $latitude, cancellationType: $cancellationType, status: $status, bookingStatus: $bookingStatus, orderPassengerDetails: $orderPassengerDetails, customerPayment: $customerPayment, errorDetails: $errorDetails, travelDate: $travelDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HotelOrderItems &&
        other.id == id &&
        other.uuid == uuid &&
        other.orderUuid == orderUuid &&
        other.destination == destination &&
        other.hotel == hotel &&
        other.segmentType == segmentType &&
        other.bookingNumber == bookingNumber &&
        other.type == type &&
        other.city == city &&
        other.state == state &&
        other.itineraryReqId == itineraryReqId &&
        other.country == country &&
        other.pinCode == pinCode &&
        other.address == address &&
        other.longitude == longitude &&
        other.latitude == latitude &&
        other.cancellationType == cancellationType &&
        other.status == status &&
        other.bookingStatus == bookingStatus &&
        listEquals(other.orderPassengerDetails, orderPassengerDetails) &&
        other.customerPayment == customerPayment &&
        mapEquals(other.errorDetails, errorDetails) &&
        other.travelDate == travelDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        uuid.hashCode ^
        orderUuid.hashCode ^
        destination.hashCode ^
        hotel.hashCode ^
        segmentType.hashCode ^
        bookingNumber.hashCode ^
        type.hashCode ^
        city.hashCode ^
        state.hashCode ^
        itineraryReqId.hashCode ^
        country.hashCode ^
        pinCode.hashCode ^
        address.hashCode ^
        longitude.hashCode ^
        latitude.hashCode ^
        cancellationType.hashCode ^
        status.hashCode ^
        bookingStatus.hashCode ^
        orderPassengerDetails.hashCode ^
        customerPayment.hashCode ^
        errorDetails.hashCode ^
        travelDate.hashCode;
  }
}
