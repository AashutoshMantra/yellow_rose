import 'dart:convert';

import 'package:yellow_rose/features/hotel/data/models/details/agoda/res_rate.dart';

class AgodaHotelSearchResSurchargeBreakdown {
  final int? id;
  final String? name;
  final AgodaHotelSearchResRate? rate;
  AgodaHotelSearchResSurchargeBreakdown({
    this.id,
    this.name,
    this.rate,
  });

  AgodaHotelSearchResSurchargeBreakdown copyWith({
    int? id,
    String? name,
    AgodaHotelSearchResRate? rate,
  }) {
    return AgodaHotelSearchResSurchargeBreakdown(
      id: id ?? this.id,
      name: name ?? this.name,
      rate: rate ?? this.rate,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(id != null){
      result.addAll({'id': id});
    }
    if(name != null){
      result.addAll({'name': name});
    }
    if(rate != null){
      result.addAll({'rate': rate!.toMap()});
    }
  
    return result;
  }

  factory AgodaHotelSearchResSurchargeBreakdown.fromMap(Map<String, dynamic> map) {
    return AgodaHotelSearchResSurchargeBreakdown(
      id: map['id']?.toInt(),
      name: map['name'],
      rate: map['rate'] != null ? AgodaHotelSearchResRate.fromMap(map['rate']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AgodaHotelSearchResSurchargeBreakdown.fromJson(String source) => AgodaHotelSearchResSurchargeBreakdown.fromMap(json.decode(source));

  @override
  String toString() => 'AgodaHotelSearchResSurchargeBreakdown(id: $id, name: $name, rate: $rate)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is AgodaHotelSearchResSurchargeBreakdown &&
      other.id == id &&
      other.name == name &&
      other.rate == rate;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ rate.hashCode;
}
