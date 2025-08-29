import 'dart:convert';

class ExpediaHotelSearchRespIdName {
  final String? id;
  final String? name;
  ExpediaHotelSearchRespIdName({
    this.id,
    this.name,
  });

  ExpediaHotelSearchRespIdName copyWith({
    String? id,
    String? name,
  }) {
    return ExpediaHotelSearchRespIdName(
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

  factory ExpediaHotelSearchRespIdName.fromMap(Map<String, dynamic> map) {
    return ExpediaHotelSearchRespIdName(
      id: map['id'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ExpediaHotelSearchRespIdName.fromJson(String source) =>
      ExpediaHotelSearchRespIdName.fromMap(json.decode(source));

  @override
  String toString() => 'ExpediaHotelSearchRespIdName(id: $id, name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ExpediaHotelSearchRespIdName &&
        other.id == id &&
        other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
