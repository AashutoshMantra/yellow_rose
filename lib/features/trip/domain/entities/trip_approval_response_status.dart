enum TripApprovalResponseStatus {
  REVIEW,
  APPROVED,
  REJECTED;

  static TripApprovalResponseStatus? fromString(String? status) {
    if (status == null) return null;

    switch (status.toUpperCase()) {
      case 'REVIEW':
      case 'I':
        return TripApprovalResponseStatus.REVIEW;
      case 'APPROVED':
      case 'A':
        return TripApprovalResponseStatus.APPROVED;
      case 'REJECTED':
      case 'D':
        return TripApprovalResponseStatus.REJECTED;
      default:
        return null;
    }
  }

  String toApiString() {
    return name;
  }
}
