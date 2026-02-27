import 'dart:convert';

import 'package:yellow_rose/features/trip/data/models/trip_detail.dart';

// {
//    "tripName": "fsfhdfsdg",
//   "tripDescription": "fdhfd",
//   "tripFor": "Self",
//   "tripPurpose": "meeting",
// }

enum TripFor {
  Self("Self", "SELF"),
  OnBehalfOf("On Behalf Of", "ON_BEHALF"),
  NonEmployee("Non Employee", "NON_EMPLOYEE");

  final String value;

  final String requesterTypeCode;

  const TripFor(this.value, this.requesterTypeCode);

  static TripFor fromString(String value) {
    return TripFor.values.firstWhere(
      (e) => e.value.toLowerCase() == value.toLowerCase(),
      orElse: () => TripFor.Self,
    );
  }

  static TripFor? fromRequesterTypeCode(String code) {
    for (final tripFor in TripFor.values) {
      if (tripFor.requesterTypeCode == code) return tripFor;
    }
    return null;
  }
}

class TripCreateRequest {
  final String? tripName;
  final String? tripDescription;
  final TripFor? tripFor;
  final String? tripPurpose;
  final TripDetail? tripDetails;

  TripCreateRequest({
    this.tripName,
    this.tripDescription,
    this.tripFor,
    this.tripPurpose,
    this.tripDetails,
  });

  TripCreateRequest copyWith({
    String? tripName,
    String? tripDescription,
    TripFor? tripFor,
    String? tripPurpose,
    TripDetail? tripDetail,
  }) {
    return TripCreateRequest(
      tripName: tripName ?? this.tripName,
      tripDescription: tripDescription ?? this.tripDescription,
      tripFor: tripFor ?? this.tripFor,
      tripPurpose: tripPurpose ?? this.tripPurpose,
      tripDetails: tripDetail ?? tripDetails,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (tripName != null) {
      result.addAll({'tripName': tripName});
    }
    if (tripDescription != null) {
      result.addAll({'tripDescription': tripDescription});
    }
    if (tripFor != null) {
      result.addAll({'tripFor': tripFor!.value});
    }
    if (tripPurpose != null) {
      result.addAll({'tripPurpose': tripPurpose});
    }
    if (tripDetails != null) {
      result.addAll({'tripDetails': tripDetails!.toMap()});
    }

    return result;
  }

  factory TripCreateRequest.fromMap(Map<String, dynamic> map) {
    return TripCreateRequest(
      tripName: map['tripName'],
      tripDescription: map['tripDescription'],
      tripFor:
          map['tripFor'] != null ? TripFor.fromString(map['tripFor']) : null,
      tripPurpose: map['tripPurpose'],
      tripDetails: map['tripDetail'] != null
          ? TripDetail.fromMap(map['tripDetail'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TripCreateRequest.fromJson(String source) =>
      TripCreateRequest.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TripCreateRequest(tripName: $tripName, tripDescription: $tripDescription, tripFor: $tripFor, tripPurpose: $tripPurpose, tripDetail: $tripDetails)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TripCreateRequest &&
        other.tripName == tripName &&
        other.tripDescription == tripDescription &&
        other.tripFor == tripFor &&
        other.tripPurpose == tripPurpose &&
        other.tripDetails == tripDetails;
  }

  @override
  int get hashCode {
    return tripName.hashCode ^
        tripDescription.hashCode ^
        tripFor.hashCode ^
        tripPurpose.hashCode ^
        tripDetails.hashCode;
  }
}
