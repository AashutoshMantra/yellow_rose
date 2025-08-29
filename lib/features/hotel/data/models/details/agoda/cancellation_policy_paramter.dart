import 'dart:convert';

import 'package:flutter/foundation.dart';

class AgodaHotelSearchResCancellationPolicyParameter {
  final int? days;
  final String? charge;
  final int? value;
  final Map<String, Object>? additionalProperties;
  AgodaHotelSearchResCancellationPolicyParameter({
    this.days,
    this.charge,
    this.value,
    this.additionalProperties,
  });

  AgodaHotelSearchResCancellationPolicyParameter copyWith({
    int? days,
    String? charge,
    int? value,
    Map<String, Object>? additionalProperties,
  }) {
    return AgodaHotelSearchResCancellationPolicyParameter(
      days: days ?? this.days,
      charge: charge ?? this.charge,
      value: value ?? this.value,
      additionalProperties: additionalProperties ?? this.additionalProperties,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(days != null){
      result.addAll({'days': days});
    }
    if(charge != null){
      result.addAll({'charge': charge});
    }
    if(value != null){
      result.addAll({'value': value});
    }
    if(additionalProperties != null){
      result.addAll({'additionalProperties': additionalProperties});
    }
  
    return result;
  }

  factory AgodaHotelSearchResCancellationPolicyParameter.fromMap(Map<String, dynamic> map) {
    return AgodaHotelSearchResCancellationPolicyParameter(
      days: map['days']?.toInt(),
      charge: map['charge'],
      value: map['value']?.toInt(),
      additionalProperties: Map<String, Object>.from(map['additionalProperties']),
    );
  }

  String toJson() => json.encode(toMap());

  factory AgodaHotelSearchResCancellationPolicyParameter.fromJson(String source) => AgodaHotelSearchResCancellationPolicyParameter.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AgodaHotelSearchResCancellationPolicyParameter(days: $days, charge: $charge, value: $value, additionalProperties: $additionalProperties)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is AgodaHotelSearchResCancellationPolicyParameter &&
      other.days == days &&
      other.charge == charge &&
      other.value == value &&
      mapEquals(other.additionalProperties, additionalProperties);
  }

  @override
  int get hashCode {
    return days.hashCode ^
      charge.hashCode ^
      value.hashCode ^
      additionalProperties.hashCode;
  }
}
