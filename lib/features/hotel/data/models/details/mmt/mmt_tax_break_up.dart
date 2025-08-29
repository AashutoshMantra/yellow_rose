import 'dart:convert';

class MMTHotelSearchResTaxBreakup {

    final double? hotelTax;
    final double? hotelServiceCharge;
    final double? serviceFee;
  MMTHotelSearchResTaxBreakup({
    this.hotelTax,
    this.hotelServiceCharge,
    this.serviceFee,
  });

  MMTHotelSearchResTaxBreakup copyWith({
    double? hotelTax,
    double? hotelServiceCharge,
    double? serviceFee,
  }) {
    return MMTHotelSearchResTaxBreakup(
      hotelTax: hotelTax ?? this.hotelTax,
      hotelServiceCharge: hotelServiceCharge ?? this.hotelServiceCharge,
      serviceFee: serviceFee ?? this.serviceFee,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(hotelTax != null){
      result.addAll({'hotelTax': hotelTax});
    }
    if(hotelServiceCharge != null){
      result.addAll({'hotelServiceCharge': hotelServiceCharge});
    }
    if(serviceFee != null){
      result.addAll({'serviceFee': serviceFee});
    }
  
    return result;
  }

  factory MMTHotelSearchResTaxBreakup.fromMap(Map<String, dynamic> map) {
    return MMTHotelSearchResTaxBreakup(
      hotelTax: map['hotelTax']?.toDouble(),
      hotelServiceCharge: map['hotelServiceCharge']?.toDouble(),
      serviceFee: map['serviceFee']?.toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory MMTHotelSearchResTaxBreakup.fromJson(String source) => MMTHotelSearchResTaxBreakup.fromMap(json.decode(source));

  @override
  String toString() => 'MMTHotelSearchResTaxBreakup(hotelTax: $hotelTax, hotelServiceCharge: $hotelServiceCharge, serviceFee: $serviceFee)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is MMTHotelSearchResTaxBreakup &&
      other.hotelTax == hotelTax &&
      other.hotelServiceCharge == hotelServiceCharge &&
      other.serviceFee == serviceFee;
  }

  @override
  int get hashCode => hotelTax.hashCode ^ hotelServiceCharge.hashCode ^ serviceFee.hashCode;
}
