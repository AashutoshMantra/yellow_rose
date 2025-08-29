import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:yellow_rose/features/hotel/data/models/details/expedia/room/bod_group_configuration.dart';
import 'package:yellow_rose/features/hotel/data/models/details/expedia/room/content_response_link.dart';

class ExpediaHotelContentResponseBedGroup {
  final String? id;
  final String? description;
  final List<ExpediaHotelContentResponseBedGroupConfiguration> configuration;
  final List<ExpediaHotelContentResponseLink> links;
  ExpediaHotelContentResponseBedGroup({
    this.id,
    this.description,
    required this.configuration,
    required this.links,
  });

  ExpediaHotelContentResponseBedGroup copyWith({
    String? id,
    String? description,
    List<ExpediaHotelContentResponseBedGroupConfiguration>? configuration,
    List<ExpediaHotelContentResponseLink>? links,
  }) {
    return ExpediaHotelContentResponseBedGroup(
      id: id ?? this.id,
      description: description ?? this.description,
      configuration: configuration ?? this.configuration,
      links: links ?? this.links,
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
    result.addAll(
        {'configuration': configuration.map((x) => x.toMap()).toList()});
    result.addAll({'links': links.map((x) => x.toMap()).toList()});

    return result;
  }

  factory ExpediaHotelContentResponseBedGroup.fromMap(
      Map<String, dynamic> map) {
    return ExpediaHotelContentResponseBedGroup(
      id: map['id'],
      description: map['description'],
      configuration:
          List<ExpediaHotelContentResponseBedGroupConfiguration>.from(
              map['configuration']?.map((x) =>
                  ExpediaHotelContentResponseBedGroupConfiguration.fromMap(x))),
      links: List<ExpediaHotelContentResponseLink>.from(
          map['links']?.map((x) => ExpediaHotelContentResponseLink.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory ExpediaHotelContentResponseBedGroup.fromJson(String source) =>
      ExpediaHotelContentResponseBedGroup.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ExpediaHotelContentResponseBedGroup(id: $id, description: $description, configuration: $configuration, links: $links)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ExpediaHotelContentResponseBedGroup &&
        other.id == id &&
        other.description == description &&
        listEquals(other.configuration, configuration) &&
        listEquals(other.links, links);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        description.hashCode ^
        configuration.hashCode ^
        links.hashCode;
  }
}
