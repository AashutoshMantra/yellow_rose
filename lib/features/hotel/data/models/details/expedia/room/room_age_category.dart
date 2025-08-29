import 'dart:convert';

class ExpediaHotelContentResponseRoomAgeCategory {
  final String? key;
  final String? name;
  final int? minimumAge;
  ExpediaHotelContentResponseRoomAgeCategory({
    this.key,
    this.name,
    this.minimumAge,
  });

  ExpediaHotelContentResponseRoomAgeCategory copyWith({
    String? key,
    String? name,
    int? minimumAge,
  }) {
    return ExpediaHotelContentResponseRoomAgeCategory(
      key: key ?? this.key,
      name: name ?? this.name,
      minimumAge: minimumAge ?? this.minimumAge,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (key != null) {
      result.addAll({'key': key});
    }
    if (name != null) {
      result.addAll({'name': name});
    }
    if (minimumAge != null) {
      result.addAll({'minimumAge': minimumAge});
    }

    return result;
  }

  factory ExpediaHotelContentResponseRoomAgeCategory.fromMap(
      Map<String, dynamic> map) {
    return ExpediaHotelContentResponseRoomAgeCategory(
      key: map['key'],
      name: map['name'],
      minimumAge: map['minimumAge']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ExpediaHotelContentResponseRoomAgeCategory.fromJson(String source) =>
      ExpediaHotelContentResponseRoomAgeCategory.fromMap(json.decode(source));

  @override
  String toString() =>
      'ExpediaHotelContentResponseRoomAgeCategory(key: $key, name: $name, minimumAge: $minimumAge)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ExpediaHotelContentResponseRoomAgeCategory &&
        other.key == key &&
        other.name == name &&
        other.minimumAge == minimumAge;
  }

  @override
  int get hashCode => key.hashCode ^ name.hashCode ^ minimumAge.hashCode;
}
