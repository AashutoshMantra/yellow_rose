enum TripStatusEnum {
  SELFAPPROVED("SELF APPROVED", "Y", "Self Approved"),
  PENDING("PENDING", "P", "Pending"),
  APPROVED("APPROVED", "A", "All Itinerary Approved"),
  DECLINED("DECLINED", "D", "Cancelled"),
  APPROVALINITIATED("APPROVAL INITIATED", "I", "Approval Initiated"),
  PARTIALLYAPPROVED("PARTIALLY APPROVED", "P", "Itinerary Partially Approved"),
  SENDFORRECONSIDERATION(
      "SEND FOR RECONSIDERATION", "S", "Send For Consideration"),
  NEW("NEW", "N", "Selected Itinerary Not Yet Booked"),
  TIMEOUT("TIMEOUT", "T", "Timeout"),
  CANCEL("CANCEL", "D", "Cancelled"),
  PAID("PAID", "O", "Paid"),
  COMPLETE("COMPLETE", "C", "Trip Completed"),
  SUBMITTED("SUBMITTED", "R", "Itinerary Submitted For Approval"),
  PARTIALLYBOOKED("PARTIALLY BOOKED", "Z", "Itinerary Partially Booked"),
  BOOKED("BOOKED", "B", "Itinerary Booked"),
  FAILED("FAILED", "F", "Itinerary Booking Failed"),
  DRAFT("DRAFT", "G", "Drafted"),
  PARTIALCANCELLED("PARTIAL CANCELLED", "X", "Itinerary Partially Cancelled"),
  FAVOURITE("FAVOURITE", "Y", "Favourite"),

  PENDINGAIR("PENDING AIR", "Q", "Flight Pending Ticketing"),
  PENDINGHOTEL("PENDING HOTEL", "H", "Hotel Pending Confirmation"),
  TOTALPENDING("TOTAL PENDING", "W", "Both Air & Hotel Pending"),
  AIRFAILED("AIR FAILED", "V", "Flight Failed"),
  HOTELFAILED("HOTEL FAILED", "U", "Hotel Failed");

  final String value;
  final String code;
  final String description;
  const TripStatusEnum(this.value, this.code, this.description);

  static TripStatusEnum? fromCode(String? code) {
    for (TripStatusEnum status in values) {
      if (code != null && status.code.toLowerCase() == code.toLowerCase()) {
        return status;
      }
    }
    return null;
  }

  static TripStatusEnum fromDescription(String description) {
    for (TripStatusEnum status in values) {
      if (status.description.toLowerCase() == description.toLowerCase()) {
        return status;
      }
    }
    throw ArgumentError("Invalid description: $description");
  }
}
