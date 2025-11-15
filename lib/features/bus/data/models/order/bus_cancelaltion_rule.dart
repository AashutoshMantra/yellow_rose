import 'dart:convert';

import 'package:yellow_rose/features/bus/data/models/order/bus_cancelaltion_charge.dart';

class BusCancelaltionRule {
  final BusCancelaltionCharge? adult;
  BusCancelaltionRule({
    this.adult,
  });

  BusCancelaltionRule copyWith({
    BusCancelaltionCharge? adult,
  }) {
    return BusCancelaltionRule(
      adult: adult ?? this.adult,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (adult != null) {
      result.addAll({'adult': adult!.toMap()});
    }

    return result;
  }

  factory BusCancelaltionRule.fromMap(Map<String, dynamic> map) {
    return BusCancelaltionRule(
      adult: map['adult'] != null
          ? BusCancelaltionCharge.fromMap(map['adult'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BusCancelaltionRule.fromJson(String source) =>
      BusCancelaltionRule.fromMap(json.decode(source));

  @override
  String toString() => 'BusCancelaltionRule(adult: $adult)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BusCancelaltionRule && other.adult == adult;
  }

  @override
  int get hashCode => adult.hashCode;
}
