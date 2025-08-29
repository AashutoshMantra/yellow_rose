import 'dart:convert';

import 'package:flutter/foundation.dart';

class HotelRoomRequest {
  final int adults;
  final List<int> childrenAges;
  HotelRoomRequest({
    required this.adults,
    required this.childrenAges,
  });

  HotelRoomRequest copyWith({
    int? adults,
    List<int>? childrenAges,
  }) {
    return HotelRoomRequest(
      adults: adults ?? this.adults,
      childrenAges: childrenAges ?? this.childrenAges,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'adults': adults});
    result.addAll({'childrenAges': childrenAges});

    return result;
  }

  factory HotelRoomRequest.fromMap(Map<String, dynamic> map) {
    return HotelRoomRequest(
      adults: map['adults']?.toInt() ?? 0,
      childrenAges: List<int>.from(map['childrenAges']),
    );
  }

  String toJson() => json.encode(toMap());

  factory HotelRoomRequest.fromJson(String source) =>
      HotelRoomRequest.fromMap(json.decode(source));

  @override
  String toString() =>
      'HotelRoomRequest(adults: $adults, childrenAges: $childrenAges)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HotelRoomRequest &&
        other.adults == adults &&
        listEquals(other.childrenAges, childrenAges);
  }

  @override
  int get hashCode => adults.hashCode ^ childrenAges.hashCode;
}
