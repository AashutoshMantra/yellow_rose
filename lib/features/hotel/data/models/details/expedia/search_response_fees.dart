import 'dart:convert';

import 'package:yellow_rose/features/hotel/data/models/details/expedia/billable_and_request.dart';

class ExpediaHotelSearchResponseFees {
  final ExpediaHotelSearchRespBillableAndRequest? mandatoryFee;
  final ExpediaHotelSearchRespBillableAndRequest? resortFee;
  final ExpediaHotelSearchRespBillableAndRequest? mandatoryTax;

  const ExpediaHotelSearchResponseFees({
    this.mandatoryFee,
    this.resortFee,
    this.mandatoryTax,
  });

  factory ExpediaHotelSearchResponseFees.fromJson(String source) =>
      ExpediaHotelSearchResponseFees.fromMap(json.decode(source));

  factory ExpediaHotelSearchResponseFees.fromMap(Map<String, dynamic> map) {
    return ExpediaHotelSearchResponseFees(
      mandatoryFee: map['mandatory_fee'] != null
          ? ExpediaHotelSearchRespBillableAndRequest.fromMap(
              map['mandatory_fee'])
          : null,
      resortFee: map['resort_fee'] != null
          ? ExpediaHotelSearchRespBillableAndRequest.fromMap(map['resort_fee'])
          : null,
      mandatoryTax: map['mandatory_tax'] != null
          ? ExpediaHotelSearchRespBillableAndRequest.fromMap(
              map['mandatory_tax'])
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'mandatory_fee': mandatoryFee?.toMap(),
      'resort_fee': resortFee?.toMap(),
      'mandatory_tax': mandatoryTax?.toMap(),
    };
  }

  String toJson() => json.encode(toMap());

  ExpediaHotelSearchResponseFees copyWith({
    ExpediaHotelSearchRespBillableAndRequest? mandatoryFee,
    ExpediaHotelSearchRespBillableAndRequest? resortFee,
    ExpediaHotelSearchRespBillableAndRequest? mandatoryTax,
  }) {
    return ExpediaHotelSearchResponseFees(
      mandatoryFee: mandatoryFee ?? this.mandatoryFee,
      resortFee: resortFee ?? this.resortFee,
      mandatoryTax: mandatoryTax ?? this.mandatoryTax,
    );
  }
}
