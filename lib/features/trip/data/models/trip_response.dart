import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:yellow_rose/features/trip/data/models/trip_detail.dart';
import 'package:yellow_rose/features/trip/data/models/trip_item.dart';
import 'package:yellow_rose/features/trip/data/models/trip_status_enum.dart';

class TripResponse {
  final String? statuss;
  final String? message;
  final String? tripUid;
  final int? tripId;
  final String? userUid;
  final String? tripFor;
  final String? tripPurpose;
  final String? tripDescription;
  final String? tripName;
  final double? totalAirCost;
  final double? totalHotelCost;
  final TripStatusEnum? status;
  final String? statusDesc;
  final String? approvalLevel1;
  final String? approvalLevel1Email;
  final String? approvalLevel1EmpCode;
  final String? approvalLevel2;
  final String? approvalLevel2Email;
  final String? approvalLevel2EmpCode;
  final String? approvalLevel3;
  final String? approvalLevel3Email;
  final String? approvalLevel3EmpCode;
  final String? approvalLevel4;
  final String? approvalLevel4Email;
  final String? approvalLevel4EmpCode;
  final String? approvalReferenceId;
  final String? policyRuleId;
  final String? policyRuleApplied;
  final String? approvalWorkFlowId;
  final String? createdBy;
  final DateTime? genTs;
  final TripDetail? tripDetails;
  final List<TripAirItem>? tripItemList;
  TripResponse({
    this.statuss,
    this.message,
    this.tripUid,
    this.tripId,
    this.userUid,
    this.tripFor,
    this.tripPurpose,
    this.tripDescription,
    this.tripName,
    this.totalAirCost,
    this.totalHotelCost,
    this.status,
    this.statusDesc,
    this.approvalLevel1,
    this.approvalLevel1Email,
    this.approvalLevel1EmpCode,
    this.approvalLevel2,
    this.approvalLevel2Email,
    this.approvalLevel2EmpCode,
    this.approvalLevel3,
    this.approvalLevel3Email,
    this.approvalLevel3EmpCode,
    this.approvalLevel4,
    this.approvalLevel4Email,
    this.approvalLevel4EmpCode,
    this.approvalReferenceId,
    this.policyRuleId,
    this.policyRuleApplied,
    this.approvalWorkFlowId,
    this.createdBy,
    this.genTs,
    this.tripDetails,
    this.tripItemList,
  });

  TripResponse copyWith({
    String? statuss,
    String? message,
    String? tripUid,
    int? tripId,
    String? userUid,
    String? tripFor,
    String? tripPurpose,
    String? tripDescription,
    String? tripName,
    double? totalAirCost,
    double? totalHotelCost,
    TripStatusEnum? status,
    String? statusDesc,
    String? approvalLevel1,
    String? approvalLevel1Email,
    String? approvalLevel1EmpCode,
    String? approvalLevel2,
    String? approvalLevel2Email,
    String? approvalLevel2EmpCode,
    String? approvalLevel3,
    String? approvalLevel3Email,
    String? approvalLevel3EmpCode,
    String? approvalLevel4,
    String? approvalLevel4Email,
    String? approvalLevel4EmpCode,
    String? approvalReferenceId,
    String? policyRuleId,
    String? policyRuleApplied,
    String? approvalWorkFlowId,
    String? createdBy,
    DateTime? genTs,
    TripDetail? tripDetail,
    List<TripAirItem>? tripItemList,
  }) {
    return TripResponse(
      statuss: statuss ?? this.statuss,
      message: message ?? this.message,
      tripUid: tripUid ?? this.tripUid,
      tripId: tripId ?? this.tripId,
      userUid: userUid ?? this.userUid,
      tripFor: tripFor ?? this.tripFor,
      tripPurpose: tripPurpose ?? this.tripPurpose,
      tripDescription: tripDescription ?? this.tripDescription,
      tripName: tripName ?? this.tripName,
      totalAirCost: totalAirCost ?? this.totalAirCost,
      totalHotelCost: totalHotelCost ?? this.totalHotelCost,
      status: status ?? this.status,
      statusDesc: statusDesc ?? this.statusDesc,
      approvalLevel1: approvalLevel1 ?? this.approvalLevel1,
      approvalLevel1Email: approvalLevel1Email ?? this.approvalLevel1Email,
      approvalLevel1EmpCode:
          approvalLevel1EmpCode ?? this.approvalLevel1EmpCode,
      approvalLevel2: approvalLevel2 ?? this.approvalLevel2,
      approvalLevel2Email: approvalLevel2Email ?? this.approvalLevel2Email,
      approvalLevel2EmpCode:
          approvalLevel2EmpCode ?? this.approvalLevel2EmpCode,
      approvalLevel3: approvalLevel3 ?? this.approvalLevel3,
      approvalLevel3Email: approvalLevel3Email ?? this.approvalLevel3Email,
      approvalLevel3EmpCode:
          approvalLevel3EmpCode ?? this.approvalLevel3EmpCode,
      approvalLevel4: approvalLevel4 ?? this.approvalLevel4,
      approvalLevel4Email: approvalLevel4Email ?? this.approvalLevel4Email,
      approvalLevel4EmpCode:
          approvalLevel4EmpCode ?? this.approvalLevel4EmpCode,
      approvalReferenceId: approvalReferenceId ?? this.approvalReferenceId,
      policyRuleId: policyRuleId ?? this.policyRuleId,
      policyRuleApplied: policyRuleApplied ?? this.policyRuleApplied,
      approvalWorkFlowId: approvalWorkFlowId ?? this.approvalWorkFlowId,
      createdBy: createdBy ?? this.createdBy,
      genTs: genTs ?? this.genTs,
      tripDetails: tripDetail ?? tripDetails,
      tripItemList: tripItemList ?? this.tripItemList,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (statuss != null) {
      result.addAll({'statuss': statuss});
    }
    if (message != null) {
      result.addAll({'message': message});
    }
    if (tripUid != null) {
      result.addAll({'tripUid': tripUid});
    }
    if (tripId != null) {
      result.addAll({'tripId': tripId});
    }
    if (userUid != null) {
      result.addAll({'userUid': userUid});
    }
    if (tripFor != null) {
      result.addAll({'tripFor': tripFor});
    }
    if (tripPurpose != null) {
      result.addAll({'tripPurpose': tripPurpose});
    }
    if (tripDescription != null) {
      result.addAll({'tripDescription': tripDescription});
    }
    if (tripName != null) {
      result.addAll({'tripName': tripName});
    }
    if (totalAirCost != null) {
      result.addAll({'totalAirCost': totalAirCost});
    }
    if (totalHotelCost != null) {
      result.addAll({'totalHotelCost': totalHotelCost});
    }
    if (status != null) {
      result.addAll({'status': status!.code});
    }
    if (statusDesc != null) {
      result.addAll({'statusDesc': statusDesc});
    }
    if (approvalLevel1 != null) {
      result.addAll({'approvalLevel1': approvalLevel1});
    }
    if (approvalLevel1Email != null) {
      result.addAll({'approvalLevel1Email': approvalLevel1Email});
    }
    if (approvalLevel1EmpCode != null) {
      result.addAll({'approvalLevel1EmpCode': approvalLevel1EmpCode});
    }
    if (approvalLevel2 != null) {
      result.addAll({'approvalLevel2': approvalLevel2});
    }
    if (approvalLevel2Email != null) {
      result.addAll({'approvalLevel2Email': approvalLevel2Email});
    }
    if (approvalLevel2EmpCode != null) {
      result.addAll({'approvalLevel2EmpCode': approvalLevel2EmpCode});
    }
    if (approvalLevel3 != null) {
      result.addAll({'approvalLevel3': approvalLevel3});
    }
    if (approvalLevel3Email != null) {
      result.addAll({'approvalLevel3Email': approvalLevel3Email});
    }
    if (approvalLevel3EmpCode != null) {
      result.addAll({'approvalLevel3EmpCode': approvalLevel3EmpCode});
    }
    if (approvalLevel4 != null) {
      result.addAll({'approvalLevel4': approvalLevel4});
    }
    if (approvalLevel4Email != null) {
      result.addAll({'approvalLevel4Email': approvalLevel4Email});
    }
    if (approvalLevel4EmpCode != null) {
      result.addAll({'approvalLevel4EmpCode': approvalLevel4EmpCode});
    }
    if (approvalReferenceId != null) {
      result.addAll({'approvalReferenceId': approvalReferenceId});
    }
    if (policyRuleId != null) {
      result.addAll({'policyRuleId': policyRuleId});
    }
    if (policyRuleApplied != null) {
      result.addAll({'policyRuleApplied': policyRuleApplied});
    }
    if (approvalWorkFlowId != null) {
      result.addAll({'approvalWorkFlowId': approvalWorkFlowId});
    }
    if (createdBy != null) {
      result.addAll({'createdBy': createdBy});
    }
    if (genTs != null) {
      result.addAll({'genTs': genTs!.millisecondsSinceEpoch});
    }
    if (tripDetails != null) {
      result.addAll({'tripDetails': tripDetails!.toMap()});
    }
    if (tripItemList != null) {
      result.addAll(
          {'tripItemList': tripItemList!.map((x) => x.toMap()).toList()});
    }

    return result;
  }

  factory TripResponse.fromMap(Map<String, dynamic> map) {
    return TripResponse(
      statuss: map['statuss'],
      message: map['message'],
      tripUid: map['tripUid'],
      tripId: map['tripId']?.toInt(),
      userUid: map['userUid'],
      tripFor: map['tripFor'],
      tripPurpose: map['tripPurpose'],
      tripDescription: map['tripDescription'],
      tripName: map['tripName'],
      totalAirCost: map['totalAirCost']?.toDouble(),
      totalHotelCost: map['totalHotelCost']?.toDouble(),
      status:
          map['status'] != null ? TripStatusEnum.fromCode(map['status']) : null,
      statusDesc: map['statusDesc'],
      approvalLevel1: map['approvalLevel1'],
      approvalLevel1Email: map['approvalLevel1Email'],
      approvalLevel1EmpCode: map['approvalLevel1EmpCode'],
      approvalLevel2: map['approvalLevel2'],
      approvalLevel2Email: map['approvalLevel2Email'],
      approvalLevel2EmpCode: map['approvalLevel2EmpCode'],
      approvalLevel3: map['approvalLevel3'],
      approvalLevel3Email: map['approvalLevel3Email'],
      approvalLevel3EmpCode: map['approvalLevel3EmpCode'],
      approvalLevel4: map['approvalLevel4'],
      approvalLevel4Email: map['approvalLevel4Email'],
      approvalLevel4EmpCode: map['approvalLevel4EmpCode'],
      approvalReferenceId: map['approvalReferenceId'],
      policyRuleId: map['policyRuleId'],
      policyRuleApplied: map['policyRuleApplied'],
      approvalWorkFlowId: map['approvalWorkFlowId'],
      createdBy: map['createdBy'],
      genTs: map['genTs'] != null ? DateTime.tryParse(map['genTs']) : null,
      tripDetails: map['tripDetails'] != null
          ? TripDetail.fromMap(map['tripDetails'])
          : null,
      tripItemList: map['tripItemList'] != null
          ? List<TripAirItem>.from(
              map['tripItemList']?.map((x) => TripAirItem.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TripResponse.fromJson(String source) =>
      TripResponse.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TripResponse(statuss: $statuss, message: $message, tripUid: $tripUid, tripId: $tripId, userUid: $userUid, tripFor: $tripFor, tripPurpose: $tripPurpose, tripDescription: $tripDescription, tripName: $tripName, totalAirCost: $totalAirCost, totalHotelCost: $totalHotelCost, status: $status, statusDesc: $statusDesc, approvalLevel1: $approvalLevel1, approvalLevel1Email: $approvalLevel1Email, approvalLevel1EmpCode: $approvalLevel1EmpCode, approvalLevel2: $approvalLevel2, approvalLevel2Email: $approvalLevel2Email, approvalLevel2EmpCode: $approvalLevel2EmpCode, approvalLevel3: $approvalLevel3, approvalLevel3Email: $approvalLevel3Email, approvalLevel3EmpCode: $approvalLevel3EmpCode, approvalLevel4: $approvalLevel4, approvalLevel4Email: $approvalLevel4Email, approvalLevel4EmpCode: $approvalLevel4EmpCode, approvalReferenceId: $approvalReferenceId, policyRuleId: $policyRuleId, policyRuleApplied: $policyRuleApplied, approvalWorkFlowId: $approvalWorkFlowId, createdBy: $createdBy, genTs: $genTs, tripDetail: $tripDetails, tripItemList: $tripItemList)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TripResponse &&
        other.statuss == statuss &&
        other.message == message &&
        other.tripUid == tripUid &&
        other.tripId == tripId &&
        other.userUid == userUid &&
        other.tripFor == tripFor &&
        other.tripPurpose == tripPurpose &&
        other.tripDescription == tripDescription &&
        other.tripName == tripName &&
        other.totalAirCost == totalAirCost &&
        other.totalHotelCost == totalHotelCost &&
        other.status == status &&
        other.statusDesc == statusDesc &&
        other.approvalLevel1 == approvalLevel1 &&
        other.approvalLevel1Email == approvalLevel1Email &&
        other.approvalLevel1EmpCode == approvalLevel1EmpCode &&
        other.approvalLevel2 == approvalLevel2 &&
        other.approvalLevel2Email == approvalLevel2Email &&
        other.approvalLevel2EmpCode == approvalLevel2EmpCode &&
        other.approvalLevel3 == approvalLevel3 &&
        other.approvalLevel3Email == approvalLevel3Email &&
        other.approvalLevel3EmpCode == approvalLevel3EmpCode &&
        other.approvalLevel4 == approvalLevel4 &&
        other.approvalLevel4Email == approvalLevel4Email &&
        other.approvalLevel4EmpCode == approvalLevel4EmpCode &&
        other.approvalReferenceId == approvalReferenceId &&
        other.policyRuleId == policyRuleId &&
        other.policyRuleApplied == policyRuleApplied &&
        other.approvalWorkFlowId == approvalWorkFlowId &&
        other.createdBy == createdBy &&
        other.genTs == genTs &&
        other.tripDetails == tripDetails &&
        listEquals(other.tripItemList, tripItemList);
  }

  @override
  int get hashCode {
    return statuss.hashCode ^
        message.hashCode ^
        tripUid.hashCode ^
        tripId.hashCode ^
        userUid.hashCode ^
        tripFor.hashCode ^
        tripPurpose.hashCode ^
        tripDescription.hashCode ^
        tripName.hashCode ^
        totalAirCost.hashCode ^
        totalHotelCost.hashCode ^
        status.hashCode ^
        statusDesc.hashCode ^
        approvalLevel1.hashCode ^
        approvalLevel1Email.hashCode ^
        approvalLevel1EmpCode.hashCode ^
        approvalLevel2.hashCode ^
        approvalLevel2Email.hashCode ^
        approvalLevel2EmpCode.hashCode ^
        approvalLevel3.hashCode ^
        approvalLevel3Email.hashCode ^
        approvalLevel3EmpCode.hashCode ^
        approvalLevel4.hashCode ^
        approvalLevel4Email.hashCode ^
        approvalLevel4EmpCode.hashCode ^
        approvalReferenceId.hashCode ^
        policyRuleId.hashCode ^
        policyRuleApplied.hashCode ^
        approvalWorkFlowId.hashCode ^
        createdBy.hashCode ^
        genTs.hashCode ^
        tripDetails.hashCode ^
        tripItemList.hashCode;
  }
}
