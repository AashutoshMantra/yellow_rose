import 'dart:convert';

import 'package:yellow_rose/core/utils/extensions.dart';
import 'package:yellow_rose/features/flight/data/models/airsearch/air_response_data.dart';
import 'package:yellow_rose/features/flight/domain/entities/air_sources.dart';

class GroupedSearchItineraries {
  final AirResponseData? flight;
  final String? fromAirport;
  final String? toAirport;

  final String? source;
  GroupedSearchItineraries({
    this.flight,
    this.fromAirport,
    this.toAirport,
    this.source,
  });

  GroupedSearchItineraries copyWith({
    AirResponseData? flight,
    String? fromAirport,
    String? toAirport,
    String? source,
  }) {
    return GroupedSearchItineraries(
      flight: flight ?? this.flight,
      fromAirport: fromAirport ?? this.fromAirport,
      toAirport: toAirport ?? this.toAirport,
      source: source ?? this.source,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (flight != null) {
      result.addAll({'flight': flight!.toMap()});
    }
    if (fromAirport != null) {
      result.addAll({'fromAirport': fromAirport});
    }
    if (toAirport != null) {
      result.addAll({'toAirport': toAirport});
    }
    if (source != null) {
      result.addAll({'source': source});
    }

    return result;
  }

  factory GroupedSearchItineraries.fromMap(Map<String, dynamic> map) {
    return GroupedSearchItineraries(
      flight:
          map['flight'] != null ? AirResponseData.fromMap(map['flight']) : null,
      fromAirport: map['fromAirport'],
      toAirport: map['toAirport'],
      source:map['source'],
    );
  }

  String toJson() => json.encode(toMap());

  factory GroupedSearchItineraries.fromJson(String source) =>
      GroupedSearchItineraries.fromMap(json.decode(source));

  @override
  String toString() {
    return 'GroupedSearchItineraries(flight: $flight, fromAirport: $fromAirport, toAirport: $toAirport, source: $source)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GroupedSearchItineraries &&
        other.flight == flight &&
        other.fromAirport == fromAirport &&
        other.toAirport == toAirport &&
        other.source == source;
  }

  @override
  int get hashCode {
    return flight.hashCode ^
        fromAirport.hashCode ^
        toAirport.hashCode ^
        source.hashCode;
  }
}
