import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:yellow_rose/features/flight/data/models/booking_class.dart';

class PassengerBookingClasses {
    final List<BookingClass>? passengerBookingClasses;
  PassengerBookingClasses({
    this.passengerBookingClasses,
  });

  PassengerBookingClasses copyWith({
    List<BookingClass>? passengerBookingClasses,
  }) {
    return PassengerBookingClasses(
      passengerBookingClasses: passengerBookingClasses ?? this.passengerBookingClasses,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(passengerBookingClasses != null){
      result.addAll({'passengerBookingClasses': passengerBookingClasses!.map((x) => x?.toMap()).toList()});
    }
  
    return result;
  }

  factory PassengerBookingClasses.fromMap(Map<String, dynamic> map) {
    return PassengerBookingClasses(
      passengerBookingClasses: map['passengerBookingClasses'] != null ? List<BookingClass>.from(map['passengerBookingClasses']?.map((x) => BookingClass.fromMap(x))) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PassengerBookingClasses.fromJson(String source) => PassengerBookingClasses.fromMap(json.decode(source));

  @override
  String toString() => 'PassengerBookingClasses(passengerBookingClasses: $passengerBookingClasses)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is PassengerBookingClasses &&
      listEquals(other.passengerBookingClasses, passengerBookingClasses);
  }

  @override
  int get hashCode => passengerBookingClasses.hashCode;
}
