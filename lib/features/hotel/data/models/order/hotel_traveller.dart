import 'dart:convert';

import 'package:yellow_rose/core/utils/extensions.dart';
import 'package:yellow_rose/features/flight/domain/entities/gender.dart';

class HotelTraveler {
  final String? lastName;
  final String? title;
  final String? firstName;
  final String? isdCode;
  final String? emailId;
  final String? mobileNo;
  final bool? masterPax;
  final String? paxType;
  final Gender? gender;
  HotelTraveler({
    this.lastName,
    this.title,
    this.firstName,
    this.isdCode,
    this.emailId,
    this.mobileNo,
    this.masterPax,
    this.paxType,
    this.gender,
  });

  HotelTraveler copyWith({
    String? lastName,
    String? title,
    String? firstName,
    String? isdCode,
    String? emailId,
    String? mobileNo,
    bool? masterPax,
    String? paxType,
    Gender? gender,
  }) {
    return HotelTraveler(
      lastName: lastName ?? this.lastName,
      title: title ?? this.title,
      firstName: firstName ?? this.firstName,
      isdCode: isdCode ?? this.isdCode,
      emailId: emailId ?? this.emailId,
      mobileNo: mobileNo ?? this.mobileNo,
      masterPax: masterPax ?? this.masterPax,
      paxType: paxType ?? this.paxType,
      gender: gender ?? this.gender,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (lastName != null) {
      result.addAll({'lastName': lastName});
    }
    if (title != null) {
      result.addAll({'title': title});
    }
    if (firstName != null) {
      result.addAll({'firstName': firstName});
    }
    if (isdCode != null) {
      result.addAll({'isdCode': isdCode});
    }
    if (emailId != null) {
      result.addAll({'emailId': emailId});
    }
    if (mobileNo != null) {
      result.addAll({'mobileNo': mobileNo});
    }
    if (masterPax != null) {
      result.addAll({'masterPax': masterPax});
    }
    if (paxType != null) {
      result.addAll({'paxType': paxType});
    }
    if (gender != null) {
      result.addAll({'gender': gender!.name});
    }

    return result;
  }

  factory HotelTraveler.fromMap(Map<String, dynamic> map) {
    return HotelTraveler(
      lastName: map['lastName'],
      title: map['title'],
      firstName: map['firstName'],
      isdCode: map['isdCode'],
      emailId: map['emailId'],
      mobileNo: map['mobileNo'],
      masterPax: map['masterPax'],
      paxType: map['paxType'],
      gender: map['gender'] != null
          ? stringToEnum(map['gender'], Gender.values)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory HotelTraveler.fromJson(String source) =>
      HotelTraveler.fromMap(json.decode(source));

  @override
  String toString() {
    return 'HotelTraveler(lastName: $lastName, title: $title, firstName: $firstName, isdCode: $isdCode, emailId: $emailId, mobileNo: $mobileNo, masterPax: $masterPax, paxType: $paxType, gender: $gender)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HotelTraveler &&
        other.lastName == lastName &&
        other.title == title &&
        other.firstName == firstName &&
        other.isdCode == isdCode &&
        other.emailId == emailId &&
        other.mobileNo == mobileNo &&
        other.masterPax == masterPax &&
        other.paxType == paxType &&
        other.gender == gender;
  }

  @override
  int get hashCode {
    return lastName.hashCode ^
        title.hashCode ^
        firstName.hashCode ^
        isdCode.hashCode ^
        emailId.hashCode ^
        mobileNo.hashCode ^
        masterPax.hashCode ^
        paxType.hashCode ^
        gender.hashCode;
  }
}
