import 'dart:convert';

import 'package:flutter/foundation.dart';

class BusUpdatedFareBreakup {
  final int? seatName;
  final List<Map<String, dynamic>>? customerPriceBreakUp;
  BusUpdatedFareBreakup({
    this.seatName,
    this.customerPriceBreakUp,
  });

  BusUpdatedFareBreakup copyWith({
    int? seatName,
    List<Map<String, dynamic>>? customerPriceBreakUp,
  }) {
    return BusUpdatedFareBreakup(
      seatName: seatName ?? this.seatName,
      customerPriceBreakUp: customerPriceBreakUp ?? this.customerPriceBreakUp,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (seatName != null) {
      result.addAll({'seatName': seatName});
    }
    if (customerPriceBreakUp != null) {
      result.addAll({'customerPriceBreakUp': customerPriceBreakUp});
    }

    return result;
  }

  factory BusUpdatedFareBreakup.fromMap(Map<String, dynamic> map) {
    return BusUpdatedFareBreakup(
      seatName: map['seatName']?.toInt(),
      customerPriceBreakUp: map['customerPriceBreakUp'] != null
          ? List<Map<String, dynamic>>.from(map['customerPriceBreakUp']
              ?.map((x) => x as Map<String, dynamic>))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BusUpdatedFareBreakup.fromJson(String source) =>
      BusUpdatedFareBreakup.fromMap(json.decode(source));

  @override
  String toString() =>
      'BusUpdatedFareBreakup(seatName: $seatName, customerPriceBreakUp: $customerPriceBreakUp)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BusUpdatedFareBreakup &&
        other.seatName == seatName &&
        listEquals(other.customerPriceBreakUp, customerPriceBreakUp);
  }

  @override
  int get hashCode => seatName.hashCode ^ customerPriceBreakUp.hashCode;
}
