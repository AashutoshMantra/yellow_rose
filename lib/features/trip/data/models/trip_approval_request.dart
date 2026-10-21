import 'package:yellow_rose/features/trip/domain/entities/trip_approval_status.dart';

class TripApprovalRequest {
  final String approvalNotes;
  final String tripUid;
  final TripApprovalStatus status;
  final int? level;
  final String? userUid;
  final String? approvalId;
  final String? whatsAppCode;
  final String? emailCode;
  final String? product;

  TripApprovalRequest({
    required this.approvalNotes,
    required this.tripUid,
    required this.status,
    this.level,
    this.userUid,
    this.approvalId,
    this.whatsAppCode,
    this.emailCode,
    this.product,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{
      'approvalNotes': approvalNotes,
      'tripUid': tripUid,
      'status': status.code,
    };

    if (level != null) {
      result.addAll({'level': level});
    }
    if (userUid != null) {
      result.addAll({'userUid': userUid});
    }
    if (approvalId != null) {
      result.addAll({'approvalId': approvalId});
    }
    if (whatsAppCode != null) {
      result.addAll({'whatsAppCode': whatsAppCode});
    }
    if (emailCode != null) {
      result.addAll({'emailCode': emailCode});
    }
    if (product != null) {
      result.addAll({'product': product});
    }

    return result;
  }

  factory TripApprovalRequest.fromMap(Map<String, dynamic> map) {
    return TripApprovalRequest(
      approvalNotes: map['approvalNotes'] ?? '',
      tripUid: map['tripUid'] ?? '',
      status: TripApprovalStatus.fromCode(map['status']) ??
          TripApprovalStatus.APPROVE,
      level: map['level']?.toInt(),
      userUid: map['userUid'],
      approvalId: map['approvalId'],
      whatsAppCode: map['whatsAppCode'],
      emailCode: map['emailCode'],
      product: map['product'],
    );
  }
}
