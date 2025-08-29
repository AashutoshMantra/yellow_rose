import 'dart:convert';

class AgodaHotelSearchResTotalPayment {
  final double? exclusive;
  final double? inclusive;
  final double? tax;
  final double? fees;
  final double? estimatedCommission;
  final double? taxDueSupplier;
  AgodaHotelSearchResTotalPayment({
    this.exclusive,
    this.inclusive,
    this.tax,
    this.fees,
    this.estimatedCommission,
    this.taxDueSupplier,
  });

  AgodaHotelSearchResTotalPayment copyWith({
    double? exclusive,
    double? inclusive,
    double? tax,
    double? fees,
    double? estimatedCommission,
    double? taxDueSupplier,
  }) {
    return AgodaHotelSearchResTotalPayment(
      exclusive: exclusive ?? this.exclusive,
      inclusive: inclusive ?? this.inclusive,
      tax: tax ?? this.tax,
      fees: fees ?? this.fees,
      estimatedCommission: estimatedCommission ?? this.estimatedCommission,
      taxDueSupplier: taxDueSupplier ?? this.taxDueSupplier,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(exclusive != null){
      result.addAll({'exclusive': exclusive});
    }
    if(inclusive != null){
      result.addAll({'inclusive': inclusive});
    }
    if(tax != null){
      result.addAll({'tax': tax});
    }
    if(fees != null){
      result.addAll({'fees': fees});
    }
    if(estimatedCommission != null){
      result.addAll({'estimatedCommission': estimatedCommission});
    }
    if(taxDueSupplier != null){
      result.addAll({'taxDueSupplier': taxDueSupplier});
    }
  
    return result;
  }

  factory AgodaHotelSearchResTotalPayment.fromMap(Map<String, dynamic> map) {
    return AgodaHotelSearchResTotalPayment(
      exclusive: map['exclusive']?.toDouble(),
      inclusive: map['inclusive']?.toDouble(),
      tax: map['tax']?.toDouble(),
      fees: map['fees']?.toDouble(),
      estimatedCommission: map['estimatedCommission']?.toDouble(),
      taxDueSupplier: map['taxDueSupplier']?.toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory AgodaHotelSearchResTotalPayment.fromJson(String source) => AgodaHotelSearchResTotalPayment.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AgodaHotelSearchResTotalPayment(exclusive: $exclusive, inclusive: $inclusive, tax: $tax, fees: $fees, estimatedCommission: $estimatedCommission, taxDueSupplier: $taxDueSupplier)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is AgodaHotelSearchResTotalPayment &&
      other.exclusive == exclusive &&
      other.inclusive == inclusive &&
      other.tax == tax &&
      other.fees == fees &&
      other.estimatedCommission == estimatedCommission &&
      other.taxDueSupplier == taxDueSupplier;
  }

  @override
  int get hashCode {
    return exclusive.hashCode ^
      inclusive.hashCode ^
      tax.hashCode ^
      fees.hashCode ^
      estimatedCommission.hashCode ^
      taxDueSupplier.hashCode;
  }
}
