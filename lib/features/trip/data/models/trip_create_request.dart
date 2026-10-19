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

  String get requestValue => this == TripFor.NonEmployee ? 'Other' : value;

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
  final String? userUid;
  final String? createdBy;
  final String? startDate;
  final String? endDate;
  final TripDetail? tripDetails;

  TripCreateRequest({
    this.tripName,
    this.tripDescription,
    this.tripFor,
    this.tripPurpose,
    this.userUid,
    this.createdBy,
    this.startDate,
    this.endDate,
    this.tripDetails,
  });

  TripCreateRequest copyWith({
    String? tripName,
    String? tripDescription,
    TripFor? tripFor,
    String? tripPurpose,
    String? userUid,
    String? createdBy,
    String? startDate,
    String? endDate,
    TripDetail? tripDetail,
  }) {
    return TripCreateRequest(
      tripName: tripName ?? this.tripName,
      tripDescription: tripDescription ?? this.tripDescription,
      tripFor: tripFor ?? this.tripFor,
      tripPurpose: tripPurpose ?? this.tripPurpose,
      userUid: userUid ?? this.userUid,
      createdBy: createdBy ?? this.createdBy,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
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
      result.addAll({'tripFor': tripFor!.requestValue});
    }
    if (tripPurpose != null) {
      result.addAll({'tripPurpose': tripPurpose});
    }
    if (userUid != null) {
      result.addAll({'userUid': userUid});
    }
    if (createdBy != null) {
      result.addAll({'createdBy': createdBy});
    }
    if (startDate != null) {
      result.addAll({'startDate': startDate});
    }
    if (endDate != null) {
      result.addAll({'endDate': endDate});
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
      userUid: map['userUid'],
      createdBy: map['createdBy'],
      startDate: map['startDate'],
      endDate: map['endDate'],
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
    return 'TripCreateRequest(tripName: $tripName, tripDescription: $tripDescription, tripFor: $tripFor, tripPurpose: $tripPurpose, userUid: $userUid, createdBy: $createdBy, startDate: $startDate, endDate: $endDate, tripDetail: $tripDetails)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TripCreateRequest &&
        other.tripName == tripName &&
        other.tripDescription == tripDescription &&
        other.tripFor == tripFor &&
        other.tripPurpose == tripPurpose &&
        other.userUid == userUid &&
        other.createdBy == createdBy &&
        other.startDate == startDate &&
        other.endDate == endDate &&
        other.tripDetails == tripDetails;
  }

  @override
  int get hashCode {
    return tripName.hashCode ^
        tripDescription.hashCode ^
        tripFor.hashCode ^
        tripPurpose.hashCode ^
        userUid.hashCode ^
        createdBy.hashCode ^
        startDate.hashCode ^
        endDate.hashCode ^
        tripDetails.hashCode;
  }
}
