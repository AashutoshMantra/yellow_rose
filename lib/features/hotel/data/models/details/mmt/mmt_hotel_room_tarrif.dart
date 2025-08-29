import 'dart:convert';

import 'package:flutter/foundation.dart';

class MMTHotelSearchResRoomTariff {
  final int? adult;
  final int? children;
  final List<int>? childrenAges;
  final double? displayPrice;
  MMTHotelSearchResRoomTariff({
    this.adult,
    this.children,
    this.childrenAges,
    this.displayPrice,
  });

  MMTHotelSearchResRoomTariff copyWith({
    int? adult,
    int? children,
    List<int>? childrenAges,
    double? displayPrice,
  }) {
    return MMTHotelSearchResRoomTariff(
      adult: adult ?? this.adult,
      children: children ?? this.children,
      childrenAges: childrenAges ?? this.childrenAges,
      displayPrice: displayPrice ?? this.displayPrice,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(adult != null){
      result.addAll({'adult': adult});
    }
    if(children != null){
      result.addAll({'children': children});
    }
    if(childrenAges != null){
      result.addAll({'childrenAges': childrenAges});
    }
    if(displayPrice != null){
      result.addAll({'displayPrice': displayPrice});
    }
  
    return result;
  }

  factory MMTHotelSearchResRoomTariff.fromMap(Map<String, dynamic> map) {
    return MMTHotelSearchResRoomTariff(
      adult: map['adult']?.toInt(),
      children: map['children']?.toInt(),
      childrenAges: List<int>.from(map['childrenAges']),
      displayPrice: map['displayPrice']?.toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory MMTHotelSearchResRoomTariff.fromJson(String source) => MMTHotelSearchResRoomTariff.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MMTHotelSearchResRoomTariff(adult: $adult, children: $children, childrenAges: $childrenAges, displayPrice: $displayPrice)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is MMTHotelSearchResRoomTariff &&
      other.adult == adult &&
      other.children == children &&
      listEquals(other.childrenAges, childrenAges) &&
      other.displayPrice == displayPrice;
  }

  @override
  int get hashCode {
    return adult.hashCode ^
      children.hashCode ^
      childrenAges.hashCode ^
      displayPrice.hashCode;
  }
}
