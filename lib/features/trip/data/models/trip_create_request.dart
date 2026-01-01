import 'dart:convert';

// {
//    "tripName": "fsfhdfsdg",
//   "tripDescription": "fdhfd",
//   "tripFor": "Self",
//   "tripPurpose": "meeting",
// }

class TripCreateRequest {
  final String? tripName;
  final String? tripDescription;
  final String? tripFor;
  final String? tripPurpose;

  TripCreateRequest({
    this.tripName,
    this.tripDescription,
    this.tripFor,
    this.tripPurpose,
  });

  TripCreateRequest copyWith({
    String? tripName,
    String? tripDescription,
    String? tripFor,
    String? tripPurpose,
  }) {
    return TripCreateRequest(
      tripName: tripName ?? this.tripName,
      tripDescription: tripDescription ?? this.tripDescription,
      tripFor: tripFor ?? this.tripFor,
      tripPurpose: tripPurpose ?? this.tripPurpose,
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
      result.addAll({'tripFor': tripFor});
    }
    if (tripPurpose != null) {
      result.addAll({'tripPurpose': tripPurpose});
    }

    return result;
  }

  factory TripCreateRequest.fromMap(Map<String, dynamic> map) {
    return TripCreateRequest(
      tripName: map['tripName'],
      tripDescription: map['tripDescription'],
      tripFor: map['tripFor'],
      tripPurpose: map['tripPurpose'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TripCreateRequest.fromJson(String source) =>
      TripCreateRequest.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TripCreateRequest(tripName: $tripName, tripDescription: $tripDescription, tripFor: $tripFor, tripPurpose: $tripPurpose)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TripCreateRequest &&
        other.tripName == tripName &&
        other.tripDescription == tripDescription &&
        other.tripFor == tripFor &&
        other.tripPurpose == tripPurpose;
  }

  @override
  int get hashCode {
    return tripName.hashCode ^
        tripDescription.hashCode ^
        tripFor.hashCode ^
        tripPurpose.hashCode;
  }
}
