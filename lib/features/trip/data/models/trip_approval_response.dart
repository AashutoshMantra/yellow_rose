import 'package:yellow_rose/features/trip/domain/entities/trip_approval_response_status.dart';

class TripApprovalResponse {
  final TripApprovalResponseStatus? status;

  TripApprovalResponse({required this.status});

  Map<String, dynamic> toMap() {
    return {
      'status': status?.toApiString(),
    };
  }

  factory TripApprovalResponse.fromMap(Map<String, dynamic> map) {
    return TripApprovalResponse(
      status: TripApprovalResponseStatus.fromString(map['status']),
    );
  }
}
