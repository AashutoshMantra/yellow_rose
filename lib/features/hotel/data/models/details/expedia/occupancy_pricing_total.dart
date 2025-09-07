import 'dart:convert';

import 'package:yellow_rose/features/hotel/data/models/details/expedia/billable_and_request.dart';

import 'dart:convert';

class ExpediaHotelDetailUIRespPricingTotals {
  final ExpediaHotelSearchRespBillableAndRequest? inclusive;
  final ExpediaHotelSearchRespBillableAndRequest? exclusive;
  final ExpediaHotelSearchRespBillableAndRequest? propertyInclusive;
  final ExpediaHotelSearchRespBillableAndRequest? strikethrough;
  final ExpediaHotelSearchRespBillableAndRequest?
      propertyInclusiveStrikethrough;
  final ExpediaHotelSearchRespBillableAndRequest? marketingFee;
  final ExpediaHotelSearchRespBillableAndRequest? grossProfit;
  final ExpediaHotelSearchRespBillableAndRequest? minimumSellingPrice;
  final ExpediaHotelSearchRespBillableAndRequest? propertyFees;
  final double? requestedCurrencyTotalPrice; // <-- newly added field

  const ExpediaHotelDetailUIRespPricingTotals({
    this.inclusive,
    this.exclusive,
    this.propertyInclusive,
    this.strikethrough,
    this.propertyInclusiveStrikethrough,
    this.marketingFee,
    this.grossProfit,
    this.minimumSellingPrice,
    this.propertyFees,
    this.requestedCurrencyTotalPrice,
  });

  factory ExpediaHotelDetailUIRespPricingTotals.fromJson(String source) =>
      ExpediaHotelDetailUIRespPricingTotals.fromMap(json.decode(source));

  factory ExpediaHotelDetailUIRespPricingTotals.fromMap(
      Map<String, dynamic> map) {
    return ExpediaHotelDetailUIRespPricingTotals(
      inclusive: map['inclusive'] != null
          ? ExpediaHotelSearchRespBillableAndRequest.fromMap(map['inclusive'])
          : null,
      exclusive: map['exclusive'] != null
          ? ExpediaHotelSearchRespBillableAndRequest.fromMap(map['exclusive'])
          : null,
      propertyInclusive: map['property_inclusive'] != null
          ? ExpediaHotelSearchRespBillableAndRequest.fromMap(
              map['property_inclusive'])
          : null,
      strikethrough: map['strikethrough'] != null
          ? ExpediaHotelSearchRespBillableAndRequest.fromMap(
              map['strikethrough'])
          : null,
      propertyInclusiveStrikethrough:
          map['property_inclusive_strikethrough'] != null
              ? ExpediaHotelSearchRespBillableAndRequest.fromMap(
                  map['property_inclusive_strikethrough'])
              : null,
      marketingFee: map['marketing_fee'] != null
          ? ExpediaHotelSearchRespBillableAndRequest.fromMap(
              map['marketing_fee'])
          : null,
      grossProfit: map['gross_profit'] != null
          ? ExpediaHotelSearchRespBillableAndRequest.fromMap(
              map['gross_profit'])
          : null,
      minimumSellingPrice: map['minimum_selling_price'] != null
          ? ExpediaHotelSearchRespBillableAndRequest.fromMap(
              map['minimum_selling_price'])
          : null,
      propertyFees: map['property_fees'] != null
          ? ExpediaHotelSearchRespBillableAndRequest.fromMap(
              map['property_fees'])
          : null,
      requestedCurrencyTotalPrice:
          map['requestedCurrencyTotalPrice']?.toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'inclusive': inclusive?.toMap(),
      'exclusive': exclusive?.toMap(),
      'property_inclusive': propertyInclusive?.toMap(),
      'strikethrough': strikethrough?.toMap(),
      'property_inclusive_strikethrough':
          propertyInclusiveStrikethrough?.toMap(),
      'marketing_fee': marketingFee?.toMap(),
      'gross_profit': grossProfit?.toMap(),
      'minimum_selling_price': minimumSellingPrice?.toMap(),
      'property_fees': propertyFees?.toMap(),
      'requested_currency_total_price': requestedCurrencyTotalPrice,
    };
  }

  String toJson() => json.encode(toMap());

  ExpediaHotelDetailUIRespPricingTotals copyWith({
    ExpediaHotelSearchRespBillableAndRequest? inclusive,
    ExpediaHotelSearchRespBillableAndRequest? exclusive,
    ExpediaHotelSearchRespBillableAndRequest? propertyInclusive,
    ExpediaHotelSearchRespBillableAndRequest? strikethrough,
    ExpediaHotelSearchRespBillableAndRequest? propertyInclusiveStrikethrough,
    ExpediaHotelSearchRespBillableAndRequest? marketingFee,
    ExpediaHotelSearchRespBillableAndRequest? grossProfit,
    ExpediaHotelSearchRespBillableAndRequest? minimumSellingPrice,
    ExpediaHotelSearchRespBillableAndRequest? propertyFees,
    double? requestedCurrencyTotalPrice,
  }) {
    return ExpediaHotelDetailUIRespPricingTotals(
      inclusive: inclusive ?? this.inclusive,
      exclusive: exclusive ?? this.exclusive,
      propertyInclusive: propertyInclusive ?? this.propertyInclusive,
      strikethrough: strikethrough ?? this.strikethrough,
      propertyInclusiveStrikethrough:
          propertyInclusiveStrikethrough ?? this.propertyInclusiveStrikethrough,
      marketingFee: marketingFee ?? this.marketingFee,
      grossProfit: grossProfit ?? this.grossProfit,
      minimumSellingPrice: minimumSellingPrice ?? this.minimumSellingPrice,
      propertyFees: propertyFees ?? this.propertyFees,
      requestedCurrencyTotalPrice:
          requestedCurrencyTotalPrice ?? this.requestedCurrencyTotalPrice,
    );
  }
}
