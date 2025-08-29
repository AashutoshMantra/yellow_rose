import 'dart:convert';

import 'package:yellow_rose/features/flight/data/models/erro_code_handler.dart';

class MmtBookingResponse {
  final String? requestId;
  final int? statusCode;
  final String? status;
  final String? blockId;
  final String? bookingId;
  final String? checkoutId;
  final String? currency;
  final String? payId;
  final String? paymentRespMessage;
  final String? totalAmount;
  final ErrorCodeHandler? error;
  MmtBookingResponse({
    this.requestId,
    this.statusCode,
    this.status,
    this.blockId,
    this.bookingId,
    this.checkoutId,
    this.currency,
    this.payId,
    this.paymentRespMessage,
    this.totalAmount,
    this.error,
  });

  MmtBookingResponse copyWith({
    String? requestId,
    int? statusCode,
    String? status,
    String? blockId,
    String? bookingId,
    String? checkoutId,
    String? currency,
    String? payId,
    String? paymentRespMessage,
    String? totalAmount,
    ErrorCodeHandler? error,
  }) {
    return MmtBookingResponse(
      requestId: requestId ?? this.requestId,
      statusCode: statusCode ?? this.statusCode,
      status: status ?? this.status,
      blockId: blockId ?? this.blockId,
      bookingId: bookingId ?? this.bookingId,
      checkoutId: checkoutId ?? this.checkoutId,
      currency: currency ?? this.currency,
      payId: payId ?? this.payId,
      paymentRespMessage: paymentRespMessage ?? this.paymentRespMessage,
      totalAmount: totalAmount ?? this.totalAmount,
      error: error ?? this.error,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (requestId != null) {
      result.addAll({'requestId': requestId});
    }
    if (statusCode != null) {
      result.addAll({'statusCode': statusCode});
    }
    if (status != null) {
      result.addAll({'status': status});
    }
    if (blockId != null) {
      result.addAll({'blockId': blockId});
    }
    if (bookingId != null) {
      result.addAll({'bookingId': bookingId});
    }
    if (checkoutId != null) {
      result.addAll({'checkoutId': checkoutId});
    }
    if (currency != null) {
      result.addAll({'currency': currency});
    }
    if (payId != null) {
      result.addAll({'payId': payId});
    }
    if (paymentRespMessage != null) {
      result.addAll({'paymentRespMessage': paymentRespMessage});
    }
    if (totalAmount != null) {
      result.addAll({'totalAmount': totalAmount});
    }
    if (error != null) {
      result.addAll({'error': error!.toMap()});
    }

    return result;
  }

  factory MmtBookingResponse.fromMap(Map<String, dynamic> map) {
    return MmtBookingResponse(
      requestId: map['requestId'],
      statusCode: map['statusCode']?.toInt(),
      status: map['status'],
      blockId: map['blockId'],
      bookingId: map['bookingId'],
      checkoutId: map['checkoutId'],
      currency: map['currency'],
      payId: map['payId'],
      paymentRespMessage: map['paymentRespMessage'],
      totalAmount: map['totalAmount'],
      error:
          map['error'] != null ? ErrorCodeHandler.fromMap(map['error']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory MmtBookingResponse.fromJson(String source) =>
      MmtBookingResponse.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MmtBookingResponse(requestId: $requestId, statusCode: $statusCode, status: $status, blockId: $blockId, bookingId: $bookingId, checkoutId: $checkoutId, currency: $currency, payId: $payId, paymentRespMessage: $paymentRespMessage, totalAmount: $totalAmount, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MmtBookingResponse &&
        other.requestId == requestId &&
        other.statusCode == statusCode &&
        other.status == status &&
        other.blockId == blockId &&
        other.bookingId == bookingId &&
        other.checkoutId == checkoutId &&
        other.currency == currency &&
        other.payId == payId &&
        other.paymentRespMessage == paymentRespMessage &&
        other.totalAmount == totalAmount &&
        other.error == error;
  }

  @override
  int get hashCode {
    return requestId.hashCode ^
        statusCode.hashCode ^
        status.hashCode ^
        blockId.hashCode ^
        bookingId.hashCode ^
        checkoutId.hashCode ^
        currency.hashCode ^
        payId.hashCode ^
        paymentRespMessage.hashCode ^
        totalAmount.hashCode ^
        error.hashCode;
  }
}
