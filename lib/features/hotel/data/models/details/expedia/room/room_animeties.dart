import 'dart:convert';

import 'package:flutter/foundation.dart';

class ExpediaHotelContentResponseAmenity {
  final String? id;
  final String? name;
  final String? value;
  final List<String>? categories;
  ExpediaHotelContentResponseAmenity({
    this.id,
    this.name,
    this.value,
    this.categories,
  });

  ExpediaHotelContentResponseAmenity copyWith({
    String? id,
    String? name,
    String? value,
    List<String>? categories,
  }) {
    return ExpediaHotelContentResponseAmenity(
      id: id ?? this.id,
      name: name ?? this.name,
      value: value ?? this.value,
      categories: categories ?? this.categories,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (name != null) {
      result.addAll({'name': name});
    }
    if (value != null) {
      result.addAll({'value': value});
    }
    if (categories != null) {
      result.addAll({'categories': categories});
    }

    return result;
  }

  factory ExpediaHotelContentResponseAmenity.fromMap(Map<String, dynamic> map) {
    return ExpediaHotelContentResponseAmenity(
      id: map['id'],
      name: map['name'],
      value: map['value'],
      categories: List<String>.from(map['categories']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ExpediaHotelContentResponseAmenity.fromJson(String source) =>
      ExpediaHotelContentResponseAmenity.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ExpediaHotelContentResponseAmenity(id: $id, name: $name, value: $value, categories: $categories)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ExpediaHotelContentResponseAmenity &&
        other.id == id &&
        other.name == name &&
        other.value == value &&
        listEquals(other.categories, categories);
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ value.hashCode ^ categories.hashCode;
  }
}
