enum BusSortBy {
  EarlyDeparture("Early Departure"),
  LateDeparture("Late Departure"),
  Price("Price");

  final String text;
  const BusSortBy(this.text);
}

enum BusTiming {
  EarlyMorning("Early Morning", "Midnight - 8AM"),
  Morning("Morning", "8 AM - Noon"),
  Afternoon("Afternoon", "Noon - 4PM"),
  Evening("Evening", "4PM - 8PM"),
  Night("Night", "8PM - Midnight");

  final String text;
  final String timing;
  const BusTiming(this.text, this.timing);
}

enum BusType {
  AC("AC"),
  NonAC("Non-AC"),
  Seater("Seater"),
  Sleeper("Sleeper");

  final String text;
  const BusType(this.text);
}
