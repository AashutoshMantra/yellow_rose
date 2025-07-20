enum SupportedService {
  Flights,
  Hotels,
  Cabs,
  Buses,
  Insurance;

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
}
