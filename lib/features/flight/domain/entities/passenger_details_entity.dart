import 'package:uuid/uuid.dart';
import 'package:yellow_rose/features/flight/domain/entities/gender.dart';
import 'package:yellow_rose/features/flight/domain/entities/passenger_department_details.dart';
import 'package:yellow_rose/features/flight/domain/entities/passenger_title.dart';
import 'package:yellow_rose/features/flight/domain/entities/passenger_type.dart';
import 'package:yellow_rose/features/flight/domain/entities/profile_type.dart';

class PassengerDetailsEntity {
  final PassengerType passengerType;
  final String id;
  final PassengerTitle title;
  final Gender gender;
  final String email;
  final String name;
  final String lastName;
  final String phoneNumber;
  final ProfileType? profileType;
  final PassengerDetailsEntity? passengerDetailsEntity;
  final DateTime? dob;
  final PassengerDepartmentDetails? passengerDepartmentDetails;
  PassengerDetailsEntity(
      {required this.passengerType,
      required this.title,
      required this.gender,
      required this.email,
      required this.name,
      required this.lastName,
      required this.phoneNumber,
      this.profileType,
      this.passengerDetailsEntity,
      this.dob,
      this.passengerDepartmentDetails,
      String? id})
      : id = id ?? const Uuid().v4();

  PassengerDetailsEntity copyWith({
    PassengerType? passengerType,
    PassengerTitle? title,
    Gender? gender,
    String? email,
    String? name,
    String? lastName,
    String? phoneNumber,
    ProfileType? profileType,
    PassengerDetailsEntity? passengerDetailsEntity,
    DateTime? dob,
    PassengerDepartmentDetails? passengerDepartmentDetails,
  }) {
    return PassengerDetailsEntity(
      passengerType: passengerType ?? this.passengerType,
      title: title ?? this.title,
      gender: gender ?? this.gender,
      email: email ?? this.email,
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profileType: profileType ?? this.profileType,
      passengerDetailsEntity:
          passengerDetailsEntity ?? this.passengerDetailsEntity,
      dob: dob ?? this.dob,
      passengerDepartmentDetails:
          passengerDepartmentDetails ?? this.passengerDepartmentDetails,
    );
  }
}
