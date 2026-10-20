import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:yellow_rose/features/flight/data/models/erro_code_handler.dart';
import 'package:yellow_rose/features/hotel/data/models/order/hummingbird/hummingbird_booking_room_response.dart';

class HummingbirdBookingResponse {
  final String? requestId;
  final List<HummingbirdBookingRoomResponse>? rooms;
  final ErrorCodeHandler? errorData;
  HummingbirdBookingResponse({
    this.requestId,
    this.rooms,
    this.errorData,
  });

  HummingbirdBookingResponse copyWith({
    String? requestId,
    List<HummingbirdBookingRoomResponse>? rooms,
    ErrorCodeHandler? errorData,
  }) {
    return HummingbirdBookingResponse(
      requestId: requestId ?? this.requestId,
      rooms: rooms ?? this.rooms,
      errorData: errorData ?? this.errorData,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (requestId != null) {
      result.addAll({'requestId': requestId});
    }
    if (rooms != null) {
      result.addAll({'rooms': rooms!.map((x) => x.toMap()).toList()});
    }
    if (errorData != null) {
      result.addAll({'errorData': errorData!.toMap()});
    }

    return result;
  }

  factory HummingbirdBookingResponse.fromMap(Map<String, dynamic> map) {
    return HummingbirdBookingResponse(
      requestId: map['requestId'],
      rooms: map['rooms'] != null
          ? List<HummingbirdBookingRoomResponse>.from(map['rooms']
              ?.map((x) => HummingbirdBookingRoomResponse.fromMap(x)))
          : null,
      errorData: map['errorData'] != null
          ? ErrorCodeHandler.fromMap(map['errorData'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory HummingbirdBookingResponse.fromJson(String source) =>
      HummingbirdBookingResponse.fromMap(json.decode(source));

  @override
  String toString() =>
      'HummingbirdBookingResponse(requestId: $requestId, rooms: $rooms, errorData: $errorData)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HummingbirdBookingResponse &&
        other.requestId == requestId &&
        listEquals(other.rooms, rooms) &&
        other.errorData == errorData;
  }

  @override
  int get hashCode => requestId.hashCode ^ rooms.hashCode ^ errorData.hashCode;
}
