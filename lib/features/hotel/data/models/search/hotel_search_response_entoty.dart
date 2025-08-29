import 'dart:convert';

class HotelSearchResponseAmenity {
  final String name;
  final String displayName;
  HotelSearchResponseAmenity({
    required this.name,
    required this.displayName,
  });

  HotelSearchResponseAmenity copyWith({
    String? name,
    String? displayName,
  }) {
    return HotelSearchResponseAmenity(
      name: name ?? this.name,
      displayName: displayName ?? this.displayName,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'name': name});
    result.addAll({'displayName': displayName});

    return result;
  }

  factory HotelSearchResponseAmenity.fromMap(Map<String, dynamic> map) {
    return HotelSearchResponseAmenity(
      name: map['name'] ?? '',
      displayName: map['displayName'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory HotelSearchResponseAmenity.fromJson(String source) =>
      HotelSearchResponseAmenity.fromMap(json.decode(source));

  @override
  String toString() =>
      'HotelSearchResponseAmenity(name: $name, displayName: $displayName)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HotelSearchResponseAmenity &&
        other.name == name &&
        other.displayName == displayName;
  }

  @override
  int get hashCode => name.hashCode ^ displayName.hashCode;
}
