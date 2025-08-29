import 'dart:convert';

class ExpediaHotelContentResponseRoomDescription {
  final String? overview;
  ExpediaHotelContentResponseRoomDescription({
    this.overview,
  });

  ExpediaHotelContentResponseRoomDescription copyWith({
    String? overview,
  }) {
    return ExpediaHotelContentResponseRoomDescription(
      overview: overview ?? this.overview,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (overview != null) {
      result.addAll({'overview': overview});
    }

    return result;
  }

  factory ExpediaHotelContentResponseRoomDescription.fromMap(
      Map<String, dynamic> map) {
    return ExpediaHotelContentResponseRoomDescription(
      overview: map['overview'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ExpediaHotelContentResponseRoomDescription.fromJson(String source) =>
      ExpediaHotelContentResponseRoomDescription.fromMap(json.decode(source));

  @override
  String toString() =>
      'ExpediaHotelContentResponseRoomDescription(overview: $overview)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ExpediaHotelContentResponseRoomDescription &&
        other.overview == overview;
  }

  @override
  int get hashCode => overview.hashCode;
}
