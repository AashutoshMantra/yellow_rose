import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:yellow_rose/features/trip/data/models/trip_guest.dart';
import 'package:yellow_rose/features/trip/data/models/trip_rm_tag.dart';

class TripDetail {
  final List<String>? onBehalf;
  final List<TripGuest>? otherList;
  final String? requestFor;
  final String? billingEntity;
  final String? ptcNptcType;
  final List<TripRmTag>? rmTags;
  final String? rmApprovalUpload;
  final String? document;
  final String? cabHire;
  final String? hotelRequired;
  final bool? pointerEvents;
  final String? userBookingContext;
  final String? startDate;
  final String? endDate;

  TripDetail({
    this.onBehalf,
    this.otherList,
    this.requestFor,
    this.billingEntity,
    this.ptcNptcType,
    this.rmTags,
    this.rmApprovalUpload,
    this.document,
    this.cabHire,
    this.hotelRequired,
    this.pointerEvents,
    this.userBookingContext,
    this.startDate,
    this.endDate,
  });

  TripDetail copyWith({
    List<String>? onBehalf,
    List<TripGuest>? otherList,
    String? requestFor,
    String? billingEntity,
    String? ptcNptcType,
    List<TripRmTag>? rmTags,
    String? rmApprovalUpload,
    String? document,
    String? cabHire,
    String? hotelRequired,
    bool? pointerEvents,
    String? userBookingContext,
    String? startDate,
    String? endDate,
  }) {
    return TripDetail(
      onBehalf: onBehalf ?? this.onBehalf,
      otherList: otherList ?? this.otherList,
      requestFor: requestFor ?? this.requestFor,
      billingEntity: billingEntity ?? this.billingEntity,
      ptcNptcType: ptcNptcType ?? this.ptcNptcType,
      rmTags: rmTags ?? this.rmTags,
      rmApprovalUpload: rmApprovalUpload ?? this.rmApprovalUpload,
      document: document ?? this.document,
      cabHire: cabHire ?? this.cabHire,
      hotelRequired: hotelRequired ?? this.hotelRequired,
      pointerEvents: pointerEvents ?? this.pointerEvents,
      userBookingContext: userBookingContext ?? this.userBookingContext,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (onBehalf != null) {
      result.addAll({'onBehalf': onBehalf});
    }
    if (otherList != null) {
      result.addAll({'otherList': otherList!.map((x) => x.toMap()).toList()});
    }
    if (requestFor != null) {
      result.addAll({'requestFor': requestFor});
    }
    if (billingEntity != null) {
      result.addAll({'billingEntity': billingEntity});
    }
    if (ptcNptcType != null) {
      result.addAll({'ptcNptcType': ptcNptcType});
    }
    if (rmTags != null) {
      result.addAll({'rmTags': rmTags!.map((x) => x.toRequestMap()).toList()});
    }
    if (rmApprovalUpload != null) {
      result.addAll({'rmApprovalUpload': rmApprovalUpload});
    }
    if (document != null) {
      result.addAll({'document': document});
    }
    if (cabHire != null) {
      result.addAll({'cabHire': cabHire});
    }
    if (hotelRequired != null) {
      result.addAll({'hotelRequired': hotelRequired});
    }
    if (pointerEvents != null) {
      result.addAll({'pointerEvents': pointerEvents});
    }
    if (userBookingContext != null) {
      result.addAll({'userBookingContext': userBookingContext});
    }
    if (startDate != null) {
      result.addAll({'startDate': startDate});
    }
    if (endDate != null) {
      result.addAll({'endDate': endDate});
    }

    return result;
  }

  factory TripDetail.fromMap(Map<String, dynamic> map) {
    final billingEntity = map['billingEntity'];
    return TripDetail(
      onBehalf: map['onBehalf'] != null
          ? List<String>.from(map['onBehalf'])
          : null,
      otherList: map['otherList'] != null
          ? List<TripGuest>.from(
              map['otherList']?.map((x) => TripGuest.fromMap(x)))
          : null,
      requestFor: map['requestFor'],
      billingEntity: billingEntity is Map
          ? billingEntity['entityRefId']?.toString()
          : billingEntity?.toString(),
      ptcNptcType: map['ptcNptcType'],
      rmTags: map['rmTags'] != null
          ? List<TripRmTag>.from(map['rmTags']?.map((x) => TripRmTag.fromMap(x)))
          : null,
      rmApprovalUpload: map['rmApprovalUpload'],
      document: map['document'],
      cabHire: map['cabHire']?.toString(),
      hotelRequired: map['hotelRequired']?.toString(),
      pointerEvents: map['pointerEvents'],
      userBookingContext: map['userBookingContext'],
      startDate: map['startDate']?.toString(),
      endDate: map['endDate']?.toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory TripDetail.fromJson(String source) =>
      TripDetail.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TripDetail(onBehalf: $onBehalf, otherList: $otherList, requestFor: $requestFor, billingEntity: $billingEntity, ptcNptcType: $ptcNptcType, rmTags: $rmTags, rmApprovalUpload: $rmApprovalUpload, document: $document, cabHire: $cabHire, hotelRequired: $hotelRequired, pointerEvents: $pointerEvents, userBookingContext: $userBookingContext, startDate: $startDate, endDate: $endDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TripDetail &&
        listEquals(other.onBehalf, onBehalf) &&
        listEquals(other.otherList, otherList) &&
        other.requestFor == requestFor &&
        other.billingEntity == billingEntity &&
        other.ptcNptcType == ptcNptcType &&
        listEquals(other.rmTags, rmTags) &&
        other.rmApprovalUpload == rmApprovalUpload &&
        other.document == document &&
        other.cabHire == cabHire &&
        other.hotelRequired == hotelRequired &&
        other.pointerEvents == pointerEvents &&
        other.userBookingContext == userBookingContext &&
        other.startDate == startDate &&
        other.endDate == endDate;
  }

  @override
  int get hashCode {
    return onBehalf.hashCode ^
        otherList.hashCode ^
        requestFor.hashCode ^
        billingEntity.hashCode ^
        ptcNptcType.hashCode ^
        rmTags.hashCode ^
        rmApprovalUpload.hashCode ^
        document.hashCode ^
        cabHire.hashCode ^
        hotelRequired.hashCode ^
        pointerEvents.hashCode ^
        userBookingContext.hashCode ^
        startDate.hashCode ^
        endDate.hashCode;
  }
}
