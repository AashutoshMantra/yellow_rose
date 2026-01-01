import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:yellow_rose/features/auth/data/models/policy/approver_key_value.dart';

class Approvers {
  final String? order;
  final List<ApproverKeyValue>? keyValue;
  Approvers({
    this.order,
    this.keyValue,
  });

  Approvers copyWith({
    String? order,
    List<ApproverKeyValue>? keyValue,
  }) {
    return Approvers(
      order: order ?? this.order,
      keyValue: keyValue ?? this.keyValue,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (order != null) {
      result.addAll({'order': order});
    }
    if (keyValue != null) {
      result.addAll({'keyValue': keyValue!.map((x) => x.toMap()).toList()});
    }

    return result;
  }

  factory Approvers.fromMap(Map<String, dynamic> map) {
    return Approvers(
      order: map['order'],
      keyValue: map['keyValue'] != null
          ? List<ApproverKeyValue>.from(
              map['keyValue']?.map((x) => ApproverKeyValue.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Approvers.fromJson(String source) =>
      Approvers.fromMap(json.decode(source));

  @override
  String toString() => 'Approvers(order: $order, keyValue: $keyValue)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Approvers &&
        other.order == order &&
        listEquals(other.keyValue, keyValue);
  }

  @override
  int get hashCode => order.hashCode ^ keyValue.hashCode;
}
