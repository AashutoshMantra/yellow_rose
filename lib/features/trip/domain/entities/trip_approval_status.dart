enum TripApprovalStatus {
  APPROVE("A"),
  DENY("D");

  final String code;
  const TripApprovalStatus(this.code);

  static TripApprovalStatus? fromCode(String? code) {
    for (TripApprovalStatus status in values) {
      if (code != null && status.code.toUpperCase() == code.toUpperCase()) {
        return status;
      }
    }
    return null;
  }
}
