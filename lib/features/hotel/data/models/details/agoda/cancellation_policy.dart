import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:yellow_rose/features/hotel/data/models/details/agoda/cancaellation_policy_dart.dart';
import 'package:yellow_rose/features/hotel/data/models/details/agoda/cancellation_policy_paramter.dart';

class AgodaHotelSearchResCancellationPolicy {
  final String? code;
  final String? cancellationText;
  final String? translatedCancellationText;
  final List<AgodaHotelSearchResCancellationPolicyParameter>? parameters;
  final List<AgodaHotelSearchResCancellationPolicyDate>? date;
  final Map<String, Object>? additionalProperties;
  AgodaHotelSearchResCancellationPolicy({
    this.code,
    this.cancellationText,
    this.translatedCancellationText,
    this.parameters,
    this.date,
    this.additionalProperties,
  });

  AgodaHotelSearchResCancellationPolicy copyWith({
    String? code,
    String? cancellationText,
    String? translatedCancellationText,
    List<AgodaHotelSearchResCancellationPolicyParameter>? parameters,
    List<AgodaHotelSearchResCancellationPolicyDate>? date,
    Map<String, Object>? additionalProperties,
  }) {
    return AgodaHotelSearchResCancellationPolicy(
      code: code ?? this.code,
      cancellationText: cancellationText ?? this.cancellationText,
      translatedCancellationText:
          translatedCancellationText ?? this.translatedCancellationText,
      parameters: parameters ?? this.parameters,
      date: date ?? this.date,
      additionalProperties: additionalProperties ?? this.additionalProperties,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (code != null) {
      result.addAll({'code': code});
    }
    if (cancellationText != null) {
      result.addAll({'cancellationText': cancellationText});
    }
    if (translatedCancellationText != null) {
      result.addAll({'translatedCancellationText': translatedCancellationText});
    }
    if (parameters != null) {
      result.addAll({'parameters': parameters!.map((x) => x.toMap()).toList()});
    }
    if (date != null) {
      result.addAll({'date': date!.map((x) => x.toMap()).toList()});
    }
    if (additionalProperties != null) {
      result.addAll({'additionalProperties': additionalProperties});
    }

    return result;
  }

  factory AgodaHotelSearchResCancellationPolicy.fromMap(
      Map<String, dynamic> map) {
    return AgodaHotelSearchResCancellationPolicy(
      code: map['code'],
      cancellationText: map['cancellationText'],
      translatedCancellationText: map['translatedCancellationText'],
      parameters: map['parameters'] != null
          ? List<AgodaHotelSearchResCancellationPolicyParameter>.from(
              map['parameters']?.map((x) =>
                  AgodaHotelSearchResCancellationPolicyParameter.fromMap(x)))
          : null,
      date: map['date'] != null
          ? List<AgodaHotelSearchResCancellationPolicyDate>.from(map['date']
              ?.map(
                  (x) => AgodaHotelSearchResCancellationPolicyDate.fromMap(x)))
          : null,
      additionalProperties:
          Map<String, Object>.from(map['additionalProperties']),
    );
  }

  String toJson() => json.encode(toMap());

  factory AgodaHotelSearchResCancellationPolicy.fromJson(String source) =>
      AgodaHotelSearchResCancellationPolicy.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AgodaHotelSearchResCancellationPolicy(code: $code, cancellationText: $cancellationText, translatedCancellationText: $translatedCancellationText, parameters: $parameters, date: $date, additionalProperties: $additionalProperties)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AgodaHotelSearchResCancellationPolicy &&
        other.code == code &&
        other.cancellationText == cancellationText &&
        other.translatedCancellationText == translatedCancellationText &&
        listEquals(other.parameters, parameters) &&
        listEquals(other.date, date) &&
        mapEquals(other.additionalProperties, additionalProperties);
  }

  @override
  int get hashCode {
    return code.hashCode ^
        cancellationText.hashCode ^
        translatedCancellationText.hashCode ^
        parameters.hashCode ^
        date.hashCode ^
        additionalProperties.hashCode;
  }
}
