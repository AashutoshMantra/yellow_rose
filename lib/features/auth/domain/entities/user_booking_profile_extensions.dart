import 'package:yellow_rose/features/auth/data/models/profile/user_booking_profile.dart';
import 'package:yellow_rose/features/flight/domain/entities/gender.dart';
import 'package:yellow_rose/features/flight/domain/entities/passenger_details_entity.dart';
import 'package:yellow_rose/features/flight/domain/entities/passenger_title.dart';
import 'package:yellow_rose/features/flight/domain/entities/passenger_type.dart';

extension UserBookingProfileExtension on UserBookingProfile {
  PassengerDetailsEntity toPassengerDetailsEntity({PassengerType? passengerType}) {
    return PassengerDetailsEntity(
      passengerType: passengerType ?? PassengerType.ADT,
      title: _mapTitle(title),
      gender: _mapGender(gender),
      email: email ?? '',
      name: firstName ?? '',
      lastName: lastName ?? '',
      phoneNumber: primaryPhone ?? contactNumber ?? '',
      dob: dob,
      id: bookingProfileUuid ?? userUid,
    );
  }

  PassengerTitle _mapTitle(String? title) {
    switch (title?.toLowerCase()) {
      case 'mr':
      case 'mr.':
        return PassengerTitle.Mr;
      case 'ms':
      case 'ms.':
      case 'miss':
        return PassengerTitle.Ms;
      case 'mrs':
      case 'mrs.':
        return PassengerTitle.Mrs;
      default:
        return PassengerTitle.Mr;
    }
  }

  Gender _mapGender(String? gender) {
    switch (gender?.toLowerCase()) {
      case 'male':
      case 'm':
        return Gender.Male;
      case 'female':
      case 'f':
        return Gender.Female;
      default:
        return Gender.Male;
    }
  }

  String get displayName {
    final parts = <String>[];
    if (title != null) parts.add(title!);
    if (firstName != null) parts.add(firstName!);
    if (lastName != null) parts.add(lastName!);
    return parts.join(' ').trim();
  }

  String get searchableText {
    final parts = <String>[];
    if (firstName != null) parts.add(firstName!);
    if (lastName != null) parts.add(lastName!);
    if (email != null) parts.add(email!);
    if (primaryPhone != null) parts.add(primaryPhone!);
    if (contactNumber != null) parts.add(contactNumber!);
    if (department != null) parts.add(department!);
    return parts.join(' ').toLowerCase();
  }

  /// Check if profile matches given passenger type based on age
  bool matchesPassengerType(PassengerType passengerType) {
    if (dob == null) {
      // If no DOB, only match adult profiles
      return passengerType == PassengerType.ADT;
    }
    return passengerType == PassengerType.ADT;

    final now = DateTime.now();
    final age = now.year - dob!.year;
    final hasHadBirthdayThisYear = now.month > dob!.month ||
        (now.month == dob!.month && now.day >= dob!.day);
    final actualAge = hasHadBirthdayThisYear ? age : age - 1;

    switch (passengerType) {
      case PassengerType.ADT:
        return actualAge >= 12;
      case PassengerType.CHD:
        return actualAge >= 2 && actualAge < 12;
      case PassengerType.INFT:
        return actualAge < 2;
    }
  }
}
