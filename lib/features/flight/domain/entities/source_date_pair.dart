import 'dart:convert';

import 'package:yellow_rose/core/nullable.dart';
import 'package:yellow_rose/features/flight/data/models/airports.dart';
import 'package:yellow_rose/features/flight/domain/entities/name_code.dart';

class SourceDestinationDatePair {
  final Airport? source;
  final Airport? destination;

  final DateTime? sourceDate;
  final DateTime? returnDate;

  SourceDestinationDatePair({
    this.source,
    this.destination,
    this.sourceDate,
    this.returnDate,
  });

  SourceDestinationDatePair copyWith({
    Airport? source,
    Airport? destination,
    DateTime? sourceDate,
    Nullable<DateTime>? returnDate,
  }) {
    return SourceDestinationDatePair(
      source: source ?? this.source,
      destination: destination ?? this.destination,
      sourceDate: sourceDate ?? this.sourceDate,
      returnDate: returnDate == null ? this.returnDate : returnDate.value,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    if (destination != null) {
      result.addAll({'source': source!.toMap()});
    }
    if (destination != null) {
      result.addAll({'destination': destination!.toMap()});
    }
    if (sourceDate != null) {
      result.addAll({'sourceDate': sourceDate!.millisecondsSinceEpoch});
    }
    if (returnDate != null) {
      result.addAll({'returnDate': returnDate!.millisecondsSinceEpoch});
    }

    return result;
  }

  factory SourceDestinationDatePair.fromMap(Map<String, dynamic> map) {
    return SourceDestinationDatePair(
      source: map['source'] != null ? Airport.fromMap(map['source']) : null,
      destination: map['destination'] != null
          ? Airport.fromMap(map['destination'])
          : null,
      sourceDate: map['sourceDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['sourceDate'])
          : null,
      returnDate: map['returnDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['returnDate'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SourceDestinationDatePair.fromJson(String source) =>
      SourceDestinationDatePair.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SourceDestinationDatePair(source: $source, destination: $destination, sourceDate: $sourceDate, returnDate: $returnDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SourceDestinationDatePair &&
        other.source == source &&
        other.destination == destination &&
        other.sourceDate == sourceDate &&
        other.returnDate == returnDate;
  }

  @override
  int get hashCode {
    return source.hashCode ^
        destination.hashCode ^
        sourceDate.hashCode ^
        returnDate.hashCode;
  }
}
