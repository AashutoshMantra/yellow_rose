import 'dart:convert';

import 'package:flutter/foundation.dart';

class AgodaHotelSearchResBenefit {
  final int? id;
  final String? benefitName;
  final String? translatedBenefitName;
  final Map<String, Object>? additionalProperties;
  AgodaHotelSearchResBenefit({
    this.id,
    this.benefitName,
    this.translatedBenefitName,
    this.additionalProperties,
  });

  AgodaHotelSearchResBenefit copyWith({
    int? id,
    String? benefitName,
    String? translatedBenefitName,
    Map<String, Object>? additionalProperties,
  }) {
    return AgodaHotelSearchResBenefit(
      id: id ?? this.id,
      benefitName: benefitName ?? this.benefitName,
      translatedBenefitName: translatedBenefitName ?? this.translatedBenefitName,
      additionalProperties: additionalProperties ?? this.additionalProperties,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(id != null){
      result.addAll({'id': id});
    }
    if(benefitName != null){
      result.addAll({'benefitName': benefitName});
    }
    if(translatedBenefitName != null){
      result.addAll({'translatedBenefitName': translatedBenefitName});
    }
    if(additionalProperties != null){
      result.addAll({'additionalProperties': additionalProperties});
    }
  
    return result;
  }

  factory AgodaHotelSearchResBenefit.fromMap(Map<String, dynamic> map) {
    return AgodaHotelSearchResBenefit(
      id: map['id']?.toInt(),
      benefitName: map['benefitName'],
      translatedBenefitName: map['translatedBenefitName'],
      additionalProperties: Map<String, Object>.from(map['additionalProperties']),
    );
  }

  String toJson() => json.encode(toMap());

  factory AgodaHotelSearchResBenefit.fromJson(String source) => AgodaHotelSearchResBenefit.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AgodaHotelSearchResBenefit(id: $id, benefitName: $benefitName, translatedBenefitName: $translatedBenefitName, additionalProperties: $additionalProperties)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is AgodaHotelSearchResBenefit &&
      other.id == id &&
      other.benefitName == benefitName &&
      other.translatedBenefitName == translatedBenefitName &&
      mapEquals(other.additionalProperties, additionalProperties);
  }

  @override
  int get hashCode {
    return id.hashCode ^
      benefitName.hashCode ^
      translatedBenefitName.hashCode ^
      additionalProperties.hashCode;
  }
}
