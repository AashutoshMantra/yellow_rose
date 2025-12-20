enum BusBookingStatus {
  newBooking('NEW', 'N', 'New'),
  pendingTicket('PENDINGTICKET', 'T', ''),
  initiated('INITIATED', 'I', 'Initiated'),
  blocked('BLOCKED', 'BL', 'Blocked'),
  aborted('ABORTED', 'A', 'Aborted'),
  toCancel('TO_CANCEL', 'TC', 'To Cancel'),
  cancelled('CANCELLED', 'C', 'Cancelled'),
  cancellationRequested(
      'CANCELLATIONREQUESTED', 'CR', 'Cancellation Requested'),
  rescheduled('RESCHEDULED', 'R', 'Rescheduled'),
  rescheduledRequested('RESCHEDULED', 'RQ', 'Rescheduled Requested'),
  partiallyRescheduled('PARTIALLYRESCHEDULED', 'X', 'Partially Rescheduled'),
  partiallyCancelled('PARTIALLYCANCELLED', 'P', 'Partially Cancelled'),
  booked('BOOKED', 'B', 'Booked'),
  unconfirmed('UNCONFIRMED', 'U', 'Unconfirmed'),
  failed('FAILED', 'F', 'Failed'),
  error('ERROR', 'E', 'Error');

  final String code;
  final String shortCode;
  final String displayText;

  const BusBookingStatus(this.code, this.shortCode, this.displayText);

  /// Get enum from code string
  static BusBookingStatus? fromCode(String? code) {
    if (code == null) return null;
    try {
      return BusBookingStatus.values.firstWhere(
        (status) => status.code.toUpperCase() == code.toUpperCase(),
      );
    } catch (e) {
      return null;
    }
  }

  /// Get enum from short code string
  static BusBookingStatus? fromShortCode(String? shortCode) {
    if (shortCode == null) return null;
    try {
      return BusBookingStatus.values.firstWhere(
        (status) => status.shortCode.toUpperCase() == shortCode.toUpperCase(),
      );
    } catch (e) {
      return null;
    }
  }

  bool get isCancelled =>
      this == BusBookingStatus.cancelled ||
      this == BusBookingStatus.cancellationRequested ||
      this == BusBookingStatus.toCancel;

  bool get isActive =>
      this == BusBookingStatus.booked ||
      this == BusBookingStatus.blocked ||
      this == BusBookingStatus.initiated;

  bool get canModify =>
      this == BusBookingStatus.booked ||
      this == BusBookingStatus.blocked ||
      this == BusBookingStatus.initiated ||
      this == BusBookingStatus.partiallyCancelled ||
      this == BusBookingStatus.unconfirmed;

  bool get isInProgress =>
      this == BusBookingStatus.initiated ||
      this == BusBookingStatus.blocked ||
      this == BusBookingStatus.pendingTicket;

  /// Check if booking failed
  bool get isFailed =>
      this == BusBookingStatus.failed ||
      this == BusBookingStatus.aborted ||
      this == BusBookingStatus.error;
}
