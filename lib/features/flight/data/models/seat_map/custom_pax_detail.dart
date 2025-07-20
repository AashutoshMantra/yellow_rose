import 'dart:convert';

import 'package:yellow_rose/core/utils/extensions.dart';
import 'package:yellow_rose/features/flight/data/models/passenger_type_enum.dart';
import 'package:yellow_rose/features/flight/domain/entities/passenger_type.dart';

class CustomPaxDetails {
  final PassengerType paxType;
  final String title;
  final String gender;
  final String firstName;
  final String lastName;
  CustomPaxDetails({
    required this.paxType,
    required this.title,
    required this.gender,
    required this.firstName,
    required this.lastName,
  });

  CustomPaxDetails copyWith({
    PassengerType? paxType,
    String? title,
    String? gender,
    String? firstName,
    String? lastName,
  }) {
    return CustomPaxDetails(
      paxType: paxType ?? this.paxType,
      title: title ?? this.title,
      gender: gender ?? this.gender,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'paxType': paxType.name});
    result.addAll({'title': title});
    result.addAll({'gender': gender});
    result.addAll({'firstName': firstName});
    result.addAll({'lastName': lastName});

    return result;
  }

  factory CustomPaxDetails.fromMap(Map<String, dynamic> map) {
    return CustomPaxDetails(
      paxType: (map['paxType'] as String?).toEnum(PassengerType.values)!,
      title: map['title'] ?? '',
      gender: map['gender'] ?? '',
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomPaxDetails.fromJson(String source) =>
      CustomPaxDetails.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CustomPaxDetails(paxType: $paxType, title: $title, gender: $gender, firstName: $firstName, lastName: $lastName)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CustomPaxDetails &&
        other.paxType == paxType &&
        other.title == title &&
        other.gender == gender &&
        other.firstName == firstName &&
        other.lastName == lastName;
  }

  @override
  int get hashCode {
    return paxType.hashCode ^
        title.hashCode ^
        gender.hashCode ^
        firstName.hashCode ^
        lastName.hashCode;
  }
}
