import 'dart:convert';

class ExpediaHotelContentResponseRoomOccupancyMaxAllowed {
  final int? total;
  final int? children;
  final int? adults;
  ExpediaHotelContentResponseRoomOccupancyMaxAllowed({
    this.total,
    this.children,
    this.adults,
  });

  ExpediaHotelContentResponseRoomOccupancyMaxAllowed copyWith({
    int? total,
    int? children,
    int? adults,
  }) {
    return ExpediaHotelContentResponseRoomOccupancyMaxAllowed(
      total: total ?? this.total,
      children: children ?? this.children,
      adults: adults ?? this.adults,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (total != null) {
      result.addAll({'total': total});
    }
    if (children != null) {
      result.addAll({'children': children});
    }
    if (adults != null) {
      result.addAll({'adults': adults});
    }

    return result;
  }

  factory ExpediaHotelContentResponseRoomOccupancyMaxAllowed.fromMap(
      Map<String, dynamic> map) {
    return ExpediaHotelContentResponseRoomOccupancyMaxAllowed(
      total: map['total']?.toInt(),
      children: map['children']?.toInt(),
      adults: map['adults']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ExpediaHotelContentResponseRoomOccupancyMaxAllowed.fromJson(
          String source) =>
      ExpediaHotelContentResponseRoomOccupancyMaxAllowed.fromMap(
          json.decode(source));

  @override
  String toString() =>
      'ExpediaHotelContentResponseRoomOccupancyMaxAllowed(total: $total, children: $children, adults: $adults)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ExpediaHotelContentResponseRoomOccupancyMaxAllowed &&
        other.total == total &&
        other.children == children &&
        other.adults == adults;
  }

  @override
  int get hashCode => total.hashCode ^ children.hashCode ^ adults.hashCode;
}
