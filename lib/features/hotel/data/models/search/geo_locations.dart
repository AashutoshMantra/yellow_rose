import 'dart:convert';

class GeoLocation {
    final double latitude;
    final double _longitude;
  GeoLocation({
    required this.latitude,
    required double longitude,
  }):_longitude=longitude;


  GeoLocation copyWith({
    double? latitude,
    double? longitude,
  }) {
    return GeoLocation(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this._longitude,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'latitude': latitude});
    result.addAll({'_longitude': _longitude});
  
    return result;
  }

  factory GeoLocation.fromMap(Map<String, dynamic> map) {
    return GeoLocation(
      latitude: map['latitude']?.toDouble() ?? 0.0,
      longitude: map['_longitude']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory GeoLocation.fromJson(String source) => GeoLocation.fromMap(json.decode(source));

  @override
  String toString() => 'GeoLocation(latitude: $latitude, _longitude: $_longitude)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is GeoLocation &&
      other.latitude == latitude &&
      other._longitude == _longitude;
  }

  @override
  int get hashCode => latitude.hashCode ^ _longitude.hashCode;
}
