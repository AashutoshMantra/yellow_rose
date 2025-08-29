import 'dart:convert';

import 'package:flutter/foundation.dart';

class MMTHotelMetadataPolicy {
  final String? id;
  final String? category;
  final List<String>? policyList;
  MMTHotelMetadataPolicy({
    this.id,
    this.category,
    this.policyList,
  });

  MMTHotelMetadataPolicy copyWith({
    String? id,
    String? category,
    List<String>? policyList,
  }) {
    return MMTHotelMetadataPolicy(
      id: id ?? this.id,
      category: category ?? this.category,
      policyList: policyList ?? this.policyList,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (category != null) {
      result.addAll({'category': category});
    }
    if (policyList != null) {
      result.addAll({'policyList': policyList});
    }

    return result;
  }

  factory MMTHotelMetadataPolicy.fromMap(Map<String, dynamic> map) {
    return MMTHotelMetadataPolicy(
      id: map['id'],
      category: map['category'],
      policyList: List<String>.from(map['policyList']),
    );
  }

  String toJson() => json.encode(toMap());

  factory MMTHotelMetadataPolicy.fromJson(String source) =>
      MMTHotelMetadataPolicy.fromMap(json.decode(source));

  @override
  String toString() =>
      'MMTHotelMetadataPolicy(id: $id, category: $category, policyList: $policyList)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MMTHotelMetadataPolicy &&
        other.id == id &&
        other.category == category &&
        listEquals(other.policyList, policyList);
  }

  @override
  int get hashCode => id.hashCode ^ category.hashCode ^ policyList.hashCode;
}
