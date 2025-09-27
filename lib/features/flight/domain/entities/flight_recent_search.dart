import 'dart:convert';

import 'package:uuid/uuid.dart';
import 'package:yellow_rose/core/utils/extensions.dart';
import 'package:yellow_rose/features/flight/data/models/airsearch/air_search_request.dart';
import 'package:yellow_rose/features/flight/domain/entities/name_code.dart';
import 'package:yellow_rose/features/flight/domain/entities/source_date_pair.dart';

enum FlightSearchClass {
  Economy("Economy"),
  BusinessClass("Business Class"),
  FirstClass("First Class"),
  PremiumEconomy("Premium Economy");

  final String text;
  const FlightSearchClass(this.text);
  RequestedClass getRequestedClass() {
    switch (this) {
      case PremiumEconomy:
        return RequestedClass.W;

      case FlightSearchClass.Economy:
        return RequestedClass.Y;
      case FlightSearchClass.BusinessClass:
        return RequestedClass.C;
      case FlightSearchClass.FirstClass:
        return RequestedClass.F;
    }
  }
}

class AirSearch {
  final int childCount;
  final int adultCount;
  final int infantCount;

  final List<SourceDestinationDatePair> sources;
  final FlightSearchClass? searchClass;
  final NameCode? preferredCarrier;
  final bool? directFlight;
  final String requestId;
  AirSearch({
    this.childCount = 0,
    required this.adultCount,
    this.infantCount = 0,
    required this.sources,
    required this.searchClass,
    this.preferredCarrier,
    this.directFlight,
  }) : requestId = const Uuid().v4();

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    var filteredSources = sources
        .where((source) =>
            source.destination != null &&
            source.source != null &&
            source.sourceDate != null)
        .toList();

    result.addAll({'childCount': childCount});
    result.addAll({'adultCount': adultCount});
    result.addAll({'infantCount': infantCount});
    result.addAll({'sources': filteredSources.map((x) => x.toMap()).toList()});
    if (searchClass != null) {
      result.addAll({'searchClass': searchClass!.name});
    }
    if (preferredCarrier != null) {
      result.addAll({'preferredCarrier': preferredCarrier!.toMap()});
    }
    if (directFlight != null) {
      result.addAll({'directFlight': directFlight});
    }

    return result;
  }

  factory AirSearch.fromMap(Map<String, dynamic> map) {
    return AirSearch(
      childCount: map['childCount']?.toInt() ?? 0,
      adultCount: map['adultCount']?.toInt() ?? 0,
      infantCount: map['infantCount']?.toInt() ?? 0,
      sources: List<SourceDestinationDatePair>.from(
              map['sources']?.map((x) => SourceDestinationDatePair.fromMap(x)))
          .where((source) =>
              source.destination != null &&
              source.source != null &&
              source.sourceDate != null)
          .toList(),
      searchClass: stringToEnum(map['searchClass'], FlightSearchClass.values) ??
          FlightSearchClass.Economy,
      preferredCarrier: map['preferredCarrier'] != null
          ? NameCode.fromMap(Map<String, dynamic>.from(map['preferredCarrier']))
          : null,
      directFlight:
          map['directFlight'] == null ? null : (map['directFlight'] as bool),
    );
  }

  String toJson() => json.encode(toMap());

  factory AirSearch.fromJson(String source) =>
      AirSearch.fromMap(json.decode(source));
}
