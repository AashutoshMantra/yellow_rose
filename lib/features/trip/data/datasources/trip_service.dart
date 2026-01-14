import 'dart:convert';
import 'dart:developer';

import 'package:yellow_rose/core/app_config.dart';
import 'package:yellow_rose/core/utils/dio_client.dart';
import 'package:yellow_rose/dependncy_injection.dart';
import 'package:yellow_rose/features/trip/data/models/trip_approval_request.dart';
import 'package:yellow_rose/features/trip/data/models/trip_approval_response.dart';
import 'package:yellow_rose/features/trip/data/models/trip_create_request.dart';
import 'package:yellow_rose/features/trip/data/models/trip_response.dart';

abstract class TripService {
  Future<TripResponse> createTrip(TripCreateRequest request);
  Future<List<TripResponse>> getTrips(String userId);
  Future<TripResponse> getTripById(String tripId);
  Future<void> addToTrip(String orderId);
  Future<void> sendTripForApproval(String tripId);
  Future<List<TripResponse>> getMyTeamTrip(String userId);
  Future<void> approveDenyTrip(TripApprovalRequest request);
  Future<TripApprovalResponse> getTripApprovalStatus(String tripUid);
  Future<Map<String, String>> cancelTrip(List<String> tripItemList);
}

class TripServiceImpl implements TripService {
  final _dioClient = getIt<DioClient>();

  @override
  Future<TripResponse> createTrip(TripCreateRequest request) async {
    var response = await _dioClient.post(
        "${AppConfig.instance.apiBaseUrl}/trips/save",
        data: request.toMap());
    log(jsonEncode(request.toMap()));

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
  Future<void> addToTrip(String orderId) async {
    await _dioClient.post(
      "${AppConfig.instance.apiBaseUrl}/tripapproval/submit/$orderId",
    );
  }

  @override
  Future<void> sendTripForApproval(String tripId) async {
    await _dioClient.post(
      "${AppConfig.instance.apiBaseUrl}/tripapproval/save",
      data: {"tripUid": tripId},
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
    await _dioClient.post(
      "${AppConfig.instance.apiBaseUrl}/external/app/air/update-status-web",
      data: request.toMap(),
    );
  }

  @override
  Future<TripApprovalResponse> getTripApprovalStatus(String tripUid) async {
    var response = await _dioClient.get(
      '${AppConfig.instance.apiBaseUrl}/tripapproval/getByApprovalId/$tripUid',
    );
    return TripApprovalResponse.fromMap(response.data);
  }

  @override
  Future<Map<String, String>> cancelTrip(List<String> tripItemList) async {
    var response = await _dioClient.post(
        "${AppConfig.instance.apiBaseUrl}/trips/canceltrip",
        data: {"tripAirItemIdList": tripItemList});

    return Map<String, String>.from(response.data);
  }
}
