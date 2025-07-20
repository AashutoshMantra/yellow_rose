import 'dart:convert';

class Segment {
  final String? from;
  final String? carrierName;

  final String? to;
  final String? flightNumber;
  final String? misc;
  final String? loyaltyNumber;
  final String? ticketNumber;

  final String? seatNumber;
  final double seatBasePrice;
  final String? seatUnitKey;
  bool seatUpdated = false;
  final String? seatTicketNumber;

  final String? mealPreferences;
  final double mealBasePrice;
  final String? mealUnitKey;
  bool mealUpdated = false;
  final String? mealTicketNumber;

  final String? specialSsr;
  final double specialSsrBasePrice;
  final String? specialSsrUnitKey;
  bool specialSsrUpdated = false;
  final String? specialSsrTicketNumber;

  final String? baggageSsr;
  final double baggageSsrBasePrice;
  final String? baggageSsrUnitKey;
  bool baggageSsrUpdated = false;
  final String? baggageSsrTicketNumber;
  Segment({
    this.from,
    this.carrierName,
    this.to,
    this.flightNumber,
    this.misc,
    this.loyaltyNumber,
    this.ticketNumber,
    this.seatNumber,
     this.seatBasePrice=0.0,
    this.seatUnitKey,
     this.seatUpdated=false,
    this.seatTicketNumber,
    this.mealPreferences,
     this.mealBasePrice=0.0,
    this.mealUnitKey,
     this.mealUpdated=false,
    this.mealTicketNumber,
    this.specialSsr,
     this.specialSsrBasePrice=0.0,
    this.specialSsrUnitKey,
     this.specialSsrUpdated=false,
    this.specialSsrTicketNumber,
    this.baggageSsr,
     this.baggageSsrBasePrice=0.0,
    this.baggageSsrUnitKey,
     this.baggageSsrUpdated=false,
    this.baggageSsrTicketNumber,
  });

  Segment copyWith({
    String? from,
    String? carrierName,
    String? to,
    String? flightNumber,
    String? misc,
    String? loyaltyNumber,
    String? ticketNumber,
    String? seatNumber,
    double? seatBasePrice,
    String? seatUnitKey,
    bool? seatUpdated,
    String? seatTicketNumber,
    String? mealPreferences,
    double? mealBasePrice,
    String? mealUnitKey,
    bool? mealUpdated,
    String? mealTicketNumber,
    String? specialSsr,
    double? specialSsrBasePrice,
    String? specialSsrUnitKey,
    bool? specialSsrUpdated,
    String? specialSsrTicketNumber,
    String? baggageSsr,
    double? baggageSsrBasePrice,
    String? baggageSsrUnitKey,
    bool? baggageSsrUpdated,
    String? baggageSsrTicketNumber,
  }) {
    return Segment(
      from: from ?? this.from,
      carrierName: carrierName ?? this.carrierName,
      to: to ?? this.to,
      flightNumber: flightNumber ?? this.flightNumber,
      misc: misc ?? this.misc,
      loyaltyNumber: loyaltyNumber ?? this.loyaltyNumber,
      ticketNumber: ticketNumber ?? this.ticketNumber,
      seatNumber: seatNumber ?? this.seatNumber,
      seatBasePrice: seatBasePrice ?? this.seatBasePrice,
      seatUnitKey: seatUnitKey ?? this.seatUnitKey,
      seatUpdated: seatUpdated ?? this.seatUpdated,
      seatTicketNumber: seatTicketNumber ?? this.seatTicketNumber,
      mealPreferences: mealPreferences ?? this.mealPreferences,
      mealBasePrice: mealBasePrice ?? this.mealBasePrice,
      mealUnitKey: mealUnitKey ?? this.mealUnitKey,
      mealUpdated: mealUpdated ?? this.mealUpdated,
      mealTicketNumber: mealTicketNumber ?? this.mealTicketNumber,
      specialSsr: specialSsr ?? this.specialSsr,
      specialSsrBasePrice: specialSsrBasePrice ?? this.specialSsrBasePrice,
      specialSsrUnitKey: specialSsrUnitKey ?? this.specialSsrUnitKey,
      specialSsrUpdated: specialSsrUpdated ?? this.specialSsrUpdated,
      specialSsrTicketNumber: specialSsrTicketNumber ?? this.specialSsrTicketNumber,
      baggageSsr: baggageSsr ?? this.baggageSsr,
      baggageSsrBasePrice: baggageSsrBasePrice ?? this.baggageSsrBasePrice,
      baggageSsrUnitKey: baggageSsrUnitKey ?? this.baggageSsrUnitKey,
      baggageSsrUpdated: baggageSsrUpdated ?? this.baggageSsrUpdated,
      baggageSsrTicketNumber: baggageSsrTicketNumber ?? this.baggageSsrTicketNumber,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(from != null){
      result.addAll({'from': from});
    }
    if(carrierName != null){
      result.addAll({'carrierName': carrierName});
    }
    if(to != null){
      result.addAll({'to': to});
    }
    if(flightNumber != null){
      result.addAll({'flightNumber': flightNumber});
    }
    if(misc != null){
      result.addAll({'misc': misc});
    }
    if(loyaltyNumber != null){
      result.addAll({'loyaltyNumber': loyaltyNumber});
    }
    if(ticketNumber != null){
      result.addAll({'ticketNumber': ticketNumber});
    }
    if(seatNumber != null){
      result.addAll({'seatNumber': seatNumber});
    }
    result.addAll({'seatBasePrice': seatBasePrice});
    if(seatUnitKey != null){
      result.addAll({'seatUnitKey': seatUnitKey});
    }
    result.addAll({'seatUpdated': seatUpdated});
    if(seatTicketNumber != null){
      result.addAll({'seatTicketNumber': seatTicketNumber});
    }
    if(mealPreferences != null){
      result.addAll({'mealPreferences': mealPreferences});
    }
    result.addAll({'mealBasePrice': mealBasePrice});
    if(mealUnitKey != null){
      result.addAll({'mealUnitKey': mealUnitKey});
    }
    result.addAll({'mealUpdated': mealUpdated});
    if(mealTicketNumber != null){
      result.addAll({'mealTicketNumber': mealTicketNumber});
    }
    if(specialSsr != null){
      result.addAll({'specialSsr': specialSsr});
    }
    result.addAll({'specialSsrBasePrice': specialSsrBasePrice});
    if(specialSsrUnitKey != null){
      result.addAll({'specialSsrUnitKey': specialSsrUnitKey});
    }
    result.addAll({'specialSsrUpdated': specialSsrUpdated});
    if(specialSsrTicketNumber != null){
      result.addAll({'specialSsrTicketNumber': specialSsrTicketNumber});
    }
    if(baggageSsr != null){
      result.addAll({'baggageSsr': baggageSsr});
    }
    result.addAll({'baggageSsrBasePrice': baggageSsrBasePrice});
    if(baggageSsrUnitKey != null){
      result.addAll({'baggageSsrUnitKey': baggageSsrUnitKey});
    }
    result.addAll({'baggageSsrUpdated': baggageSsrUpdated});
    if(baggageSsrTicketNumber != null){
      result.addAll({'baggageSsrTicketNumber': baggageSsrTicketNumber});
    }
  
    return result;
  }

  factory Segment.fromMap(Map<String, dynamic> map) {
    return Segment(
      from: map['from'],
      carrierName: map['carrierName'],
      to: map['to'],
      flightNumber: map['flightNumber'],
      misc: map['misc'],
      loyaltyNumber: map['loyaltyNumber'],
      ticketNumber: map['ticketNumber'],
      seatNumber: map['seatNumber'],
      seatBasePrice: map['seatBasePrice']?.toDouble() ?? 0.0,
      seatUnitKey: map['seatUnitKey'],
      seatUpdated: map['seatUpdated'] ?? false,
      seatTicketNumber: map['seatTicketNumber'],
      mealPreferences: map['mealPreferences'],
      mealBasePrice: map['mealBasePrice']?.toDouble() ?? 0.0,
      mealUnitKey: map['mealUnitKey'],
      mealUpdated: map['mealUpdated'] ?? false,
      mealTicketNumber: map['mealTicketNumber'],
      specialSsr: map['specialSsr'],
      specialSsrBasePrice: map['specialSsrBasePrice']?.toDouble() ?? 0.0,
      specialSsrUnitKey: map['specialSsrUnitKey'],
      specialSsrUpdated: map['specialSsrUpdated'] ?? false,
      specialSsrTicketNumber: map['specialSsrTicketNumber'],
      baggageSsr: map['baggageSsr'],
      baggageSsrBasePrice: map['baggageSsrBasePrice']?.toDouble() ?? 0.0,
      baggageSsrUnitKey: map['baggageSsrUnitKey'],
      baggageSsrUpdated: map['baggageSsrUpdated'] ?? false,
      baggageSsrTicketNumber: map['baggageSsrTicketNumber'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Segment.fromJson(String source) =>
      Segment.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Segment(from: $from, carrierName: $carrierName, to: $to, flightNumber: $flightNumber, misc: $misc, loyaltyNumber: $loyaltyNumber, ticketNumber: $ticketNumber, seatNumber: $seatNumber, seatBasePrice: $seatBasePrice, seatUnitKey: $seatUnitKey, seatUpdated: $seatUpdated, seatTicketNumber: $seatTicketNumber, mealPreferences: $mealPreferences, mealBasePrice: $mealBasePrice, mealUnitKey: $mealUnitKey, mealUpdated: $mealUpdated, mealTicketNumber: $mealTicketNumber, specialSsr: $specialSsr, specialSsrBasePrice: $specialSsrBasePrice, specialSsrUnitKey: $specialSsrUnitKey, specialSsrUpdated: $specialSsrUpdated, specialSsrTicketNumber: $specialSsrTicketNumber, baggageSsr: $baggageSsr, baggageSsrBasePrice: $baggageSsrBasePrice, baggageSsrUnitKey: $baggageSsrUnitKey, baggageSsrUpdated: $baggageSsrUpdated, baggageSsrTicketNumber: $baggageSsrTicketNumber)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Segment &&
      other.from == from &&
      other.carrierName == carrierName &&
      other.to == to &&
      other.flightNumber == flightNumber &&
      other.misc == misc &&
      other.loyaltyNumber == loyaltyNumber &&
      other.ticketNumber == ticketNumber &&
      other.seatNumber == seatNumber &&
      other.seatBasePrice == seatBasePrice &&
      other.seatUnitKey == seatUnitKey &&
      other.seatUpdated == seatUpdated &&
      other.seatTicketNumber == seatTicketNumber &&
      other.mealPreferences == mealPreferences &&
      other.mealBasePrice == mealBasePrice &&
      other.mealUnitKey == mealUnitKey &&
      other.mealUpdated == mealUpdated &&
      other.mealTicketNumber == mealTicketNumber &&
      other.specialSsr == specialSsr &&
      other.specialSsrBasePrice == specialSsrBasePrice &&
      other.specialSsrUnitKey == specialSsrUnitKey &&
      other.specialSsrUpdated == specialSsrUpdated &&
      other.specialSsrTicketNumber == specialSsrTicketNumber &&
      other.baggageSsr == baggageSsr &&
      other.baggageSsrBasePrice == baggageSsrBasePrice &&
      other.baggageSsrUnitKey == baggageSsrUnitKey &&
      other.baggageSsrUpdated == baggageSsrUpdated &&
      other.baggageSsrTicketNumber == baggageSsrTicketNumber;
  }

  @override
  int get hashCode {
    return from.hashCode ^
      carrierName.hashCode ^
      to.hashCode ^
      flightNumber.hashCode ^
      misc.hashCode ^
      loyaltyNumber.hashCode ^
      ticketNumber.hashCode ^
      seatNumber.hashCode ^
      seatBasePrice.hashCode ^
      seatUnitKey.hashCode ^
      seatUpdated.hashCode ^
      seatTicketNumber.hashCode ^
      mealPreferences.hashCode ^
      mealBasePrice.hashCode ^
      mealUnitKey.hashCode ^
      mealUpdated.hashCode ^
      mealTicketNumber.hashCode ^
      specialSsr.hashCode ^
      specialSsrBasePrice.hashCode ^
      specialSsrUnitKey.hashCode ^
      specialSsrUpdated.hashCode ^
      specialSsrTicketNumber.hashCode ^
      baggageSsr.hashCode ^
      baggageSsrBasePrice.hashCode ^
      baggageSsrUnitKey.hashCode ^
      baggageSsrUpdated.hashCode ^
      baggageSsrTicketNumber.hashCode;
  }
}
