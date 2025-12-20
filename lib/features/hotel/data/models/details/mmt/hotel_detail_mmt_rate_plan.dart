import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:yellow_rose/features/hotel/data/models/details/hotel_detail_commercial.dart';
import 'package:yellow_rose/features/hotel/data/models/details/mmt/mmt_hotel_cancellation_policy.dart';
import 'package:yellow_rose/features/hotel/data/models/details/mmt/mmt_hotel_res_price.dart';
import 'package:yellow_rose/features/hotel/data/models/details/mmt/mmt_hotel_room_tarrif.dart';
import 'package:yellow_rose/features/hotel/data/models/details/mmt/mmt_hotel_search_res_inclusion.dart';
import 'package:yellow_rose/features/hotel/data/models/details/mmt/mmt_hotel_search_res_meal_plan.dart';

class HotelDetailMMTRatePlan {
  final HotelDetailCommercial? commercial;

  final String? code;
  final String? description;
  final String? rateType;
  final String? rateCheckId;
  final List<MMTHotelSearchResMealPlan>? mealPlans;
  final List<MMTHotelSearchResInclusion>? inclusions;
  final String? paymentMode;
  final MMTHotelSearchResCancellationPolicy? cancellationPolicy;
  final List<MMTHotelSearchResRoomTariff>? roomTariff;
  final MMTHotelSearchResPrice? price;
  final List<int>? freeChildAges;
  final String? vendorCode;
  final double? totalAmount;

  HotelDetailMMTRatePlan({
    this.commercial,
    this.code,
    this.description,
    this.rateType,
    this.rateCheckId,
    this.mealPlans,
    this.inclusions,
    this.paymentMode,
    this.cancellationPolicy,
    this.roomTariff,
    this.price,
    this.freeChildAges,
    this.vendorCode,
    this.totalAmount,
  });

  HotelDetailMMTRatePlan copyWith({
    HotelDetailCommercial? commercial,
    String? code,
    String? description,
    String? rateType,
    String? rateCheckId,
    List<MMTHotelSearchResMealPlan>? mealPlans,
    List<MMTHotelSearchResInclusion>? inclusions,
    String? paymentMode,
    MMTHotelSearchResCancellationPolicy? cancellationPolicy,
    List<MMTHotelSearchResRoomTariff>? roomTariff,
    MMTHotelSearchResPrice? price,
    List<int>? freeChildAges,
    String? vendorCode,
    double? totalAmount,
  }) {
    return HotelDetailMMTRatePlan(
      commercial: commercial ?? this.commercial,
      code: code ?? this.code,
      description: description ?? this.description,
      rateType: rateType ?? this.rateType,
      rateCheckId: rateCheckId ?? this.rateCheckId,
      mealPlans: mealPlans ?? this.mealPlans,
      inclusions: inclusions ?? this.inclusions,
      paymentMode: paymentMode ?? this.paymentMode,
      cancellationPolicy: cancellationPolicy ?? this.cancellationPolicy,
      roomTariff: roomTariff ?? this.roomTariff,
      price: price ?? this.price,
      freeChildAges: freeChildAges ?? this.freeChildAges,
      vendorCode: vendorCode ?? this.vendorCode,
      totalAmount: totalAmount ?? this.totalAmount,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (commercial != null) {
      result.addAll({'commercial': commercial!.toMap()});
    }
    if (code != null) {
      result.addAll({'code': code});
    }
    if (description != null) {
      result.addAll({'description': description});
    }
    if (rateType != null) {
      result.addAll({'rateType': rateType});
    }
    if (rateCheckId != null) {
      result.addAll({'rateCheckId': rateCheckId});
    }
    if (mealPlans != null) {
      result.addAll({'mealPlans': mealPlans!.map((x) => x.toMap()).toList()});
    }
    if (inclusions != null) {
      result.addAll({'inclusions': inclusions!.map((x) => x.toMap()).toList()});
    }
    if (paymentMode != null) {
      result.addAll({'paymentMode': paymentMode});
    }
    if (cancellationPolicy != null) {
      result.addAll({'cancellationPolicy': cancellationPolicy!.toMap()});
    }
    if (roomTariff != null) {
      result.addAll({'roomTariff': roomTariff!.map((x) => x.toMap()).toList()});
    }
    if (price != null) {
      result.addAll({'price': price!.toMap()});
    }
    if (freeChildAges != null) {
      result.addAll({'freeChildAges': freeChildAges});
    }
    if (vendorCode != null) {
      result.addAll({'vendorCode': vendorCode});
    }
    if (totalAmount != null) {
      result.addAll({'totalAmount': totalAmount});
    }

    return result;
  }

  factory HotelDetailMMTRatePlan.fromMap(Map<String, dynamic> map) {
    return HotelDetailMMTRatePlan(
      commercial: map['commercial'] != null
          ? HotelDetailCommercial.fromMap(map['commercial'])
          : null,
      code: map['code'],
      description: map['description'],
      rateType: map['rateType'],
      rateCheckId: map['rateCheckId'],
      mealPlans: map['mealPlans'] != null
          ? List<MMTHotelSearchResMealPlan>.from(map['mealPlans']
              ?.map((x) => MMTHotelSearchResMealPlan.fromMap(x)))
          : null,
      inclusions: map['inclusions'] != null
          ? List<MMTHotelSearchResInclusion>.from(map['inclusions']
              ?.where((x) => x != null && x != "" && x is Map<String, dynamic>)
              ?.map((x) => MMTHotelSearchResInclusion.fromMap(x)))
          : null,
      paymentMode: map['paymentMode'],
      cancellationPolicy: map['cancellationPolicy'] != null
          ? MMTHotelSearchResCancellationPolicy.fromMap(
              map['cancellationPolicy'])
          : null,
      roomTariff: map['roomTariff'] != null
          ? List<MMTHotelSearchResRoomTariff>.from(map['roomTariff']
              ?.map((x) => MMTHotelSearchResRoomTariff.fromMap(x)))
          : null,
      price: map['price'] != null
          ? MMTHotelSearchResPrice.fromMap(map['price'])
          : null,
      freeChildAges: List<int>.from(map['freeChildAges']),
      vendorCode: map['vendorCode'],
      totalAmount: map['totalAmount']?.toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory HotelDetailMMTRatePlan.fromJson(String source) =>
      HotelDetailMMTRatePlan.fromMap(json.decode(source));

  @override
  String toString() {
    return 'HotelDetailMMTRatePlan(commercial: $commercial, code: $code, description: $description, rateType: $rateType, rateCheckId: $rateCheckId, mealPlans: $mealPlans, inclusions: $inclusions, paymentMode: $paymentMode, cancellationPolicy: $cancellationPolicy, roomTariff: $roomTariff, price: $price, freeChildAges: $freeChildAges, vendorCode: $vendorCode, totalAmount: $totalAmount)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HotelDetailMMTRatePlan &&
        other.commercial == commercial &&
        other.code == code &&
        other.description == description &&
        other.rateType == rateType &&
        other.rateCheckId == rateCheckId &&
        listEquals(other.mealPlans, mealPlans) &&
        listEquals(other.inclusions, inclusions) &&
        other.paymentMode == paymentMode &&
        other.cancellationPolicy == cancellationPolicy &&
        listEquals(other.roomTariff, roomTariff) &&
        other.price == price &&
        listEquals(other.freeChildAges, freeChildAges) &&
        other.vendorCode == vendorCode &&
        other.totalAmount == totalAmount;
  }

  @override
  int get hashCode {
    return commercial.hashCode ^
        code.hashCode ^
        description.hashCode ^
        rateType.hashCode ^
        rateCheckId.hashCode ^
        mealPlans.hashCode ^
        inclusions.hashCode ^
        paymentMode.hashCode ^
        cancellationPolicy.hashCode ^
        roomTariff.hashCode ^
        price.hashCode ^
        freeChildAges.hashCode ^
        vendorCode.hashCode ^
        totalAmount.hashCode;
  }
}
