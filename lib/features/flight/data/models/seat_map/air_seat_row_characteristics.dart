enum AirSeatRowCharacteristics {
  EXIT_ROW("Exit Row"),

  MAIN_DECK_ROW("Main Deck Row"),

  UPPER_DECK_ROW("Upper Deck Row"),

  LOWER_DECK_ROW("Lower Deck Row"),

  RESTRICTED_ROW("Restricted Row"),

  NO_ROW("No Row"),
  OVER_WING("Over Wing"),

  NON_SMOKING("Non Smoking"),

  TOILET("Toilet");

  final String rowAttrString;

  const AirSeatRowCharacteristics(this.rowAttrString);
}
