import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:yellow_rose/features/bus/data/models/bus_error_responsed.dart';
import 'package:yellow_rose/features/bus/data/models/bus_order_passenger_detail.dart';
import 'package:yellow_rose/features/bus/data/models/order/block_bus_ticket.dart';
import 'package:yellow_rose/features/bus/data/models/order/bus_payment_req_res.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order/customer_payment.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order/update_order_detail_response.dart';

class BusOrderResponse {
  final String? orderNumber;
  final BusPaymentMediumRequestRes? paymentConfig;
  final CustomerPayment? priceData;
  final List<BookingPassThroughData>? passThroughInfo;
  final bool? isHoldAllowed = false;
  final bool? fopUpdatedSuccess = false;
  final BusBlockTicketRequest? blockTicketRequest;
  final List<BusOrderPassengerDetails>? passengerDetails;
  final BusErrorResponse? error;
  BusOrderResponse({
    this.orderNumber,
    this.paymentConfig,
    this.priceData,
    this.passThroughInfo,
    this.blockTicketRequest,
    this.passengerDetails,
    this.error,
  });

  BusOrderResponse copyWith({
    String? orderNumber,
    BusPaymentMediumRequestRes? paymentConfig,
    CustomerPayment? priceData,
    List<BookingPassThroughData>? passThroughInfo,
    BusBlockTicketRequest? blockTicketRequest,
    List<BusOrderPassengerDetails>? passengerDetails,
    BusErrorResponse? error,
  }) {
    return BusOrderResponse(
      orderNumber: orderNumber ?? this.orderNumber,
      paymentConfig: paymentConfig ?? this.paymentConfig,
      priceData: priceData ?? this.priceData,
      passThroughInfo: passThroughInfo ?? this.passThroughInfo,
      blockTicketRequest: blockTicketRequest ?? this.blockTicketRequest,
      passengerDetails: passengerDetails ?? this.passengerDetails,
      error: error ?? this.error,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (orderNumber != null) {
      result.addAll({'orderNumber': orderNumber});
    }
    if (paymentConfig != null) {
      result.addAll({'paymentConfig': paymentConfig!.toMap()});
    }
    if (priceData != null) {
      result.addAll({'priceData': priceData!.toMap()});
    }
    if (passThroughInfo != null) {
      result.addAll(
          {'passThroughInfo': passThroughInfo!.map((x) => x.toMap()).toList()});
    }
    if (blockTicketRequest != null) {
      result.addAll({'blockTicketRequest': blockTicketRequest!.toMap()});
    }
    if (passengerDetails != null) {
      result.addAll({
        'passengerDetails': passengerDetails!.map((x) => x.toMap()).toList()
      });
    }
    if (error != null) {
      result.addAll({'error': error!.toMap()});
    }

    return result;
  }

  factory BusOrderResponse.fromMap(Map<String, dynamic> map) {
    return BusOrderResponse(
      orderNumber: map['orderNumber'],
      paymentConfig: map['paymentConfig'] != null
          ? BusPaymentMediumRequestRes.fromMap(map['paymentConfig'])
          : null,
      priceData: map['priceData'] != null
          ? CustomerPayment.fromMap(map['priceData'])
          : null,
      passThroughInfo: map['passThroughInfo'] != null
          ? List<BookingPassThroughData>.from(map['passThroughInfo']
              ?.map((x) => BookingPassThroughData.fromMap(x)))
          : null,
      blockTicketRequest: map['blockTicketRequest'] != null
          ? BusBlockTicketRequest.fromMap(map['blockTicketRequest'])
          : null,
      passengerDetails: map['passengerDetails'] != null
          ? List<BusOrderPassengerDetails>.from(map['passengerDetails']
              ?.map((x) => BusOrderPassengerDetails.fromMap(x)))
          : null,
      error:
          map['error'] != null ? BusErrorResponse.fromMap(map['error']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BusOrderResponse.fromJson(String source) =>
      BusOrderResponse.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BusOrderResponse(orderNumber: $orderNumber, paymentConfig: $paymentConfig, priceData: $priceData, passThroughInfo: $passThroughInfo, blockTicketRequest: $blockTicketRequest, passengerDetails: $passengerDetails, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BusOrderResponse &&
        other.orderNumber == orderNumber &&
        other.paymentConfig == paymentConfig &&
        other.priceData == priceData &&
        listEquals(other.passThroughInfo, passThroughInfo) &&
        other.blockTicketRequest == blockTicketRequest &&
        listEquals(other.passengerDetails, passengerDetails) &&
        other.error == error;
  }

  @override
  int get hashCode {
    return orderNumber.hashCode ^
        paymentConfig.hashCode ^
        priceData.hashCode ^
        passThroughInfo.hashCode ^
        blockTicketRequest.hashCode ^
        passengerDetails.hashCode ^
        error.hashCode;
  }
}
