import 'dart:convert';

class BusCityResponse {
  int id;
  String? cityName;
  String? cityLabel;
  String? countryCode;
  BusCityResponse({
    required this.id,
    this.cityName,
    this.cityLabel,
    this.countryCode,
  });

  BusCityResponse copyWith({
    int? id,
    String? cityName,
    String? cityLabel,
    String? countryCode,
  }) {
    return BusCityResponse(
      id: id ?? this.id,
      cityName: cityName ?? this.cityName,
      cityLabel: cityLabel ?? this.cityLabel,
      countryCode: countryCode ?? this.countryCode,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    if (cityName != null) {
      result.addAll({'cityName': cityName});
    }
    if (cityLabel != null) {
      result.addAll({'cityLabel': cityLabel});
    }
    if (countryCode != null) {
      result.addAll({'countryCode': countryCode});
    }

    return result;
  }

  factory BusCityResponse.fromMap(Map<dynamic, dynamic> map) {
    return BusCityResponse(
      id: map['id']?.toInt() ?? 0,
      cityName: map['cityName'],
      cityLabel: map['cityLabel'],
      countryCode: map['countryCode'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BusCityResponse.fromJson(String source) =>
      BusCityResponse.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BusCityResponse(id: $id, cityName: $cityName, cityLabel: $cityLabel, countryCode: $countryCode)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BusCityResponse &&
        other.id == id &&
        other.cityName == cityName &&
        other.cityLabel == cityLabel &&
        other.countryCode == countryCode;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        cityName.hashCode ^
        cityLabel.hashCode ^
        countryCode.hashCode;
  }
}
