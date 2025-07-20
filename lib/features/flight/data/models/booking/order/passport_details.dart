import 'dart:convert';

class UserPassportDetails {
  final int? id;

  final String? passportNumber;

  final DateTime? passportDOB;

  final DateTime? passportDOI;

  final DateTime? passportDOE;

  final String? passportPOI;

  final String? passportCountry;
  UserPassportDetails({
    this.id,
    this.passportNumber,
    this.passportDOB,
    this.passportDOI,
    this.passportDOE,
    this.passportPOI,
    this.passportCountry,
  });

  // Constructors, getters, setters, and other methods...

  UserPassportDetails copyWith({
    int? id,
    String? passportNumber,
    DateTime? passportDOB,
    DateTime? passportDOI,
    DateTime? passportDOE,
    String? passportPOI,
    String? passportCountry,
  }) {
    return UserPassportDetails(
      id: id ?? this.id,
      passportNumber: passportNumber ?? this.passportNumber,
      passportDOB: passportDOB ?? this.passportDOB,
      passportDOI: passportDOI ?? this.passportDOI,
      passportDOE: passportDOE ?? this.passportDOE,
      passportPOI: passportPOI ?? this.passportPOI,
      passportCountry: passportCountry ?? this.passportCountry,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(id != null){
      result.addAll({'id': id});
    }
    if(passportNumber != null){
      result.addAll({'passportNumber': passportNumber});
    }
    if(passportDOB != null){
      result.addAll({'passportDOB': passportDOB!.millisecondsSinceEpoch});
    }
    if(passportDOI != null){
      result.addAll({'passportDOI': passportDOI!.millisecondsSinceEpoch});
    }
    if(passportDOE != null){
      result.addAll({'passportDOE': passportDOE!.millisecondsSinceEpoch});
    }
    if(passportPOI != null){
      result.addAll({'passportPOI': passportPOI});
    }
    if(passportCountry != null){
      result.addAll({'passportCountry': passportCountry});
    }
  
    return result;
  }

  factory UserPassportDetails.fromMap(Map<String, dynamic> map) {
    return UserPassportDetails(
      id: map['id']?.toInt(),
      passportNumber: map['passportNumber'],
      passportDOB: map['passportDOB'] != null ? DateTime.tryParse(map['passportDOB']) : null,
      passportDOI: map['passportDOI'] != null ? DateTime.tryParse(map['passportDOI']) : null,
      passportDOE: map['passportDOE'] != null ? DateTime.tryParse(map['passportDOE']) : null,
      passportPOI: map['passportPOI'],
      passportCountry: map['passportCountry'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserPassportDetails.fromJson(String source) => UserPassportDetails.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserPassportDetails(id: $id, passportNumber: $passportNumber, passportDOB: $passportDOB, passportDOI: $passportDOI, passportDOE: $passportDOE, passportPOI: $passportPOI, passportCountry: $passportCountry)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is UserPassportDetails &&
      other.id == id &&
      other.passportNumber == passportNumber &&
      other.passportDOB == passportDOB &&
      other.passportDOI == passportDOI &&
      other.passportDOE == passportDOE &&
      other.passportPOI == passportPOI &&
      other.passportCountry == passportCountry;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      passportNumber.hashCode ^
      passportDOB.hashCode ^
      passportDOI.hashCode ^
      passportDOE.hashCode ^
      passportPOI.hashCode ^
      passportCountry.hashCode;
  }
}
