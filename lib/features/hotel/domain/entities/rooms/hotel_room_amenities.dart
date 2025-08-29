import 'dart:convert';

class HotelRoomAmenities {
  final String? id;
  final String name;
  HotelRoomAmenities({
    this.id,
    required this.name,
  });

  HotelRoomAmenities copyWith({
    String? id,
    String? name,
  }) {
    return HotelRoomAmenities(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    result.addAll({'name': name});

    return result;
  }

  factory HotelRoomAmenities.fromMap(Map<String, dynamic> map) {
    return HotelRoomAmenities(
      id: map['id'],
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory HotelRoomAmenities.fromJson(String source) =>
      HotelRoomAmenities.fromMap(json.decode(source));

  @override
  String toString() => 'HotelRoomAmenities(id: $id, name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HotelRoomAmenities && other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
