import 'package:yellow_rose/features/trip/domain/entities/trip_approval_status.dart';

class TripApprovalRequest {
  final String approvalNotes;
  final String tripUid;
  final TripApprovalStatus status;

  TripApprovalRequest({
    required this.approvalNotes,
    required this.tripUid,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'approvalNotes': approvalNotes,
      'tripUid': tripUid,
      'status': status.code,
    };
  }

  factory TripApprovalRequest.fromMap(Map<String, dynamic> map) {
    return TripApprovalRequest(
      approvalNotes: map['approvalNotes'] ?? '',
      tripUid: map['tripUid'] ?? '',
      status: TripApprovalStatus.fromCode(map['status']) ??
          TripApprovalStatus.APPROVE,
    );
  }
}
