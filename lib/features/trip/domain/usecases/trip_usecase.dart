import 'package:yellow_rose/features/trip/data/models/trip_create_request.dart';
import 'package:yellow_rose/features/trip/data/models/trip_response.dart';

abstract interface class TripUseCase {
  Future<TripResponse> createTrip(TripCreateRequest request);
  Future<List<TripResponse>> getTrips(String userId);
  Future<TripResponse> getTripById(String tripId);
  Future<void> addToTrip(String orderId);
  Future<void> sendTripForApproval(String tripId);
}
