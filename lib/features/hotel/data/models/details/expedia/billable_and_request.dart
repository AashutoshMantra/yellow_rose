import 'dart:convert';

import 'package:yellow_rose/features/hotel/data/models/details/expedia/response_value_currency.dart';

class ExpediaHotelSearchRespBillableAndRequest {
  final ExpediaHotelSearchRespValueCurrency? billableCurrency;
  final ExpediaHotelSearchRespValueCurrency? requestCurrency;

  const ExpediaHotelSearchRespBillableAndRequest({
    this.billableCurrency,
    this.requestCurrency,
  });

  factory ExpediaHotelSearchRespBillableAndRequest.fromJson(String source) =>
      ExpediaHotelSearchRespBillableAndRequest.fromMap(json.decode(source));

  factory ExpediaHotelSearchRespBillableAndRequest.fromMap(
      Map<String, dynamic> map) {
    return ExpediaHotelSearchRespBillableAndRequest(
      billableCurrency: map['billable_currency'] != null
          ? ExpediaHotelSearchRespValueCurrency.fromMap(
              map['billable_currency'])
          : null,
      requestCurrency: map['request_currency'] != null
          ? ExpediaHotelSearchRespValueCurrency.fromMap(map['request_currency'])
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'billable_currency': billableCurrency?.toMap(),
      'request_currency': requestCurrency?.toMap(),
    };
  }

  String toJson() => json.encode(toMap());

  ExpediaHotelSearchRespBillableAndRequest copyWith({
    ExpediaHotelSearchRespValueCurrency? billableCurrency,
    ExpediaHotelSearchRespValueCurrency? requestCurrency,
  }) {
    return ExpediaHotelSearchRespBillableAndRequest(
      billableCurrency: billableCurrency ?? this.billableCurrency,
      requestCurrency: requestCurrency ?? this.requestCurrency,
    );
  }
}
