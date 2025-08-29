import 'dart:convert';

class ExpediaBookingUIRequestInvoicing {
  final String? companyName;
  final String? companyAddressLine1;
  final String? companyAddressLine2;
  final String? companyAddressLine3;
  final String? companyAddressCity;
  final String? companyAddressStateProvinceCode;
  final String? companyAddressPostalCode;
  final String? companyAddressCountryCode;
  final String? email;
  ExpediaBookingUIRequestInvoicing({
    this.companyName,
    this.companyAddressLine1,
    this.companyAddressLine2,
    this.companyAddressLine3,
    this.companyAddressCity,
    this.companyAddressStateProvinceCode,
    this.companyAddressPostalCode,
    this.companyAddressCountryCode,
    this.email,
  });

  ExpediaBookingUIRequestInvoicing copyWith({
    String? companyName,
    String? companyAddressLine1,
    String? companyAddressLine2,
    String? companyAddressLine3,
    String? companyAddressCity,
    String? companyAddressStateProvinceCode,
    String? companyAddressPostalCode,
    String? companyAddressCountryCode,
    String? email,
  }) {
    return ExpediaBookingUIRequestInvoicing(
      companyName: companyName ?? this.companyName,
      companyAddressLine1: companyAddressLine1 ?? this.companyAddressLine1,
      companyAddressLine2: companyAddressLine2 ?? this.companyAddressLine2,
      companyAddressLine3: companyAddressLine3 ?? this.companyAddressLine3,
      companyAddressCity: companyAddressCity ?? this.companyAddressCity,
      companyAddressStateProvinceCode: companyAddressStateProvinceCode ??
          this.companyAddressStateProvinceCode,
      companyAddressPostalCode:
          companyAddressPostalCode ?? this.companyAddressPostalCode,
      companyAddressCountryCode:
          companyAddressCountryCode ?? this.companyAddressCountryCode,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (companyName != null) {
      result.addAll({'companyName': companyName});
    }
    if (companyAddressLine1 != null) {
      result.addAll({'companyAddressLine1': companyAddressLine1});
    }
    if (companyAddressLine2 != null) {
      result.addAll({'companyAddressLine2': companyAddressLine2});
    }
    if (companyAddressLine3 != null) {
      result.addAll({'companyAddressLine3': companyAddressLine3});
    }
    if (companyAddressCity != null) {
      result.addAll({'companyAddressCity': companyAddressCity});
    }
    if (companyAddressStateProvinceCode != null) {
      result.addAll(
          {'companyAddressStateProvinceCode': companyAddressStateProvinceCode});
    }
    if (companyAddressPostalCode != null) {
      result.addAll({'companyAddressPostalCode': companyAddressPostalCode});
    }
    if (companyAddressCountryCode != null) {
      result.addAll({'companyAddressCountryCode': companyAddressCountryCode});
    }
    if (email != null) {
      result.addAll({'email': email});
    }

    return result;
  }

  factory ExpediaBookingUIRequestInvoicing.fromMap(Map<String, dynamic> map) {
    return ExpediaBookingUIRequestInvoicing(
      companyName: map['companyName'],
      companyAddressLine1: map['companyAddressLine1'],
      companyAddressLine2: map['companyAddressLine2'],
      companyAddressLine3: map['companyAddressLine3'],
      companyAddressCity: map['companyAddressCity'],
      companyAddressStateProvinceCode: map['companyAddressStateProvinceCode'],
      companyAddressPostalCode: map['companyAddressPostalCode'],
      companyAddressCountryCode: map['companyAddressCountryCode'],
      email: map['email'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ExpediaBookingUIRequestInvoicing.fromJson(String source) =>
      ExpediaBookingUIRequestInvoicing.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ExpediaBookingUIRequestInvoicing(companyName: $companyName, companyAddressLine1: $companyAddressLine1, companyAddressLine2: $companyAddressLine2, companyAddressLine3: $companyAddressLine3, companyAddressCity: $companyAddressCity, companyAddressStateProvinceCode: $companyAddressStateProvinceCode, companyAddressPostalCode: $companyAddressPostalCode, companyAddressCountryCode: $companyAddressCountryCode, email: $email)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ExpediaBookingUIRequestInvoicing &&
        other.companyName == companyName &&
        other.companyAddressLine1 == companyAddressLine1 &&
        other.companyAddressLine2 == companyAddressLine2 &&
        other.companyAddressLine3 == companyAddressLine3 &&
        other.companyAddressCity == companyAddressCity &&
        other.companyAddressStateProvinceCode ==
            companyAddressStateProvinceCode &&
        other.companyAddressPostalCode == companyAddressPostalCode &&
        other.companyAddressCountryCode == companyAddressCountryCode &&
        other.email == email;
  }

  @override
  int get hashCode {
    return companyName.hashCode ^
        companyAddressLine1.hashCode ^
        companyAddressLine2.hashCode ^
        companyAddressLine3.hashCode ^
        companyAddressCity.hashCode ^
        companyAddressStateProvinceCode.hashCode ^
        companyAddressPostalCode.hashCode ^
        companyAddressCountryCode.hashCode ^
        email.hashCode;
  }
}
