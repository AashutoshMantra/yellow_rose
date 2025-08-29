import 'dart:convert';

class ExpediaHotelContentResponseBedGroupConfiguration {
  final String? type;
  final String? size;
  final int? quantity;
  ExpediaHotelContentResponseBedGroupConfiguration({
    this.type,
    this.size,
    this.quantity,
  });

  ExpediaHotelContentResponseBedGroupConfiguration copyWith({
    String? type,
    String? size,
    int? quantity,
  }) {
    return ExpediaHotelContentResponseBedGroupConfiguration(
      type: type ?? this.type,
      size: size ?? this.size,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (type != null) {
      result.addAll({'type': type});
    }
    if (size != null) {
      result.addAll({'size': size});
    }
    if (quantity != null) {
      result.addAll({'quantity': quantity});
    }

    return result;
  }

  factory ExpediaHotelContentResponseBedGroupConfiguration.fromMap(
      Map<String, dynamic> map) {
    return ExpediaHotelContentResponseBedGroupConfiguration(
      type: map['type'],
      size: map['size'],
      quantity: map['quantity']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ExpediaHotelContentResponseBedGroupConfiguration.fromJson(
          String source) =>
      ExpediaHotelContentResponseBedGroupConfiguration.fromMap(
          json.decode(source));

  @override
  String toString() =>
      'ExpediaHotelContentResponseBedGroupConfiguration(type: $type, size: $size, quantity: $quantity)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ExpediaHotelContentResponseBedGroupConfiguration &&
        other.type == type &&
        other.size == size &&
        other.quantity == quantity;
  }

  @override
  int get hashCode => type.hashCode ^ size.hashCode ^ quantity.hashCode;
}
