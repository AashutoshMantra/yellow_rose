import 'package:yellow_rose/features/trip/data/models/trip_approval_request.dart';
import 'package:yellow_rose/features/trip/data/models/trip_approval_response.dart';
import 'package:yellow_rose/features/trip/data/models/trip_approver.dart';
import 'package:yellow_rose/features/trip/data/models/trip_create_request.dart';
import 'package:yellow_rose/features/trip/data/models/trip_response.dart';
import 'package:yellow_rose/features/trip/data/models/trip_rm_tag.dart';

abstract interface class TripRepository {
  Future<TripResponse> createTrip(TripCreateRequest request);
  Future<List<TripResponse>> getTrips(String userId);
  Future<TripResponse> getTripById(String tripId);
  Future<void> addToTrip(String orderId, {List<String>? approverIds});
  Future<void> sendTripForApproval(String tripId, {String? notes});
  Future<List<TripResponse>> getMyTeamTrip(String userId);
  Future<void> approveDenyTrip(TripApprovalRequest request);
  Future<TripApprovalResponse> getTripApprovalStatus(String tripUid);
  Future<List<TripApprover>> getTripApprovers(String tripUid);
  Future<List<TripRmTag>> getRmTags(String userId);
  Future<Map<String, String>> cancelTrip(List<String> tripItemList);
}
