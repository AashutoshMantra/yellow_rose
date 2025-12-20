import 'dart:convert';

import 'package:flutter/foundation.dart';

class BusSeatCancellation {
  final List<String>? seatNames;
  final String? orderId;
  final String? cancellationType;
  final String? createdBy;
  BusSeatCancellation({
    this.seatNames,
    this.orderId,
    this.cancellationType,
    this.createdBy,
  });

  BusSeatCancellation copyWith({
    List<String>? seatNames,
    String? orderId,
    String? cancellationType,
    String? createdBy,
  }) {
    return BusSeatCancellation(
      seatNames: seatNames ?? this.seatNames,
      orderId: orderId ?? this.orderId,
      cancellationType: cancellationType ?? this.cancellationType,
      createdBy: createdBy ?? this.createdBy,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(seatNames != null){
      result.addAll({'seatNames': seatNames});
    }
    if(orderId != null){
      result.addAll({'orderId': orderId});
    }
    if(cancellationType != null){
      result.addAll({'cancellationType': cancellationType});
    }
    if(createdBy != null){
      result.addAll({'createdBy': createdBy});
    }
  
    return result;
  }

  factory BusSeatCancellation.fromMap(Map<String, dynamic> map) {
    return BusSeatCancellation(
      seatNames: List<String>.from(map['seatNames']),
      orderId: map['orderId'],
      cancellationType: map['cancellationType'],
      createdBy: map['createdBy'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BusSeatCancellation.fromJson(String source) => BusSeatCancellation.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BusSeatCancellation(seatNames: $seatNames, orderId: $orderId, cancellationType: $cancellationType, createdBy: $createdBy)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is BusSeatCancellation &&
      listEquals(other.seatNames, seatNames) &&
      other.orderId == orderId &&
      other.cancellationType == cancellationType &&
      other.createdBy == createdBy;
  }

  @override
  int get hashCode {
    return seatNames.hashCode ^
      orderId.hashCode ^
      cancellationType.hashCode ^
      createdBy.hashCode;
  }
}
