import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:yellow_rose/core/app_config.dart';
import 'package:yellow_rose/core/utils/dio_client.dart';
import 'package:yellow_rose/dependncy_injection.dart';
import 'package:yellow_rose/features/trip/data/models/trip_approval_request.dart';
import 'package:yellow_rose/features/trip/data/models/trip_approval_response.dart';
import 'package:yellow_rose/features/trip/data/models/trip_approver.dart';
import 'package:yellow_rose/features/trip/data/models/trip_create_request.dart';
import 'package:yellow_rose/features/trip/data/models/trip_response.dart';
import 'package:yellow_rose/features/trip/data/models/trip_rm_tag.dart';

abstract class TripService {
  Future<TripResponse> createTrip(TripCreateRequest request);
  Future<List<TripResponse>> getTrips(String userId);
  Future<TripResponse> getTripById(String tripId);
  Future<void> addToTrip(String orderId, {List<String>? approverIds});
  Future<void> sendTripForApproval(String tripId, {String? notes});
  Future<List<TripResponse>> getMyTeamTrip(String userId);
  Future<void> approveDenyTrip(TripApprovalRequest request);
  Future<TripApprovalResponse> getTripApprovalStatus(String tripUid);
  Future<List<TripApprover>> getTripApprovers(String tripUid);
  Future<List<TripApprover>> getPendingApprovals(String tripUid);
  Future<List<TripRmTag>> getRmTags(String userId);
  Future<Map<String, String>> cancelTrip(List<String> tripItemList);
}

class TripServiceImpl implements TripService {
  final _dioClient = getIt<DioClient>();

  @override
  Future<TripResponse> createTrip(TripCreateRequest request) async {
    var response = await _dioClient.post(
        "${AppConfig.instance.apiBaseUrl}/trips/save",
        data: request.toMap());
    if (kDebugMode) {
      log(jsonEncode(request.toMap()));
    }
    return TripResponse.fromMap(response.data);
  }

  @override
  Future<List<TripResponse>> getTrips(String userId) async {
    var response = await _dioClient
        .get('${AppConfig.instance.apiBaseUrl}/trips/triplist/$userId');
    var trips = List<TripResponse>.empty(growable: true);
    for (var trip in (response.data as List)) {
      trips.add(TripResponse.fromMap(trip));
    }
    return trips;
  }

  @override
  Future<TripResponse> getTripById(String tripId) async {
    var response =
        await _dioClient.get('${AppConfig.instance.apiBaseUrl}/trips/$tripId');
    return TripResponse.fromMap(response.data);
  }

  @override
  Future<void> addToTrip(String orderId, {List<String>? approverIds}) async {
    await _dioClient.post(
      "${AppConfig.instance.apiBaseUrl}/tripapproval/submit/$orderId",
      data: (approverIds ?? []).isEmpty ? null : {"approverIds": approverIds},
    );
  }

  @override
  Future<void> sendTripForApproval(String tripId, {String? notes}) async {
    await _dioClient.post(
      "${AppConfig.instance.apiBaseUrl}/tripapproval/save",
      data: {
        "tripUid": tripId,
        if (notes != null && notes.isNotEmpty) "notes": notes,
      },
    );
  }

  @override
  Future<List<TripResponse>> getMyTeamTrip(String userId) async {
    var response = await _dioClient.get(
        '${AppConfig.instance.apiBaseUrl}/trips/triplist/approvallevel1/$userId');
    var trips = List<TripResponse>.empty(growable: true);
    for (var trip in (response.data as List)) {
      trips.add(TripResponse.fromMap(trip));
    }
    return trips;
  }

  @override
  Future<void> approveDenyTrip(TripApprovalRequest request) async {
    var response = await _dioClient.post(
      "${AppConfig.instance.apiBaseUrl}/external/app/air/update-status-web",
      data: request.toMap(),
    );
    if (response.data["statuss"]?.toLowerCase() == "failure") {
      throw Exception(
          "Failed to approve/deny trip: ${response.data["message"]}");
    }
  }

  @override
  Future<TripApprovalResponse> getTripApprovalStatus(String tripUid) async {
    var response = await _dioClient.get(
      '${AppConfig.instance.apiBaseUrl}/tripapproval/getByApprovalId/$tripUid',
    );
    return TripApprovalResponse.fromMap(response.data);
  }

  @override
  Future<List<TripApprover>> getTripApprovers(String tripUid) async {
    var response = await _dioClient
        .get('${AppConfig.instance.apiBaseUrl}/tripapproval/get/$tripUid');
    var approvers = List<TripApprover>.empty(growable: true);
    for (var approver in (response.data as List)) {
      approvers.add(TripApprover.fromMap(approver));
    }
    return approvers;
  }

  @override
  Future<List<TripApprover>> getPendingApprovals(String tripUid) async {
    var response = await _dioClient.get(
        '${AppConfig.instance.apiBaseUrl}/tripapproval/approvallist/$tripUid');
    var approvals = List<TripApprover>.empty(growable: true);
    for (var approval in (response.data as List)) {
      approvals.add(TripApprover.fromMap(approval));
    }
    return approvals;
  }

  @override
  Future<List<TripRmTag>> getRmTags(String userId) async {
    var response = await _dioClient.get(
        '${AppConfig.instance.apiBaseUrl}/reporting/tags/AIR/customtag/tag/PAX/$userId');
    var tags = List<TripRmTag>.empty(growable: true);
    for (var tag in (response.data as List)) {
      tags.add(TripRmTag.fromMap(tag));
    }
    return tags;
  }

  @override
  Future<Map<String, String>> cancelTrip(List<String> tripItemList) async {
    var response = await _dioClient.post(
        "${AppConfig.instance.apiBaseUrl}/trips/canceltrip",
        data: {"tripAirItemIdList": tripItemList});

    return Map<String, String>.from(response.data);
  }
}
