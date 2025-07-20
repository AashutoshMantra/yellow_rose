import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:yellow_rose/features/flight/data/models/booking/ssor_options.dart';
import 'package:yellow_rose/features/flight/data/models/erro_code_handler.dart';

class SsrResponse {
  final List<SsrOption> ssrMeals;

  final List<SsrOption> ssrBaggage;
  final List<SsrOption> ssrSpecial;
  final List<SsrOption> miscSSR;
  ErrorCodeHandler? errorDetails;
  SsrResponse({
    required this.ssrMeals,
    required this.ssrBaggage,
    required this.ssrSpecial,
    required this.miscSSR,
    required this.errorDetails,
  });

  SsrResponse copyWith({
    List<SsrOption>? ssrMeals,
    List<SsrOption>? ssrBaggage,
    List<SsrOption>? ssrSpecial,
    List<SsrOption>? miscSSR,
    ErrorCodeHandler? errorDetails,
  }) {
    return SsrResponse(
      ssrMeals: ssrMeals ?? this.ssrMeals,
      ssrBaggage: ssrBaggage ?? this.ssrBaggage,
      ssrSpecial: ssrSpecial ?? this.ssrSpecial,
      miscSSR: miscSSR ?? this.miscSSR,
      errorDetails: errorDetails ?? this.errorDetails,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'ssrMeals': ssrMeals.map((x) => x.toMap()).toList()});
    result.addAll({'ssrBaggage': ssrBaggage.map((x) => x.toMap()).toList()});
    result.addAll({'ssrSpecial': ssrSpecial.map((x) => x.toMap()).toList()});
    result.addAll({'miscSSR': miscSSR.map((x) => x.toMap()).toList()});
    result.addAll({'errorDetails': errorDetails?.toMap()});

    return result;
  }

  factory SsrResponse.fromMap(Map<String, dynamic> map) {
    return SsrResponse(
      ssrMeals: List<SsrOption>.from(
          (map['ssrMeals'] ?? [])?.map((x) => SsrOption.fromMap(x))),
      ssrBaggage: List<SsrOption>.from(
          (map['ssrBaggage'] ?? [])?.map((x) => SsrOption.fromMap(x))),
      ssrSpecial: List<SsrOption>.from(
          (map['ssrSpecial'] ?? [])?.map((x) => SsrOption.fromMap(x))),
      miscSSR: List<SsrOption>.from(
          (map['miscSSR'] ?? [])?.map((x) => SsrOption.fromMap(x))),
      errorDetails: map['errorDetails'] != null
          ? ErrorCodeHandler.fromMap(map['errorDetails'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SsrResponse.fromJson(String source) =>
      SsrResponse.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SsrResponse(ssrMeals: $ssrMeals, ssrBaggage: $ssrBaggage, ssrSpecial: $ssrSpecial, miscSSR: $miscSSR, errorDetails: $errorDetails)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SsrResponse &&
        listEquals(other.ssrMeals, ssrMeals) &&
        listEquals(other.ssrBaggage, ssrBaggage) &&
        listEquals(other.ssrSpecial, ssrSpecial) &&
        listEquals(other.miscSSR, miscSSR) &&
        other.errorDetails == errorDetails;
  }

  @override
  int get hashCode {
    return ssrMeals.hashCode ^
        ssrBaggage.hashCode ^
        ssrSpecial.hashCode ^
        miscSSR.hashCode ^
        errorDetails.hashCode;
  }
}
