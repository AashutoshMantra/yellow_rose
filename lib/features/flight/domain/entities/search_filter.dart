import 'dart:convert';

import 'package:flutter/foundation.dart';

enum AirSortBy {
  EarlyDeparture("Early Departure"),
  LateDeparture("Late Departure"),
  EarlyArrival("Early Arrival"),
  LateArrival("Late Arrival"),
  Price("Price");

  final String text;
  const AirSortBy(this.text);
}

enum FlightTiming {
  EarlyMorning("Early Morning", "Midnight - 8AM"),
  Morning("Morning", "8 AM - Noon"),
  AfterMorning("After Morning", "Noon - 4PM"),
  Evening("Evening", "4PM - 8PM"),
  Mignight("Mignight", "8PM - Midnight");

  final String text;
  final String timing;
  const FlightTiming(this.text, this.timing);
}
