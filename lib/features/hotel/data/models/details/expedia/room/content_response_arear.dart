import 'dart:convert';

class ExpediaHotelContentResponseArea {
  final double? squareMeters;
  final double? squareFeet;

  const ExpediaHotelContentResponseArea({
    this.squareMeters,
    this.squareFeet,
  });

  factory ExpediaHotelContentResponseArea.fromMap(Map<String, dynamic> map) {
    return ExpediaHotelContentResponseArea(
      squareMeters: map['square_meters']?.toDouble(),
      squareFeet: map['square_feet']?.toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'square_meters': squareMeters,
      'square_feet': squareFeet,
    };
  }

  String toJson() => json.encode(toMap());

  factory ExpediaHotelContentResponseArea.fromJson(String source) =>
      ExpediaHotelContentResponseArea.fromMap(json.decode(source));
}
