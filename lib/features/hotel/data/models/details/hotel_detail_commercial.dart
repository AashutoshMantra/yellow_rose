import 'dart:convert';

import 'package:flutter/foundation.dart';

class HotelDetailCommercial {
  final double? markup;
  final List<String>? markupDesc;
  final double? charge;
  final List<String>? chargeDesc;
  HotelDetailCommercial({
    this.markup,
    this.markupDesc,
    this.charge,
    this.chargeDesc,
  });

  HotelDetailCommercial copyWith({
    double? markup,
    List<String>? markupDesc,
    double? charge,
    List<String>? chargeDesc,
  }) {
    return HotelDetailCommercial(
      markup: markup ?? this.markup,
      markupDesc: markupDesc ?? this.markupDesc,
      charge: charge ?? this.charge,
      chargeDesc: chargeDesc ?? this.chargeDesc,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(markup != null){
      result.addAll({'markup': markup});
    }
    if(markupDesc != null){
      result.addAll({'markupDesc': markupDesc});
    }
    if(charge != null){
      result.addAll({'charge': charge});
    }
    if(chargeDesc != null){
      result.addAll({'chargeDesc': chargeDesc});
    }
  
    return result;
  }

  factory HotelDetailCommercial.fromMap(Map<String, dynamic> map) {
    return HotelDetailCommercial(
      markup: map['markup']?.toDouble(),
      markupDesc: List<String>.from(map['markupDesc']),
      charge: map['charge']?.toDouble(),
      chargeDesc: List<String>.from(map['chargeDesc']),
    );
  }

  String toJson() => json.encode(toMap());

  factory HotelDetailCommercial.fromJson(String source) => HotelDetailCommercial.fromMap(json.decode(source));

  @override
  String toString() {
    return 'HotelDetailCommercial(markup: $markup, markupDesc: $markupDesc, charge: $charge, chargeDesc: $chargeDesc)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is HotelDetailCommercial &&
      other.markup == markup &&
      listEquals(other.markupDesc, markupDesc) &&
      other.charge == charge &&
      listEquals(other.chargeDesc, chargeDesc);
  }

  @override
  int get hashCode {
    return markup.hashCode ^
      markupDesc.hashCode ^
      charge.hashCode ^
      chargeDesc.hashCode;
  }
}
