import 'dart:convert';

class ExpediaHotelSearchRespSaleScenario {
    final bool? ssPackage;
    final bool? member;
    final bool? corporate;
    final bool? distribution;
    final bool? mobilePromotion;
  ExpediaHotelSearchRespSaleScenario({
    this.ssPackage,
    this.member,
    this.corporate,
    this.distribution,
    this.mobilePromotion,
  });

  ExpediaHotelSearchRespSaleScenario copyWith({
    bool? ssPackage,
    bool? member,
    bool? corporate,
    bool? distribution,
    bool? mobilePromotion,
  }) {
    return ExpediaHotelSearchRespSaleScenario(
      ssPackage: ssPackage ?? this.ssPackage,
      member: member ?? this.member,
      corporate: corporate ?? this.corporate,
      distribution: distribution ?? this.distribution,
      mobilePromotion: mobilePromotion ?? this.mobilePromotion,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(ssPackage != null){
      result.addAll({'ssPackage': ssPackage});
    }
    if(member != null){
      result.addAll({'member': member});
    }
    if(corporate != null){
      result.addAll({'corporate': corporate});
    }
    if(distribution != null){
      result.addAll({'distribution': distribution});
    }
    if(mobilePromotion != null){
      result.addAll({'mobilePromotion': mobilePromotion});
    }
  
    return result;
  }

  factory ExpediaHotelSearchRespSaleScenario.fromMap(Map<String, dynamic> map) {
    return ExpediaHotelSearchRespSaleScenario(
      ssPackage: map['ssPackage'],
      member: map['member'],
      corporate: map['corporate'],
      distribution: map['distribution'],
      mobilePromotion: map['mobilePromotion'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ExpediaHotelSearchRespSaleScenario.fromJson(String source) => ExpediaHotelSearchRespSaleScenario.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ExpediaHotelSearchRespSaleScenario(ssPackage: $ssPackage, member: $member, corporate: $corporate, distribution: $distribution, mobilePromotion: $mobilePromotion)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ExpediaHotelSearchRespSaleScenario &&
      other.ssPackage == ssPackage &&
      other.member == member &&
      other.corporate == corporate &&
      other.distribution == distribution &&
      other.mobilePromotion == mobilePromotion;
  }

  @override
  int get hashCode {
    return ssPackage.hashCode ^
      member.hashCode ^
      corporate.hashCode ^
      distribution.hashCode ^
      mobilePromotion.hashCode;
  }
}
