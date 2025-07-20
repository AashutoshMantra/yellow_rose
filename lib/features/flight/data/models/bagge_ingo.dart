import 'dart:convert';

import 'package:yellow_rose/core/utils/extensions.dart';


 enum BaggageUnitTypes {
    Kilograms,
    Pounds,
    Piece;
}
class BaggageInfo {
    final BaggageUnitTypes? unit;
    final int? value;
    final String? pieceValue;
  BaggageInfo({
    this.unit,
    this.value,
    this.pieceValue,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(unit != null){
      result.addAll({'unit': unit!.name});
    }
    if(value != null){
      result.addAll({'value': value});
    }
    if(pieceValue != null){
      result.addAll({'pieceValue': pieceValue});
    }
  
    return result;
  }

  factory BaggageInfo.fromMap(Map<String, dynamic> map) {
    return BaggageInfo(
      unit:stringToEnum(map['unit'], BaggageUnitTypes.values) ,
      value: map['value']?.toInt(),
      pieceValue: map['pieceValue'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BaggageInfo.fromJson(String source) => BaggageInfo.fromMap(json.decode(source));
}
