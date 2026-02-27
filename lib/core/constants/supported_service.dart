enum SupportedService {
  Flights,
  Hotels,
  Cabs,
  Buses,
  Insurance,
  ;

  String getImagePath() {
    switch (this) {
      case Flights:
        return "air";
      case Hotels:
        return "hotel";
      case Cabs:
        return "cab";
      case Buses:
        return "bus";
      case Insurance:
        return "insurance";
    }
  }

  /// The policy code used in corporate policies to enable/disable this service.
  /// Returns `null` if no policy currently controls this service.
  String? get policyCode {
    switch (this) {
      case Flights:
        return 'enable-air';
      case Hotels:
        return 'enable-hotel';
      case Buses:
        return 'enable-bus';
      case Insurance:
        return 'enable-insurance';
      case Cabs:
        return null; // No policy yet
    }
  }

  /// The product identifier used in corporate policies (e.g. "AIR", "HOTEL").
  /// Returns `null` if no policy currently controls this service.
  String? get policyProduct {
    switch (this) {
      case Flights:
        return 'AIR';
      case Hotels:
        return 'HOTEL';
      case Buses:
        return 'BUS';
      case Insurance:
        return 'INSURANCE';
      case Cabs:
        return null; // No policy yet
    }
  }
}
