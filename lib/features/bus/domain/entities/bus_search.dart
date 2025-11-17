import 'dart:convert';

import 'package:uuid/uuid.dart';
import 'package:yellow_rose/core/utils/date_utils.dart';
import 'package:yellow_rose/features/bus/data/models/search/bus_city_response.dart';

class BusSearch {
  final BusCityResponse? source;
  final BusCityResponse? destination;
  final DateTime? dateOfJourney;
  final String requestId;

  BusSearch({
    this.source,
    this.destination,
    this.dateOfJourney,
  }) : requestId = const Uuid().v4();

  BusSearch copyWith({
    BusCityResponse? source,
    BusCityResponse? destination,
    DateTime? dateOfJourney,
  }) {
    return BusSearch(
      source: source ?? this.source,
      destination: destination ?? this.destination,
      dateOfJourney: dateOfJourney ?? this.dateOfJourney,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'requestId': requestId});
    if (source != null) {
      result.addAll({'source': source!.toMap()});
    }
    if (destination != null) {
      result.addAll({'destination': destination!.toMap()});
    }
    if (dateOfJourney != null) {
      result.addAll({
        'dateOfJourney':
            CustomDateUtils.dateTimeInIsoFormatWithoutZone(dateOfJourney!)
      });
    }

    return result;
  }

  factory BusSearch.fromMap(Map<String, dynamic> map) {
    return BusSearch(
      source:
          map['source'] != null ? BusCityResponse.fromMap(map['source']) : null,
      destination: map['destination'] != null
          ? BusCityResponse.fromMap(map['destination'])
          : null,
      dateOfJourney: map['dateOfJourney'] != null
          ? DateTime.tryParse(map['dateOfJourney'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BusSearch.fromJson(String source) =>
      BusSearch.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BusSearch(source: $source, destination: $destination, dateOfJourney: $dateOfJourney, requestId: $requestId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BusSearch &&
        other.source == source &&
        other.destination == destination &&
        CustomDateUtils.customApiDayFormat(other.dateOfJourney!) ==
            CustomDateUtils.customApiDayFormat(dateOfJourney!);
  }

  @override
  int get hashCode {
    return source.hashCode ^
        destination.hashCode ^
        CustomDateUtils.customApiDayFormat(dateOfJourney!).hashCode;
  }
}
