import 'dart:convert';

class AgodaHotelSearchResPerRoomPerNightRate {
  final String? currency;
  final double? exclusive;
  final double? inclusive;
  final double? tax;
  final double? fee;
  final double? fees;
  final int? stayPackageTypeinteger;
  AgodaHotelSearchResPerRoomPerNightRate({
    this.currency,
    this.exclusive,
    this.inclusive,
    this.tax,
    this.fee,
    this.fees,
    this.stayPackageTypeinteger,
  });

  AgodaHotelSearchResPerRoomPerNightRate copyWith({
    String? currency,
    double? exclusive,
    double? inclusive,
    double? tax,
    double? fee,
    double? fees,
    int? stayPackageTypeinteger,
  }) {
    return AgodaHotelSearchResPerRoomPerNightRate(
      currency: currency ?? this.currency,
      exclusive: exclusive ?? this.exclusive,
      inclusive: inclusive ?? this.inclusive,
      tax: tax ?? this.tax,
      fee: fee ?? this.fee,
      fees: fees ?? this.fees,
      stayPackageTypeinteger: stayPackageTypeinteger ?? this.stayPackageTypeinteger,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(currency != null){
      result.addAll({'currency': currency});
    }
    if(exclusive != null){
      result.addAll({'exclusive': exclusive});
    }
    if(inclusive != null){
      result.addAll({'inclusive': inclusive});
    }
    if(tax != null){
      result.addAll({'tax': tax});
    }
    if(fee != null){
      result.addAll({'fee': fee});
    }
    if(fees != null){
      result.addAll({'fees': fees});
    }
    if(stayPackageTypeinteger != null){
      result.addAll({'stayPackageTypeinteger': stayPackageTypeinteger});
    }
  
    return result;
  }

  factory AgodaHotelSearchResPerRoomPerNightRate.fromMap(Map<String, dynamic> map) {
    return AgodaHotelSearchResPerRoomPerNightRate(
      currency: map['currency'],
      exclusive: map['exclusive']?.toDouble(),
      inclusive: map['inclusive']?.toDouble(),
      tax: map['tax']?.toDouble(),
      fee: map['fee']?.toDouble(),
      fees: map['fees']?.toDouble(),
      stayPackageTypeinteger: map['stayPackageTypeinteger']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory AgodaHotelSearchResPerRoomPerNightRate.fromJson(String source) => AgodaHotelSearchResPerRoomPerNightRate.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AgodaHotelSearchResPerRoomPerNightRate(currency: $currency, exclusive: $exclusive, inclusive: $inclusive, tax: $tax, fee: $fee, fees: $fees, stayPackageTypeinteger: $stayPackageTypeinteger)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is AgodaHotelSearchResPerRoomPerNightRate &&
      other.currency == currency &&
      other.exclusive == exclusive &&
      other.inclusive == inclusive &&
      other.tax == tax &&
      other.fee == fee &&
      other.fees == fees &&
      other.stayPackageTypeinteger == stayPackageTypeinteger;
  }

  @override
  int get hashCode {
    return currency.hashCode ^
      exclusive.hashCode ^
      inclusive.hashCode ^
      tax.hashCode ^
      fee.hashCode ^
      fees.hashCode ^
      stayPackageTypeinteger.hashCode;
  }
}
