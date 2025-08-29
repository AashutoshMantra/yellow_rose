import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:yellow_rose/features/hotel/data/models/details/expedia/configuration.dart';
import 'package:yellow_rose/features/hotel/data/models/details/expedia/price_checl_link.dart';

class ExpediaHotelSearchResponseBedGroup {
  final String? id;
  final String? description;
  final ExpediaHotelSearchResponsePriceCheckLink? links;
  final List<ExpediaHotelSearchRespConfiguration>? configuration;
  ExpediaHotelSearchResponseBedGroup({
    this.id,
    this.description,
    this.links,
    this.configuration,
  });

  ExpediaHotelSearchResponseBedGroup copyWith({
    String? id,
    String? description,
    ExpediaHotelSearchResponsePriceCheckLink? links,
    List<ExpediaHotelSearchRespConfiguration>? configuration,
  }) {
    return ExpediaHotelSearchResponseBedGroup(
      id: id ?? this.id,
      description: description ?? this.description,
      links: links ?? this.links,
      configuration: configuration ?? this.configuration,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (description != null) {
      result.addAll({'description': description});
    }
    if (links != null) {
      result.addAll({'links': links!.toMap()});
    }
    if (configuration != null) {
      result.addAll(
          {'configuration': configuration!.map((x) => x.toMap()).toList()});
    }

    return result;
  }

  factory ExpediaHotelSearchResponseBedGroup.fromMap(Map<String, dynamic> map) {
    return ExpediaHotelSearchResponseBedGroup(
      id: map['id'],
      description: map['description'],
      links: map['links'] != null
          ? ExpediaHotelSearchResponsePriceCheckLink.fromMap(map['links'])
          : null,
      configuration: map['configuration'] != null
          ? List<ExpediaHotelSearchRespConfiguration>.from(map['configuration']
              ?.map((x) => ExpediaHotelSearchRespConfiguration.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ExpediaHotelSearchResponseBedGroup.fromJson(String source) =>
      ExpediaHotelSearchResponseBedGroup.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ExpediaHotelSearchResponseBedGroup(id: $id, description: $description, links: $links, configuration: $configuration)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ExpediaHotelSearchResponseBedGroup &&
        other.id == id &&
        other.description == description &&
        other.links == links &&
        listEquals(other.configuration, configuration);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        description.hashCode ^
        links.hashCode ^
        configuration.hashCode;
  }
}
