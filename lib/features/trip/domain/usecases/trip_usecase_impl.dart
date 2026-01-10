import 'package:yellow_rose/dependncy_injection.dart';
import 'package:yellow_rose/features/trip/data/models/trip_approval_request.dart';
import 'package:yellow_rose/features/trip/data/models/trip_approval_response.dart';
import 'package:yellow_rose/features/trip/data/models/trip_create_request.dart';
import 'package:yellow_rose/features/trip/data/models/trip_response.dart';
import 'package:yellow_rose/features/trip/domain/repositories/trip_repository.dart';
import 'package:yellow_rose/features/trip/domain/usecases/trip_usecase.dart';

class TripUseCaseImpl implements TripUseCase {
  final _tripRepository = getIt<TripRepository>();

  @override
  Future<TripResponse> createTrip(TripCreateRequest request) async {
    return await _tripRepository.createTrip(request);
  }

  @override
  Future<List<TripResponse>> getTrips(String userId) async {
    return await _tripRepository.getTrips(userId);
  }

  @override
  Future<TripResponse> getTripById(String tripId) async {
    return await _tripRepository.getTripById(tripId);
  }

  @override
  Future<void> addToTrip(String orderId) async {
    return await _tripRepository.addToTrip(orderId);
  }

  @override
  Future<void> sendTripForApproval(String tripId) async {
    return await _tripRepository.sendTripForApproval(tripId);
  }

  @override
  Future<List<TripResponse>> getMyTeamTrip(String userId) {
    return _tripRepository.getMyTeamTrip(userId);
  }

  @override
  Future<void> approveDenyTrip(TripApprovalRequest request) async {
    return await _tripRepository.approveDenyTrip(request);
  }

  @override
  Future<TripApprovalResponse> getTripApprovalStatus(String tripUid) async {
    return await _tripRepository.getTripApprovalStatus(tripUid);
  }

  @override
  Future<Map<String, String>> cancelTrip(List<String> tripItemList) {
    return _tripRepository.cancelTrip(tripItemList);
  }
}
