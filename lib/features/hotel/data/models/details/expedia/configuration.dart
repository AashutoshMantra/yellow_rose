import 'dart:convert';

class ExpediaHotelSearchRespConfiguration {
  final String? type;
  final String? size;
  final int? quantity;
  ExpediaHotelSearchRespConfiguration({
    this.type,
    this.size,
    this.quantity,
  });

  ExpediaHotelSearchRespConfiguration copyWith({
    String? type,
    String? size,
    int? quantity,
  }) {
    return ExpediaHotelSearchRespConfiguration(
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

  factory ExpediaHotelSearchRespConfiguration.fromMap(
      Map<String, dynamic> map) {
    return ExpediaHotelSearchRespConfiguration(
      type: map['type'],
      size: map['size'],
      quantity: map['quantity']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ExpediaHotelSearchRespConfiguration.fromJson(String source) =>
      ExpediaHotelSearchRespConfiguration.fromMap(json.decode(source));

  @override
  String toString() =>
      'ExpediaHotelSearchRespConfiguration(type: $type, size: $size, quantity: $quantity)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ExpediaHotelSearchRespConfiguration &&
        other.type == type &&
        other.size == size &&
        other.quantity == quantity;
  }

  @override
  int get hashCode => type.hashCode ^ size.hashCode ^ quantity.hashCode;
}
