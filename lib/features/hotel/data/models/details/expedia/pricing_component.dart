import 'dart:convert';

import 'package:yellow_rose/features/hotel/data/models/details/expedia/response_value_currency.dart';

class ExpediaPricingComponents {
  final ExpediaHotelSearchRespValueCurrency? basePrice;
  final ExpediaHotelSearchRespValueCurrency? actualBasePrice;
  final ExpediaHotelSearchRespValueCurrency? taxAndServiceFee;
  final ExpediaHotelSearchRespValueCurrency? extraPersonFee;
  final ExpediaHotelSearchRespValueCurrency? propertyFee;
  final ExpediaHotelSearchRespValueCurrency? salesTax;
  final ExpediaHotelSearchRespValueCurrency? adjustment;
  final ExpediaHotelSearchRespValueCurrency? recoveryChargesAndFees;
  final ExpediaHotelSearchRespValueCurrency? travelerServiceFee;
  ExpediaPricingComponents({
    this.basePrice,
    this.actualBasePrice,
    this.taxAndServiceFee,
    this.extraPersonFee,
    this.propertyFee,
    this.salesTax,
    this.adjustment,
    this.recoveryChargesAndFees,
    this.travelerServiceFee,
  });

  ExpediaPricingComponents copyWith({
    ExpediaHotelSearchRespValueCurrency? basePrice,
    ExpediaHotelSearchRespValueCurrency? actualBasePrice,
    ExpediaHotelSearchRespValueCurrency? taxAndServiceFee,
    ExpediaHotelSearchRespValueCurrency? extraPersonFee,
    ExpediaHotelSearchRespValueCurrency? propertyFee,
    ExpediaHotelSearchRespValueCurrency? salesTax,
    ExpediaHotelSearchRespValueCurrency? adjustment,
    ExpediaHotelSearchRespValueCurrency? recoveryChargesAndFees,
    ExpediaHotelSearchRespValueCurrency? travelerServiceFee,
  }) {
    return ExpediaPricingComponents(
      basePrice: basePrice ?? this.basePrice,
      actualBasePrice: actualBasePrice ?? this.actualBasePrice,
      taxAndServiceFee: taxAndServiceFee ?? this.taxAndServiceFee,
      extraPersonFee: extraPersonFee ?? this.extraPersonFee,
      propertyFee: propertyFee ?? this.propertyFee,
      salesTax: salesTax ?? this.salesTax,
      adjustment: adjustment ?? this.adjustment,
      recoveryChargesAndFees:
          recoveryChargesAndFees ?? this.recoveryChargesAndFees,
      travelerServiceFee: travelerServiceFee ?? this.travelerServiceFee,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (basePrice != null) {
      result.addAll({'basePrice': basePrice!.toMap()});
    }
    if (actualBasePrice != null) {
      result.addAll({'actualBasePrice': actualBasePrice!.toMap()});
    }
    if (taxAndServiceFee != null) {
      result.addAll({'taxAndServiceFee': taxAndServiceFee!.toMap()});
    }
    if (extraPersonFee != null) {
      result.addAll({'extraPersonFee': extraPersonFee!.toMap()});
    }
    if (propertyFee != null) {
      result.addAll({'propertyFee': propertyFee!.toMap()});
    }
    if (salesTax != null) {
      result.addAll({'salesTax': salesTax!.toMap()});
    }
    if (adjustment != null) {
      result.addAll({'adjustment': adjustment!.toMap()});
    }
    if (recoveryChargesAndFees != null) {
      result
          .addAll({'recoveryChargesAndFees': recoveryChargesAndFees!.toMap()});
    }
    if (travelerServiceFee != null) {
      result.addAll({'travelerServiceFee': travelerServiceFee!.toMap()});
    }

    return result;
  }

  factory ExpediaPricingComponents.fromMap(Map<String, dynamic> map) {
    return ExpediaPricingComponents(
      basePrice: map['basePrice'] != null
          ? ExpediaHotelSearchRespValueCurrency.fromMap(map['basePrice'])
          : null,
      actualBasePrice: map['actualBasePrice'] != null
          ? ExpediaHotelSearchRespValueCurrency.fromMap(map['actualBasePrice'])
          : null,
      taxAndServiceFee: map['taxAndServiceFee'] != null
          ? ExpediaHotelSearchRespValueCurrency.fromMap(map['taxAndServiceFee'])
          : null,
      extraPersonFee: map['extraPersonFee'] != null
          ? ExpediaHotelSearchRespValueCurrency.fromMap(map['extraPersonFee'])
          : null,
      propertyFee: map['propertyFee'] != null
          ? ExpediaHotelSearchRespValueCurrency.fromMap(map['propertyFee'])
          : null,
      salesTax: map['salesTax'] != null
          ? ExpediaHotelSearchRespValueCurrency.fromMap(map['salesTax'])
          : null,
      adjustment: map['adjustment'] != null
          ? ExpediaHotelSearchRespValueCurrency.fromMap(map['adjustment'])
          : null,
      recoveryChargesAndFees: map['recoveryChargesAndFees'] != null
          ? ExpediaHotelSearchRespValueCurrency.fromMap(
              map['recoveryChargesAndFees'])
          : null,
      travelerServiceFee: map['travelerServiceFee'] != null
          ? ExpediaHotelSearchRespValueCurrency.fromMap(
              map['travelerServiceFee'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ExpediaPricingComponents.fromJson(String source) =>
      ExpediaPricingComponents.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ExpediaPricingComponents(basePrice: $basePrice, actualBasePrice: $actualBasePrice, taxAndServiceFee: $taxAndServiceFee, extraPersonFee: $extraPersonFee, propertyFee: $propertyFee, salesTax: $salesTax, adjustment: $adjustment, recoveryChargesAndFees: $recoveryChargesAndFees, travelerServiceFee: $travelerServiceFee)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ExpediaPricingComponents &&
        other.basePrice == basePrice &&
        other.actualBasePrice == actualBasePrice &&
        other.taxAndServiceFee == taxAndServiceFee &&
        other.extraPersonFee == extraPersonFee &&
        other.propertyFee == propertyFee &&
        other.salesTax == salesTax &&
        other.adjustment == adjustment &&
        other.recoveryChargesAndFees == recoveryChargesAndFees &&
        other.travelerServiceFee == travelerServiceFee;
  }

  @override
  int get hashCode {
    return basePrice.hashCode ^
        actualBasePrice.hashCode ^
        taxAndServiceFee.hashCode ^
        extraPersonFee.hashCode ^
        propertyFee.hashCode ^
        salesTax.hashCode ^
        adjustment.hashCode ^
        recoveryChargesAndFees.hashCode ^
        travelerServiceFee.hashCode;
  }
}
