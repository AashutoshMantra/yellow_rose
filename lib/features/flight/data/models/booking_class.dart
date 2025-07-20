import 'dart:convert';

import 'package:yellow_rose/features/flight/data/models/bagge_ingo.dart';
import 'package:yellow_rose/features/flight/data/models/fare_detail_with_passenger_type.dart';

class BookingClass {
    final String bookingClass;
    final String fareBasis;
    final FareDetailsPerPassengerType fareDetailsPerPassengerType;
    final String seatsAvailability;
    final String fareType;
    final Map<String, Object>? otherData;
    final String? segmentKeys;
    final BaggageInfo? baggageInfo;
  BookingClass({
    required this.bookingClass,
    required this.fareBasis,
    required this.fareDetailsPerPassengerType,
    required this.seatsAvailability,
    required this.fareType,
    this.otherData,
    this.segmentKeys,
    this.baggageInfo,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'bookingClass': bookingClass});
    result.addAll({'fareBasis': fareBasis});
    result.addAll({'fareDetailsPerPassengerType': fareDetailsPerPassengerType.toMap()});
    result.addAll({'seatsAvailability': seatsAvailability});
    result.addAll({'fareType': fareType});
    if(otherData != null){
      result.addAll({'otherData': otherData});
    }
    if(segmentKeys != null){
      result.addAll({'segmentKeys': segmentKeys});
    }
    if(baggageInfo != null){
      result.addAll({'baggageInfo': baggageInfo!.toMap()});
    }
  
    return result;
  }

  factory BookingClass.fromMap(Map<String, dynamic> map) {
    return BookingClass(
      bookingClass: map['bookingClass'] ?? '',
      fareBasis: map['fareBasis'] ?? '',
      fareDetailsPerPassengerType: FareDetailsPerPassengerType.fromMap(map['fareDetailsPerPassengerType']),
      seatsAvailability: map['seatsAvailability'] ?? '',
      fareType: map['fareType'] ?? '',
      otherData:map['otherData']!=null? Map<String, Object>.from(map['otherData']):null,
      segmentKeys: map['segmentKeys'],
      baggageInfo: map['baggageInfo'] != null ? BaggageInfo.fromMap(map['baggageInfo']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BookingClass.fromJson(String source) => BookingClass.fromMap(json.decode(source));
}
