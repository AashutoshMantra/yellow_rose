import 'dart:convert';

class ExpediaHotelContentResponseIdName {
  final String? id;
  final String? name;
  ExpediaHotelContentResponseIdName({
    this.id,
    this.name,
  });

  ExpediaHotelContentResponseIdName copyWith({
    String? id,
    String? name,
  }) {
    return ExpediaHotelContentResponseIdName(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (name != null) {
      result.addAll({'name': name});
    }

    return result;
  }

  factory ExpediaHotelContentResponseIdName.fromMap(Map<String, dynamic> map) {
    return ExpediaHotelContentResponseIdName(
      id: map['id'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ExpediaHotelContentResponseIdName.fromJson(String source) =>
      ExpediaHotelContentResponseIdName.fromMap(json.decode(source));

  @override
  String toString() =>
      'ExpediaHotelContentResponseIdName(id: $id, name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ExpediaHotelContentResponseIdName &&
        other.id == id &&
        other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
