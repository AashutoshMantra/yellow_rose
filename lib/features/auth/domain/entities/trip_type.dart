import 'package:yellow_rose/features/auth/data/models/policy/approval_workflow_request.dart';

enum TripType { NoTrip, PreBooking, PostBooking }

extension GetTripType on ApprovalWorkflow {
  TripType get tripType {
    if (policyApplied == null || policyApplied!.isEmpty) {
      return TripType.NoTrip;
    }
    if (policyApplied == "1") {
      return TripType.PreBooking;
    } else {
      return TripType.PostBooking;
    }
  }
}
