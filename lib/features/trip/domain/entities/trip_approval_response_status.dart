enum TripApprovalResponseStatus {
  REVIEW,
  APPROVED,
  REJECTED;

  static TripApprovalResponseStatus? fromString(String? status) {
    if (status == null) return null;

    switch (status.toUpperCase()) {
      case 'REVIEW':
        return TripApprovalResponseStatus.REVIEW;
      case 'APPROVED':
        return TripApprovalResponseStatus.APPROVED;
      case 'REJECTED':
        return TripApprovalResponseStatus.REJECTED;
      default:
        return null;
    }
  }

  String toApiString() {
    return name;
  }
}
