import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:yellow_rose/features/flight/data/models/booking/order/segment.dart';

class SeatMealSegment {
    final List<Segment>? seatMeal;
    final double amount;
    final double seatAmount;
    final double mealAmount;
    final double baggageSsrAmount;
    final double specialSsrAmount;
  SeatMealSegment({
    this.seatMeal,
    required this.amount,
    required this.seatAmount,
    required this.mealAmount,
    required this.baggageSsrAmount,
    required this.specialSsrAmount,
  });

  SeatMealSegment copyWith({
    List<Segment>? seatMeal,
    double? amount,
    double? seatAmount,
    double? mealAmount,
    double? baggageSsrAmount,
    double? specialSsrAmount,
  }) {
    return SeatMealSegment(
      seatMeal: seatMeal ?? this.seatMeal,
      amount: amount ?? this.amount,
      seatAmount: seatAmount ?? this.seatAmount,
      mealAmount: mealAmount ?? this.mealAmount,
      baggageSsrAmount: baggageSsrAmount ?? this.baggageSsrAmount,
      specialSsrAmount: specialSsrAmount ?? this.specialSsrAmount,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(seatMeal != null){
      result.addAll({'seatMeal': seatMeal!.map((x) => x?.toMap()).toList()});
    }
    result.addAll({'amount': amount});
    result.addAll({'seatAmount': seatAmount});
    result.addAll({'mealAmount': mealAmount});
    result.addAll({'baggageSsrAmount': baggageSsrAmount});
    result.addAll({'specialSsrAmount': specialSsrAmount});
  
    return result;
  }

  factory SeatMealSegment.fromMap(Map<String, dynamic> map) {
    return SeatMealSegment(
      seatMeal: map['seatMeal'] != null ? List<Segment>.from(map['seatMeal']?.map((x) => Segment.fromMap(x))) : null,
      amount: map['amount']?.toDouble() ?? 0.0,
      seatAmount: map['seatAmount']?.toDouble() ?? 0.0,
      mealAmount: map['mealAmount']?.toDouble() ?? 0.0,
      baggageSsrAmount: map['baggageSsrAmount']?.toDouble() ?? 0.0,
      specialSsrAmount: map['specialSsrAmount']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory SeatMealSegment.fromJson(String source) => SeatMealSegment.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SeatMealSegment(seatMeal: $seatMeal, amount: $amount, seatAmount: $seatAmount, mealAmount: $mealAmount, baggageSsrAmount: $baggageSsrAmount, specialSsrAmount: $specialSsrAmount)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is SeatMealSegment &&
      listEquals(other.seatMeal, seatMeal) &&
      other.amount == amount &&
      other.seatAmount == seatAmount &&
      other.mealAmount == mealAmount &&
      other.baggageSsrAmount == baggageSsrAmount &&
      other.specialSsrAmount == specialSsrAmount;
  }

  @override
  int get hashCode {
    return seatMeal.hashCode ^
      amount.hashCode ^
      seatAmount.hashCode ^
      mealAmount.hashCode ^
      baggageSsrAmount.hashCode ^
      specialSsrAmount.hashCode;
  }
}
