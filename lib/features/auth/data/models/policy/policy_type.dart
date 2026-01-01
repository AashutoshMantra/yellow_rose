enum PolicyTypeEnum {
  DEFAULT_POLICY(0, "Default"),
  NO_APPROVAL_POLICY(1, "No Approval Policy"),
  ITINERARY_APPROVAL_POLICY(2, "Itinerary Approval"),
  CUSTOM_POLICY(3, "Custom Policy"),
  JOBCODE_POLICY(4, "JobCode Policy"),
  SEQUENTIAL_APPROVAL_POLICY(5, "Sequential Approval Policy"),
  PRODUCT_POLICY(6, "Product Policy"),

  AIR_SEARCH_RESULT_UI(7, "Air Search Result ui"),
  AIR_SEARCH_RESULT(8, "Air Search Result"),

  AIR_BOOK(9, "AIR_BOOK"),
  AIR_BILLING(10, "AIR_BILLING"),

  TRIP_MGMT(11, "TRIP_ENABLE");

  const PolicyTypeEnum(this.id, this.dispStr);

  final int id;
  final String dispStr;
}
