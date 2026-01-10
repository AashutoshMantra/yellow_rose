import 'dart:convert';

import 'package:flutter/foundation.dart';

class TripDetail {
  final List<String>? onBehalf;
  TripDetail({
    this.onBehalf,
  });

  TripDetail copyWith({
    List<String>? onBehalf,
  }) {
    return TripDetail(
      onBehalf: onBehalf ?? this.onBehalf,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (onBehalf != null) {
      result.addAll({'onBehalf': onBehalf});
    }

    return result;
  }

  factory TripDetail.fromMap(Map<String, dynamic> map) {
    return TripDetail(
      onBehalf: List<String>.from(map['onBehalf']),
    );
  }

  String toJson() => json.encode(toMap());

  factory TripDetail.fromJson(String source) =>
      TripDetail.fromMap(json.decode(source));

  @override
  String toString() => 'TripDetail(onBehalf: $onBehalf)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TripDetail && listEquals(other.onBehalf, onBehalf);
  }

  @override
  int get hashCode => onBehalf.hashCode;
}
