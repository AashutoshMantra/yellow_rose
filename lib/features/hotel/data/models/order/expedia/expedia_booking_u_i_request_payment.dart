import 'dart:convert';

class ExpediaBookingUIRequestPayment {
  //Possible values - corporate_card,customer_card,virtual_card,affiliate_collect

  final String? type;

  //Card number. Required for credit card transactions.
  final String? number;

  //CVV/CSV code from the back of the customer's card. Required for credit card transactions.
  final String? securityCode;

  //Two-digit month the credit card will expire. Required for credit card transactions.
  final String? expirationMonth;

  //Year the credit card will expire. Required for credit card transactions.
  final String? expirationYear;

  //Date the payment account was enrolled in the cardholder's account with the merchant, in ISO 8601 format (YYYY-MM-DD)
  final String? enrollmentDate;

  //BILLING CONTACT FIELDS
  final String? billingContactFirstName;
  final String? billingContactLastName;

  final String? billingContactAddressLine1;
  final String? billingContactAddressLine2;
  final String? billingContactAddressLine3;
  final String? billingContactAddressCity;
  final String? billingContactAddressStateProvinceCode;
  final String? billingContactAddressPostalCode;
  final String? billingContactAddressCountryCode;
  ExpediaBookingUIRequestPayment({
    this.type,
    this.number,
    this.securityCode,
    this.expirationMonth,
    this.expirationYear,
    this.enrollmentDate,
    this.billingContactFirstName,
    this.billingContactLastName,
    this.billingContactAddressLine1,
    this.billingContactAddressLine2,
    this.billingContactAddressLine3,
    this.billingContactAddressCity,
    this.billingContactAddressStateProvinceCode,
    this.billingContactAddressPostalCode,
    this.billingContactAddressCountryCode,
  });
  //--------------------------------------

  ExpediaBookingUIRequestPayment copyWith({
    String? type,
    String? number,
    String? securityCode,
    String? expirationMonth,
    String? expirationYear,
    String? enrollmentDate,
    String? billingContactFirstName,
    String? billingContactLastName,
    String? billingContactAddressLine1,
    String? billingContactAddressLine2,
    String? billingContactAddressLine3,
    String? billingContactAddressCity,
    String? billingContactAddressStateProvinceCode,
    String? billingContactAddressPostalCode,
    String? billingContactAddressCountryCode,
  }) {
    return ExpediaBookingUIRequestPayment(
      type: type ?? this.type,
      number: number ?? this.number,
      securityCode: securityCode ?? this.securityCode,
      expirationMonth: expirationMonth ?? this.expirationMonth,
      expirationYear: expirationYear ?? this.expirationYear,
      enrollmentDate: enrollmentDate ?? this.enrollmentDate,
      billingContactFirstName:
          billingContactFirstName ?? this.billingContactFirstName,
      billingContactLastName:
          billingContactLastName ?? this.billingContactLastName,
      billingContactAddressLine1:
          billingContactAddressLine1 ?? this.billingContactAddressLine1,
      billingContactAddressLine2:
          billingContactAddressLine2 ?? this.billingContactAddressLine2,
      billingContactAddressLine3:
          billingContactAddressLine3 ?? this.billingContactAddressLine3,
      billingContactAddressCity:
          billingContactAddressCity ?? this.billingContactAddressCity,
      billingContactAddressStateProvinceCode:
          billingContactAddressStateProvinceCode ??
              this.billingContactAddressStateProvinceCode,
      billingContactAddressPostalCode: billingContactAddressPostalCode ??
          this.billingContactAddressPostalCode,
      billingContactAddressCountryCode: billingContactAddressCountryCode ??
          this.billingContactAddressCountryCode,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (type != null) {
      result.addAll({'type': type});
    }
    if (number != null) {
      result.addAll({'number': number});
    }
    if (securityCode != null) {
      result.addAll({'securityCode': securityCode});
    }
    if (expirationMonth != null) {
      result.addAll({'expirationMonth': expirationMonth});
    }
    if (expirationYear != null) {
      result.addAll({'expirationYear': expirationYear});
    }
    if (enrollmentDate != null) {
      result.addAll({'enrollmentDate': enrollmentDate});
    }
    if (billingContactFirstName != null) {
      result.addAll({'billingContactFirstName': billingContactFirstName});
    }
    if (billingContactLastName != null) {
      result.addAll({'billingContactLastName': billingContactLastName});
    }
    if (billingContactAddressLine1 != null) {
      result.addAll({'billingContactAddressLine1': billingContactAddressLine1});
    }
    if (billingContactAddressLine2 != null) {
      result.addAll({'billingContactAddressLine2': billingContactAddressLine2});
    }
    if (billingContactAddressLine3 != null) {
      result.addAll({'billingContactAddressLine3': billingContactAddressLine3});
    }
    if (billingContactAddressCity != null) {
      result.addAll({'billingContactAddressCity': billingContactAddressCity});
    }
    if (billingContactAddressStateProvinceCode != null) {
      result.addAll({
        'billingContactAddressStateProvinceCode':
            billingContactAddressStateProvinceCode
      });
    }
    if (billingContactAddressPostalCode != null) {
      result.addAll(
          {'billingContactAddressPostalCode': billingContactAddressPostalCode});
    }
    if (billingContactAddressCountryCode != null) {
      result.addAll({
        'billingContactAddressCountryCode': billingContactAddressCountryCode
      });
    }

    return result;
  }

  factory ExpediaBookingUIRequestPayment.fromMap(Map<String, dynamic> map) {
    return ExpediaBookingUIRequestPayment(
      type: map['type'],
      number: map['number'],
      securityCode: map['securityCode'],
      expirationMonth: map['expirationMonth'],
      expirationYear: map['expirationYear'],
      enrollmentDate: map['enrollmentDate'],
      billingContactFirstName: map['billingContactFirstName'],
      billingContactLastName: map['billingContactLastName'],
      billingContactAddressLine1: map['billingContactAddressLine1'],
      billingContactAddressLine2: map['billingContactAddressLine2'],
      billingContactAddressLine3: map['billingContactAddressLine3'],
      billingContactAddressCity: map['billingContactAddressCity'],
      billingContactAddressStateProvinceCode:
          map['billingContactAddressStateProvinceCode'],
      billingContactAddressPostalCode: map['billingContactAddressPostalCode'],
      billingContactAddressCountryCode: map['billingContactAddressCountryCode'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ExpediaBookingUIRequestPayment.fromJson(String source) =>
      ExpediaBookingUIRequestPayment.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ExpediaBookingUIRequestPayment(type: $type, number: $number, securityCode: $securityCode, expirationMonth: $expirationMonth, expirationYear: $expirationYear, enrollmentDate: $enrollmentDate, billingContactFirstName: $billingContactFirstName, billingContactLastName: $billingContactLastName, billingContactAddressLine1: $billingContactAddressLine1, billingContactAddressLine2: $billingContactAddressLine2, billingContactAddressLine3: $billingContactAddressLine3, billingContactAddressCity: $billingContactAddressCity, billingContactAddressStateProvinceCode: $billingContactAddressStateProvinceCode, billingContactAddressPostalCode: $billingContactAddressPostalCode, billingContactAddressCountryCode: $billingContactAddressCountryCode)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ExpediaBookingUIRequestPayment &&
        other.type == type &&
        other.number == number &&
        other.securityCode == securityCode &&
        other.expirationMonth == expirationMonth &&
        other.expirationYear == expirationYear &&
        other.enrollmentDate == enrollmentDate &&
        other.billingContactFirstName == billingContactFirstName &&
        other.billingContactLastName == billingContactLastName &&
        other.billingContactAddressLine1 == billingContactAddressLine1 &&
        other.billingContactAddressLine2 == billingContactAddressLine2 &&
        other.billingContactAddressLine3 == billingContactAddressLine3 &&
        other.billingContactAddressCity == billingContactAddressCity &&
        other.billingContactAddressStateProvinceCode ==
            billingContactAddressStateProvinceCode &&
        other.billingContactAddressPostalCode ==
            billingContactAddressPostalCode &&
        other.billingContactAddressCountryCode ==
            billingContactAddressCountryCode;
  }

  @override
  int get hashCode {
    return type.hashCode ^
        number.hashCode ^
        securityCode.hashCode ^
        expirationMonth.hashCode ^
        expirationYear.hashCode ^
        enrollmentDate.hashCode ^
        billingContactFirstName.hashCode ^
        billingContactLastName.hashCode ^
        billingContactAddressLine1.hashCode ^
        billingContactAddressLine2.hashCode ^
        billingContactAddressLine3.hashCode ^
        billingContactAddressCity.hashCode ^
        billingContactAddressStateProvinceCode.hashCode ^
        billingContactAddressPostalCode.hashCode ^
        billingContactAddressCountryCode.hashCode;
  }
}
