import 'dart:convert';

import 'package:yellow_rose/core/utils/date_time_parser.dart';

class Card {
  String? cvvData;
  String? identification;
  String? creditCardCode;
  String? accountNumber;
  String? name;
  String? currencyCode;
  String? receivedFrom;
  DateTime? expiryDate;
  Card({
    this.cvvData,
    this.identification,
    this.creditCardCode,
    this.accountNumber,
    this.name,
    this.currencyCode,
    this.receivedFrom,
    this.expiryDate,
  });

  Card copyWith({
    String? cvvData,
    String? identification,
    String? creditCardCode,
    String? accountNumber,
    String? name,
    String? currencyCode,
    String? receivedFrom,
    DateTime? expiryDate,
  }) {
    return Card(
      cvvData: cvvData ?? this.cvvData,
      identification: identification ?? this.identification,
      creditCardCode: creditCardCode ?? this.creditCardCode,
      accountNumber: accountNumber ?? this.accountNumber,
      name: name ?? this.name,
      currencyCode: currencyCode ?? this.currencyCode,
      receivedFrom: receivedFrom ?? this.receivedFrom,
      expiryDate: expiryDate ?? this.expiryDate,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (cvvData != null) {
      result.addAll({'cvvData': cvvData});
    }
    if (identification != null) {
      result.addAll({'identification': identification});
    }
    if (creditCardCode != null) {
      result.addAll({'creditCardCode': creditCardCode});
    }
    if (accountNumber != null) {
      result.addAll({'accountNumber': accountNumber});
    }
    if (name != null) {
      result.addAll({'name': name});
    }
    if (currencyCode != null) {
      result.addAll({'currencyCode': currencyCode});
    }
    if (receivedFrom != null) {
      result.addAll({'receivedFrom': receivedFrom});
    }
    if (expiryDate != null) {
      result.addAll({'expiryDate': expiryDate!.millisecondsSinceEpoch});
    }

    return result;
  }

  factory Card.fromMap(Map<String, dynamic> map) {
    return Card(
      cvvData: map['cvvData'],
      identification: map['identification'],
      creditCardCode: map['creditCardCode'],
      accountNumber: map['accountNumber'],
      name: map['name'],
      currencyCode: map['currencyCode'],
      receivedFrom: map['receivedFrom'],
      expiryDate: map['expiryDate'] != null
          ? DateTimeParser.tryParseFromMap(map, 'expiryDate')
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Card.fromJson(String source) => Card.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Card(cvvData: $cvvData, identification: $identification, creditCardCode: $creditCardCode, accountNumber: $accountNumber, name: $name, currencyCode: $currencyCode, receivedFrom: $receivedFrom, expiryDate: $expiryDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Card &&
        other.cvvData == cvvData &&
        other.identification == identification &&
        other.creditCardCode == creditCardCode &&
        other.accountNumber == accountNumber &&
        other.name == name &&
        other.currencyCode == currencyCode &&
        other.receivedFrom == receivedFrom &&
        other.expiryDate == expiryDate;
  }

  @override
  int get hashCode {
    return cvvData.hashCode ^
        identification.hashCode ^
        creditCardCode.hashCode ^
        accountNumber.hashCode ^
        name.hashCode ^
        currencyCode.hashCode ^
        receivedFrom.hashCode ^
        expiryDate.hashCode;
  }
}
