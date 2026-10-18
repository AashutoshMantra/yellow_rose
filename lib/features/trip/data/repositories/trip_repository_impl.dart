import 'package:yellow_rose/dependncy_injection.dart';
import 'package:yellow_rose/features/trip/data/datasources/trip_service.dart';
import 'package:yellow_rose/features/trip/data/models/trip_approval_request.dart';
import 'package:yellow_rose/features/trip/data/models/trip_approval_response.dart';
import 'package:yellow_rose/features/trip/data/models/trip_approver.dart';
import 'package:yellow_rose/features/trip/data/models/trip_create_request.dart';
import 'package:yellow_rose/features/trip/data/models/trip_response.dart';
import 'package:yellow_rose/features/trip/data/models/trip_rm_tag.dart';
import 'package:yellow_rose/features/trip/domain/repositories/trip_repository.dart';

class TripRepositoryImpl implements TripRepository {
  final _tripService = getIt<TripService>();

  @override
  Future<TripResponse> createTrip(TripCreateRequest request) async {
    return await _tripService.createTrip(request);
  }

  @override
  Future<List<TripResponse>> getTrips(String userId) async {
    return await _tripService.getTrips(userId);
  }

  @override
  Future<TripResponse> getTripById(String tripId) async {
    return await _tripService.getTripById(tripId);
  }

  @override
  Future<void> addToTrip(String orderId, {List<String>? approverIds}) async {
    return await _tripService.addToTrip(orderId, approverIds: approverIds);
  }

  @override
  Future<void> sendTripForApproval(String tripId, {String? notes}) async {
    return await _tripService.sendTripForApproval(tripId, notes: notes);
  }

  @override
  Future<List<TripResponse>> getMyTeamTrip(String userId) {
    return _tripService.getMyTeamTrip(userId);
  }

  @override
  Future<void> approveDenyTrip(TripApprovalRequest request) async {
    return await _tripService.approveDenyTrip(request);
  }

  @override
  Future<TripApprovalResponse> getTripApprovalStatus(String tripUid) async {
    return await _tripService.getTripApprovalStatus(tripUid);
  }

  @override
  Future<List<TripApprover>> getTripApprovers(String tripUid) async {
    return await _tripService.getTripApprovers(tripUid);
  }

  @override
  Future<List<TripRmTag>> getRmTags(String userId) async {
    return await _tripService.getRmTags(userId);
  }

  @override
  Future<Map<String, String>> cancelTrip(List<String> tripItemList) {
   return _tripService.cancelTrip(tripItemList);
  }
}
