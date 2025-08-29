import 'dart:convert';

class PlaceEntity {
  final String? address;
  final String? placeId;
  final double? latitude;
  final double? longitude;
  final String? city;
  final String? state;
  final String? county;
  final String? country;
  final String? countryCode;
  PlaceEntity({
    this.address,
    this.placeId,
    this.latitude,
    this.longitude,
    this.city,
    this.state,
    this.county,
    this.country,
    this.countryCode,
  });

  PlaceEntity copyWith({
    String? address,
    String? placeId,
    double? latitude,
    double? longitude,
    String? city,
    String? state,
    String? county,
    String? country,
    String? countryCode,
  }) {
    return PlaceEntity(
      address: address ?? this.address,
      placeId: placeId ?? this.placeId,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      city: city ?? this.city,
      state: state ?? this.state,
      county: county ?? this.county,
      country: country ?? this.country,
      countryCode: countryCode ?? this.countryCode,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (address != null) {
      result.addAll({'address': address});
    }
    if (placeId != null) {
      result.addAll({'placeId': placeId});
    }
    if (latitude != null) {
      result.addAll({'latitude': latitude});
    }
    if (longitude != null) {
      result.addAll({'longitude': longitude});
    }
    if (city != null) {
      result.addAll({'city': city});
    }
    if (state != null) {
      result.addAll({'state': state});
    }
    if (county != null) {
      result.addAll({'county': county});
    }
    if (country != null) {
      result.addAll({'country': country});
    }
    if (countryCode != null) {
      result.addAll({'countryCode': countryCode});
    }

    return result;
  }

  factory PlaceEntity.fromMap(Map<String, dynamic> map) {
    return PlaceEntity(
      address: map['address'],
      placeId: map['placeId'],
      latitude: map['latitude']?.toDouble(),
      longitude: map['longitude']?.toDouble(),
      city: map['city'],
      state: map['state'],
      county: map['county'],
      country: map['country'],
      countryCode: map['countryCode'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PlaceEntity.fromJson(String source) =>
      PlaceEntity.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PlaceEntity(address: $address, placeId: $placeId, latitude: $latitude, longitude: $longitude, city: $city, state: $state, county: $county, country: $country, countryCode: $countryCode)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PlaceEntity &&
        other.address == address &&
        other.placeId == placeId &&
        other.latitude == latitude &&
        other.longitude == longitude &&
        other.city == city &&
        other.state == state &&
        other.county == county &&
        other.country == country &&
        other.countryCode == countryCode;
  }

  @override
  int get hashCode {
    return address.hashCode ^
        placeId.hashCode ^
        latitude.hashCode ^
        longitude.hashCode ^
        city.hashCode ^
        state.hashCode ^
        county.hashCode ^
        country.hashCode ^
        countryCode.hashCode;
  }
}
