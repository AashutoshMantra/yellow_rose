import 'dart:convert';

class AgodaHotelSearchResRatePlan {
  final String? name;
  final String? description;
  final String? inclusions;
  final String? exclusions;
  final String? checkInTime;
  final String? checkoutTime;
  AgodaHotelSearchResRatePlan({
    this.name,
    this.description,
    this.inclusions,
    this.exclusions,
    this.checkInTime,
    this.checkoutTime,
  });

  AgodaHotelSearchResRatePlan copyWith({
    String? name,
    String? description,
    String? inclusions,
    String? exclusions,
    String? checkInTime,
    String? checkoutTime,
  }) {
    return AgodaHotelSearchResRatePlan(
      name: name ?? this.name,
      description: description ?? this.description,
      inclusions: inclusions ?? this.inclusions,
      exclusions: exclusions ?? this.exclusions,
      checkInTime: checkInTime ?? this.checkInTime,
      checkoutTime: checkoutTime ?? this.checkoutTime,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (name != null) {
      result.addAll({'name': name});
    }
    if (description != null) {
      result.addAll({'description': description});
    }
    if (inclusions != null) {
      result.addAll({'inclusions': inclusions});
    }
    if (exclusions != null) {
      result.addAll({'exclusions': exclusions});
    }
    if (checkInTime != null) {
      result.addAll({'checkInTime': checkInTime});
    }
    if (checkoutTime != null) {
      result.addAll({'checkoutTime': checkoutTime});
    }

    return result;
  }

  factory AgodaHotelSearchResRatePlan.fromMap(Map<String, dynamic> map) {
    return AgodaHotelSearchResRatePlan(
      name: map['name'],
      description: map['description'],
      inclusions: map['inclusions'],
      exclusions: map['exclusions'],
      checkInTime: map['checkInTime'],
      checkoutTime: map['checkoutTime'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AgodaHotelSearchResRatePlan.fromJson(String source) =>
      AgodaHotelSearchResRatePlan.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AgodaHotelSearchResRatePlan(name: $name, description: $description, inclusions: $inclusions, exclusions: $exclusions, checkInTime: $checkInTime, checkoutTime: $checkoutTime)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AgodaHotelSearchResRatePlan &&
        other.name == name &&
        other.description == description &&
        other.inclusions == inclusions &&
        other.exclusions == exclusions &&
        other.checkInTime == checkInTime &&
        other.checkoutTime == checkoutTime;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        description.hashCode ^
        inclusions.hashCode ^
        exclusions.hashCode ^
        checkInTime.hashCode ^
        checkoutTime.hashCode;
  }
}
