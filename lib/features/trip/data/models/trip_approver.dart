import 'dart:convert';

class TripApprover {
  final String? approvalReferenceId;
  final int? approvalLevel;
  final String? approverName;
  final String? approverEmail;
  final String? status;
  final String? tripState;
  final String? product;

  TripApprover({
    this.approvalReferenceId,
    this.approvalLevel,
    this.approverName,
    this.approverEmail,
    this.status,
    this.tripState,
    this.product,
  });

  TripApprover copyWith({
    String? approvalReferenceId,
    int? approvalLevel,
    String? approverName,
    String? approverEmail,
    String? status,
    String? tripState,
    String? product,
  }) {
    return TripApprover(
      approvalReferenceId: approvalReferenceId ?? this.approvalReferenceId,
      approvalLevel: approvalLevel ?? this.approvalLevel,
      approverName: approverName ?? this.approverName,
      approverEmail: approverEmail ?? this.approverEmail,
      status: status ?? this.status,
      tripState: tripState ?? this.tripState,
      product: product ?? this.product,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (approvalReferenceId != null) {
      result.addAll({'approvalReferenceId': approvalReferenceId});
    }
    if (approvalLevel != null) {
      result.addAll({'approvalLevel': approvalLevel});
    }
    if (approverName != null) {
      result.addAll({'approverName': approverName});
    }
    if (approverEmail != null) {
      result.addAll({'approverEmail': approverEmail});
    }
    if (status != null) {
      result.addAll({'status': status});
    }
    if (tripState != null) {
      result.addAll({'tripState': tripState});
    }
    if (product != null) {
      result.addAll({'product': product});
    }

    return result;
  }

  factory TripApprover.fromMap(Map<String, dynamic> map) {
    return TripApprover(
      approvalReferenceId: map['approvalReferenceId'],
      approvalLevel: int.tryParse(map['approvalLevel']?.toString() ?? ''),
      approverName: map['approverName'],
      approverEmail: map['approverEmail'],
      status: map['status'],
      tripState: map['tripState'],
      product: map['product'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TripApprover.fromJson(String source) =>
      TripApprover.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TripApprover(approvalReferenceId: $approvalReferenceId, approvalLevel: $approvalLevel, approverName: $approverName, approverEmail: $approverEmail, status: $status, tripState: $tripState, product: $product)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TripApprover &&
        other.approvalReferenceId == approvalReferenceId &&
        other.approvalLevel == approvalLevel &&
        other.approverName == approverName &&
        other.approverEmail == approverEmail &&
        other.status == status &&
        other.tripState == tripState &&
        other.product == product;
  }

  @override
  int get hashCode {
    return approvalReferenceId.hashCode ^
        approvalLevel.hashCode ^
        approverName.hashCode ^
        approverEmail.hashCode ^
        status.hashCode ^
        tripState.hashCode ^
        product.hashCode;
  }
}
