import 'dart:convert';

import 'package:yellow_rose/features/flight/data/models/bagge_ingo.dart';
import 'package:yellow_rose/features/flight/data/models/fare_detail_with_passenger_type.dart';

class BookingClass {
  final String bookingClass;
  final String fareBasis;
  final FareDetailsPerPassengerType fareDetailsPerPassengerType;
  final String seatsAvailability;
  final String fareType;
  final String? fareTypeDisplay;
  final Map<String, Object>? otherData;
  final String? segmentKeys;
  final BaggageInfo? baggageInfo;
  final String? source;
  final String? supplier;
  BookingClass({
    required this.bookingClass,
    required this.fareBasis,
    required this.fareDetailsPerPassengerType,
    required this.seatsAvailability,
    required this.fareType,
    this.fareTypeDisplay,
    this.otherData,
    this.segmentKeys,
    this.baggageInfo,
    this.source,
    this.supplier,
  });

  /// Returns the fare type to use everywhere — prefers fareTypeDisplay, falls back to fareType.
  String get effectiveFareType => fareTypeDisplay ?? fareType;

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'bookingClass': bookingClass});
    result.addAll({'fareBasis': fareBasis});
    result.addAll(
        {'fareDetailsPerPassengerType': fareDetailsPerPassengerType.toMap()});
    result.addAll({'seatsAvailability': seatsAvailability});
    result.addAll({'fareType': fareType});
    if (fareTypeDisplay != null) {
      result.addAll({'fareTypeDisplay': fareTypeDisplay});
    }
    if (otherData != null) {
      result.addAll({'otherData': otherData});
    }
    if (segmentKeys != null) {
      result.addAll({'segmentKeys': segmentKeys});
    }
    if (baggageInfo != null) {
      result.addAll({'baggageInfo': baggageInfo!.toMap()});
    }
    if (source != null) {
      result.addAll({'source': source});
    }
    if (supplier != null) {
      result.addAll({'supplier': supplier});
    }

    return result;
  }

  factory BookingClass.fromMap(Map<String, dynamic> map) {
    return BookingClass(
      bookingClass: map['bookingClass'] ?? '',
      fareBasis: map['fareBasis'] ?? '',
      fareDetailsPerPassengerType: FareDetailsPerPassengerType.fromMap(
          map['fareDetailsPerPassengerType']),
      seatsAvailability: map['seatsAvailability'] ?? '',
      fareType: map['fareType'] ?? '',
      fareTypeDisplay: map['fareTypeDisplay'],
      otherData: map['otherData'] != null
          ? Map<String, Object>.from(map['otherData'])
          : null,
      segmentKeys: map['segmentKeys'],
      baggageInfo: map['baggageInfo'] != null
          ? BaggageInfo.fromMap(map['baggageInfo'])
          : null,
      source: map['source'],
      supplier: map['supplier'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BookingClass.fromJson(String source) =>
      BookingClass.fromMap(json.decode(source));
}
