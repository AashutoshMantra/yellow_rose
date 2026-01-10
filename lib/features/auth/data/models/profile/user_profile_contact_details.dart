import 'dart:convert';

class UserProfileContactDetails {
  final int? id;

  final String? street;

  final String? city;
  final String? state;
  final String? pinCode;
  final String? country;
  final String? contactNumber;
  final String? emailAddress;
  UserProfileContactDetails({
    this.id,
    this.street,
    this.city,
    this.state,
    this.pinCode,
    this.country,
    this.contactNumber,
    this.emailAddress,
  });

  UserProfileContactDetails copyWith({
    int? id,
    String? street,
    String? city,
    String? state,
    String? pinCode,
    String? country,
    String? contactNumber,
    String? emailAddress,
  }) {
    return UserProfileContactDetails(
      id: id ?? this.id,
      street: street ?? this.street,
      city: city ?? this.city,
      state: state ?? this.state,
      pinCode: pinCode ?? this.pinCode,
      country: country ?? this.country,
      contactNumber: contactNumber ?? this.contactNumber,
      emailAddress: emailAddress ?? this.emailAddress,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(id != null){
      result.addAll({'id': id});
    }
    if(street != null){
      result.addAll({'street': street});
    }
    if(city != null){
      result.addAll({'city': city});
    }
    if(state != null){
      result.addAll({'state': state});
    }
    if(pinCode != null){
      result.addAll({'pinCode': pinCode});
    }
    if(country != null){
      result.addAll({'country': country});
    }
    if(contactNumber != null){
      result.addAll({'contactNumber': contactNumber});
    }
    if(emailAddress != null){
      result.addAll({'emailAddress': emailAddress});
    }
  
    return result;
  }

  factory UserProfileContactDetails.fromMap(Map<String, dynamic> map) {
    return UserProfileContactDetails(
      id: map['id']?.toInt(),
      street: map['street'],
      city: map['city'],
      state: map['state'],
      pinCode: map['pinCode'],
      country: map['country'],
      contactNumber: map['contactNumber'],
      emailAddress: map['emailAddress'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserProfileContactDetails.fromJson(String source) => UserProfileContactDetails.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserProfileContactDetails(id: $id, street: $street, city: $city, state: $state, pinCode: $pinCode, country: $country, contactNumber: $contactNumber, emailAddress: $emailAddress)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is UserProfileContactDetails &&
      other.id == id &&
      other.street == street &&
      other.city == city &&
      other.state == state &&
      other.pinCode == pinCode &&
      other.country == country &&
      other.contactNumber == contactNumber &&
      other.emailAddress == emailAddress;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      street.hashCode ^
      city.hashCode ^
      state.hashCode ^
      pinCode.hashCode ^
      country.hashCode ^
      contactNumber.hashCode ^
      emailAddress.hashCode;
  }
}
