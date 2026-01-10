import 'dart:convert';

import 'package:yellow_rose/features/auth/data/models/profile/cctype.dart';

class UserCreditCardInfo {
  
    
    final int? id;

    
    final String? cardNumber;

    
    final String? name;

    
    final String? expiryMonth;

    
    final String? expiryYear;

    
    final String? cvvNumber;

    
    final String? city;

    
    final String? street;

    
    final String? mobile;

    
    final String? pincode;

    
    final String? email;

    
    final CCType? cardType;
  UserCreditCardInfo({
    this.id,
    this.cardNumber,
    this.name,
    this.expiryMonth,
    this.expiryYear,
    this.cvvNumber,
    this.city,
    this.street,
    this.mobile,
    this.pincode,
    this.email,
    this.cardType,
  });


  UserCreditCardInfo copyWith({
    int? id,
    String? cardNumber,
    String? name,
    String? expiryMonth,
    String? expiryYear,
    String? cvvNumber,
    String? city,
    String? street,
    String? mobile,
    String? pincode,
    String? email,
    CCType? cardType,
  }) {
    return UserCreditCardInfo(
      id: id ?? this.id,
      cardNumber: cardNumber ?? this.cardNumber,
      name: name ?? this.name,
      expiryMonth: expiryMonth ?? this.expiryMonth,
      expiryYear: expiryYear ?? this.expiryYear,
      cvvNumber: cvvNumber ?? this.cvvNumber,
      city: city ?? this.city,
      street: street ?? this.street,
      mobile: mobile ?? this.mobile,
      pincode: pincode ?? this.pincode,
      email: email ?? this.email,
      cardType: cardType ?? this.cardType,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(id != null){
      result.addAll({'id': id});
    }
    if(cardNumber != null){
      result.addAll({'cardNumber': cardNumber});
    }
    if(name != null){
      result.addAll({'name': name});
    }
    if(expiryMonth != null){
      result.addAll({'expiryMonth': expiryMonth});
    }
    if(expiryYear != null){
      result.addAll({'expiryYear': expiryYear});
    }
    if(cvvNumber != null){
      result.addAll({'cvvNumber': cvvNumber});
    }
    if(city != null){
      result.addAll({'city': city});
    }
    if(street != null){
      result.addAll({'street': street});
    }
    if(mobile != null){
      result.addAll({'mobile': mobile});
    }
    if(pincode != null){
      result.addAll({'pincode': pincode});
    }
    if(email != null){
      result.addAll({'email': email});
    }
    if(cardType != null){
      result.addAll({'cardType': cardType?.ccTypeFirstChar});
    }
  
    return result;
  }

  factory UserCreditCardInfo.fromMap(Map<String, dynamic> map) {
    return UserCreditCardInfo(
      id: map['id']?.toInt(),
      cardNumber: map['cardNumber'],
      name: map['name'],
      expiryMonth: map['expiryMonth'],
      expiryYear: map['expiryYear'],
      cvvNumber: map['cvvNumber'],
      city: map['city'],
      street: map['street'],
      mobile: map['mobile'],
      pincode: map['pincode'],
      email: map['email'],
      cardType: map['cardType'] != null ? CCType.getCardTypeFromNumber(map['cardType']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserCreditCardInfo.fromJson(String source) => UserCreditCardInfo.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserCreditCardInfo(id: $id, cardNumber: $cardNumber, name: $name, expiryMonth: $expiryMonth, expiryYear: $expiryYear, cvvNumber: $cvvNumber, city: $city, street: $street, mobile: $mobile, pincode: $pincode, email: $email, cardType: $cardType)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is UserCreditCardInfo &&
      other.id == id &&
      other.cardNumber == cardNumber &&
      other.name == name &&
      other.expiryMonth == expiryMonth &&
      other.expiryYear == expiryYear &&
      other.cvvNumber == cvvNumber &&
      other.city == city &&
      other.street == street &&
      other.mobile == mobile &&
      other.pincode == pincode &&
      other.email == email &&
      other.cardType == cardType;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      cardNumber.hashCode ^
      name.hashCode ^
      expiryMonth.hashCode ^
      expiryYear.hashCode ^
      cvvNumber.hashCode ^
      city.hashCode ^
      street.hashCode ^
      mobile.hashCode ^
      pincode.hashCode ^
      email.hashCode ^
      cardType.hashCode;
  }
}
