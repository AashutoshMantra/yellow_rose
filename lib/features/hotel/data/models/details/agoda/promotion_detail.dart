import 'dart:convert';

import 'package:flutter/foundation.dart';

class AgodaHotelSearchResPromotionDetail {
  final int? promotionId;
  final bool? codeEligible;
  final String? description;
  final double? savingAmount;
  final int? supplierPromoTypeId;
  final String? supplierPromoTypeDescription;
  final Map<String, Object>? additionalProperties;
  AgodaHotelSearchResPromotionDetail({
    this.promotionId,
    this.codeEligible,
    this.description,
    this.savingAmount,
    this.supplierPromoTypeId,
    this.supplierPromoTypeDescription,
    this.additionalProperties,
  });

  AgodaHotelSearchResPromotionDetail copyWith({
    int? promotionId,
    bool? codeEligible,
    String? description,
    double? savingAmount,
    int? supplierPromoTypeId,
    String? supplierPromoTypeDescription,
    Map<String, Object>? additionalProperties,
  }) {
    return AgodaHotelSearchResPromotionDetail(
      promotionId: promotionId ?? this.promotionId,
      codeEligible: codeEligible ?? this.codeEligible,
      description: description ?? this.description,
      savingAmount: savingAmount ?? this.savingAmount,
      supplierPromoTypeId: supplierPromoTypeId ?? this.supplierPromoTypeId,
      supplierPromoTypeDescription: supplierPromoTypeDescription ?? this.supplierPromoTypeDescription,
      additionalProperties: additionalProperties ?? this.additionalProperties,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(promotionId != null){
      result.addAll({'promotionId': promotionId});
    }
    if(codeEligible != null){
      result.addAll({'codeEligible': codeEligible});
    }
    if(description != null){
      result.addAll({'description': description});
    }
    if(savingAmount != null){
      result.addAll({'savingAmount': savingAmount});
    }
    if(supplierPromoTypeId != null){
      result.addAll({'supplierPromoTypeId': supplierPromoTypeId});
    }
    if(supplierPromoTypeDescription != null){
      result.addAll({'supplierPromoTypeDescription': supplierPromoTypeDescription});
    }
    if(additionalProperties != null){
      result.addAll({'additionalProperties': additionalProperties});
    }
  
    return result;
  }

  factory AgodaHotelSearchResPromotionDetail.fromMap(Map<String, dynamic> map) {
    return AgodaHotelSearchResPromotionDetail(
      promotionId: map['promotionId']?.toInt(),
      codeEligible: map['codeEligible'],
      description: map['description'],
      savingAmount: map['savingAmount']?.toDouble(),
      supplierPromoTypeId: map['supplierPromoTypeId']?.toInt(),
      supplierPromoTypeDescription: map['supplierPromoTypeDescription'],
      additionalProperties: Map<String, Object>.from(map['additionalProperties']),
    );
  }

  String toJson() => json.encode(toMap());

  factory AgodaHotelSearchResPromotionDetail.fromJson(String source) => AgodaHotelSearchResPromotionDetail.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AgodaHotelSearchResPromotionDetail(promotionId: $promotionId, codeEligible: $codeEligible, description: $description, savingAmount: $savingAmount, supplierPromoTypeId: $supplierPromoTypeId, supplierPromoTypeDescription: $supplierPromoTypeDescription, additionalProperties: $additionalProperties)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is AgodaHotelSearchResPromotionDetail &&
      other.promotionId == promotionId &&
      other.codeEligible == codeEligible &&
      other.description == description &&
      other.savingAmount == savingAmount &&
      other.supplierPromoTypeId == supplierPromoTypeId &&
      other.supplierPromoTypeDescription == supplierPromoTypeDescription &&
      mapEquals(other.additionalProperties, additionalProperties);
  }

  @override
  int get hashCode {
    return promotionId.hashCode ^
      codeEligible.hashCode ^
      description.hashCode ^
      savingAmount.hashCode ^
      supplierPromoTypeId.hashCode ^
      supplierPromoTypeDescription.hashCode ^
      additionalProperties.hashCode;
  }
}
