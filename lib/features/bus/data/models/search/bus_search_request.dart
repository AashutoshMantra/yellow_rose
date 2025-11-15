import 'dart:convert';

import 'package:uuid/uuid.dart';
import 'package:yellow_rose/core/utils/date_utils.dart';

class BusSearchRequest {
  String? requestId;
  String source;
  int sourceId;
  String destination;
  int destinationId;
  DateTime dateOfJourney;
  BusSearchRequest({
    String? requestId,
    required this.source,
    required this.sourceId,
    required this.destination,
    required this.destinationId,
    required this.dateOfJourney,
  }) : requestId = requestId ?? const Uuid().v4();

  BusSearchRequest copyWith({
    String? requestId,
    String? source,
    int? sourceId,
    String? destination,
    int? destinationId,
    DateTime? dateOfJourney,
  }) {
    return BusSearchRequest(
      requestId: requestId ?? this.requestId,
      source: source ?? this.source,
      sourceId: sourceId ?? this.sourceId,
      destination: destination ?? this.destination,
      destinationId: destinationId ?? this.destinationId,
      dateOfJourney: dateOfJourney ?? this.dateOfJourney,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (requestId != null) {
      result.addAll({'requestId': requestId});
    }
    result.addAll({'source': source});
    result.addAll({'sourceId': sourceId});
    result.addAll({'destination': destination});
    result.addAll({'destinationId': destinationId});
    result.addAll(
        {'dateOfJourney': CustomDateUtils.customApiDayFormat(dateOfJourney)});

    return result;
  }

  factory BusSearchRequest.fromMap(Map<String, dynamic> map) {
    return BusSearchRequest(
      requestId: map['requestId'],
      source: map['source'] ?? '',
      sourceId: map['sourceId']?.toInt() ?? 0,
      destination: map['destination'] ?? '',
      destinationId: map['destinationId']?.toInt() ?? 0,
      dateOfJourney: DateTime.parse(map['dateOfJourney']),
    );
  }

  String toJson() => json.encode(toMap());

  factory BusSearchRequest.fromJson(String source) =>
      BusSearchRequest.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BusSearchRequest(requestId: $requestId, source: $source, sourceId: $sourceId, destination: $destination, destinationId: $destinationId, dateOfJourney: $dateOfJourney)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BusSearchRequest &&
        other.requestId == requestId &&
        other.source == source &&
        other.sourceId == sourceId &&
        other.destination == destination &&
        other.destinationId == destinationId &&
        other.dateOfJourney == dateOfJourney;
  }

  @override
  int get hashCode {
    return requestId.hashCode ^
        source.hashCode ^
        sourceId.hashCode ^
        destination.hashCode ^
        destinationId.hashCode ^
        dateOfJourney.hashCode;
  }
}
