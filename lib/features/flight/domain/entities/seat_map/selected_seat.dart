import 'dart:convert';

import 'package:yellow_rose/features/flight/data/models/seat_map/air_seat.dart';

class SelectedSeat {
  final String row;
  final AirSeat seat;
  SelectedSeat({
    required this.row,
    required this.seat,
  });

  SelectedSeat copyWith({
    String? row,
    AirSeat? seat,
  }) {
    return SelectedSeat(
      row: row ?? this.row,
      seat: seat ?? this.seat,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'row': row});
    result.addAll({'seat': seat.toMap()});

    return result;
  }

  factory SelectedSeat.fromMap(Map<String, dynamic> map) {
    return SelectedSeat(
      row: map['row'] ?? '',
      seat: AirSeat.fromMap(map['seat']),
    );
  }

  String toJson() => json.encode(toMap());

  factory SelectedSeat.fromJson(String source) =>
      SelectedSeat.fromMap(json.decode(source));

  bool get isRestricted {
    return seat.isRestricted;
  }

  double get totalCost {
    return seat.baseFare + seat.finalTax;
  }
}
