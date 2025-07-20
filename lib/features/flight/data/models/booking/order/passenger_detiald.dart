import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:yellow_rose/core/utils/extensions.dart';

import 'package:yellow_rose/features/flight/data/models/booking/order/flight_detail_preference.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order/gst_booking_detaild.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order/passport_details.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order/segment.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order/user_visa_details.dart';
import 'package:yellow_rose/features/flight/data/models/passenger_type_enum.dart';
import 'package:yellow_rose/features/flight/data/models/rmtags.dart';

class PassengerDetails {
  final PassengerTypeEnum? passengerType;
  final String? passengerTitle;
  final String? firstName;
  final String? lastName;
  final String? username;
  final String? mobile;
  final String? email;
  final String? empId;
  final String? gender;
  final String? ticketNumber;
  final String? universalPnr;
  final String? providerPnr;
  final String? profileType;
  final String? csrPNR;
  final String? pnr;
  final String? specialRequest;
  final GstBookingDetails? gstBookingDetails;
  final UserPassportDetails? userPassportDetails;
  final UserVisaDetails? userVisaDetails;

  final DateTime? dob;
  final List<Segment>? seatMeal;
  final List<RmTags>? reportingTags;
  final String? passengerKey;
  final List<FlightDetailsWithPassengerPreferences>?
      flightDetailsWithPassengerPreferences;
  PassengerDetails({
    this.passengerType,
    this.passengerTitle,
    this.firstName,
    this.lastName,
    this.username,
    this.mobile,
    this.email,
    this.empId,
    this.gender,
    this.ticketNumber,
    this.universalPnr,
    this.providerPnr,
    this.profileType,
    this.csrPNR,
    this.pnr,
    this.specialRequest,
    this.gstBookingDetails,
    this.userPassportDetails,
    this.userVisaDetails,
    this.dob,
    this.seatMeal,
    this.reportingTags,
    this.passengerKey,
    this.flightDetailsWithPassengerPreferences,
  });

  PassengerDetails copyWith({
    PassengerTypeEnum? passengerType,
    String? passengerTitle,
    String? firstName,
    String? lastName,
    String? username,
    String? mobile,
    String? email,
    String? empId,
    String? gender,
    String? ticketNumber,
    String? universalPnr,
    String? providerPnr,
    String? profileType,
    String? csrPNR,
    String? pnr,
    String? specialRequest,
    GstBookingDetails? gstBookingDetails,
    UserPassportDetails? userPassportDetails,
    UserVisaDetails? userVisaDetails,
    DateTime? dob,
    List<Segment>? seatMeal,
    List<RmTags>? reportingTags,
    String? passengerKey,
    List<FlightDetailsWithPassengerPreferences>?
        flightDetailsWithPassengerPreferences,
  }) {
    return PassengerDetails(
      passengerType: passengerType ?? this.passengerType,
      passengerTitle: passengerTitle ?? this.passengerTitle,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      username: username ?? this.username,
      mobile: mobile ?? this.mobile,
      email: email ?? this.email,
      empId: empId ?? this.empId,
      gender: gender ?? this.gender,
      ticketNumber: ticketNumber ?? this.ticketNumber,
      universalPnr: universalPnr ?? this.universalPnr,
      providerPnr: providerPnr ?? this.providerPnr,
      profileType: profileType ?? this.profileType,
      csrPNR: csrPNR ?? this.csrPNR,
      pnr: pnr ?? this.pnr,
      specialRequest: specialRequest ?? this.specialRequest,
      gstBookingDetails: gstBookingDetails ?? this.gstBookingDetails,
      userPassportDetails: userPassportDetails ?? this.userPassportDetails,
      userVisaDetails: userVisaDetails ?? this.userVisaDetails,
      dob: dob ?? this.dob,
      seatMeal: seatMeal ?? this.seatMeal,
      reportingTags: reportingTags ?? this.reportingTags,
      passengerKey: passengerKey ?? this.passengerKey,
      flightDetailsWithPassengerPreferences:
          flightDetailsWithPassengerPreferences ??
              this.flightDetailsWithPassengerPreferences,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (passengerType != null) {
      result.addAll({'passengerType': passengerType!.name});
    }
    if (passengerTitle != null) {
      result.addAll({'passengerTitle': passengerTitle});
    }
    if (firstName != null) {
      result.addAll({'firstName': firstName});
    }
    if (lastName != null) {
      result.addAll({'lastName': lastName});
    }
    if (username != null) {
      result.addAll({'username': username});
    }
    if (mobile != null) {
      result.addAll({'mobile': mobile});
    }
    if (email != null) {
      result.addAll({'email': email});
    }
    if (empId != null) {
      result.addAll({'empId': empId});
    }
    if (gender != null) {
      result.addAll({'gender': gender});
    }
    if (ticketNumber != null) {
      result.addAll({'ticketNumber': ticketNumber});
    }
    if (universalPnr != null) {
      result.addAll({'universalPnr': universalPnr});
    }
    if (providerPnr != null) {
      result.addAll({'providerPnr': providerPnr});
    }
    if (profileType != null) {
      result.addAll({'profileType': profileType});
    }
    if (csrPNR != null) {
      result.addAll({'csrPNR': csrPNR});
    }
    if (pnr != null) {
      result.addAll({'pnr': pnr});
    }
    if (specialRequest != null) {
      result.addAll({'specialRequest': specialRequest});
    }
    if (gstBookingDetails != null) {
      result.addAll({'gstBookingDetails': gstBookingDetails!.toMap()});
    }
    if (userPassportDetails != null) {
      result.addAll({'userPassportDetails': userPassportDetails!.toMap()});
    }
    if (userVisaDetails != null) {
      result.addAll({'userVisaDetails': userVisaDetails!.toMap()});
    }
    if (dob != null) {
      result.addAll({'dob': dob!.millisecondsSinceEpoch});
    }
    if (seatMeal != null) {
      result.addAll({'seatMeal': seatMeal!.map((x) => x.toMap()).toList()});
    }
    if (reportingTags != null) {
      result.addAll(
          {'reportingTags': reportingTags!.map((x) => x.toMap()).toList()});
    }
    if (passengerKey != null) {
      result.addAll({'passengerKey': passengerKey});
    }
    if (flightDetailsWithPassengerPreferences != null) {
      result.addAll({
        'flightDetailsWithPassengerPreferences':
            flightDetailsWithPassengerPreferences!
                .map((x) => x.toMap())
                .toList()
      });
    }

    return result;
  }

  factory PassengerDetails.fromMap(Map<String, dynamic> map) {
    return PassengerDetails(
      passengerType:( map['passengerType'] as String?)?.toEnum(PassengerTypeEnum.values),
      passengerTitle: map['passengerTitle'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      username: map['username'],
      mobile: map['mobile'],
      email: map['email'],
      empId: map['empId'],
      gender: map['gender'],
      ticketNumber: map['ticketNumber'],
      universalPnr: map['universalPnr'],
      providerPnr: map['providerPnr'],
      profileType: map['profileType'],
      csrPNR: map['csrPNR'],
      pnr: map['pnr'],
      specialRequest: map['specialRequest'],
      gstBookingDetails: map['gstBookingDetails'] != null
          ? GstBookingDetails.fromMap(map['gstBookingDetails'])
          : null,
      userPassportDetails: map['userPassportDetails'] != null
          ? UserPassportDetails.fromMap(map['userPassportDetails'])
          : null,
      userVisaDetails: map['userVisaDetails'] != null
          ? UserVisaDetails.fromMap(map['userVisaDetails'])
          : null,
      dob: map['dob'] != null
          ? DateTime.tryParse(map['dob'])
          : null,
      seatMeal: map['seatMeal'] != null
          ? List<Segment>.from(map['seatMeal']?.map((x) => Segment.fromMap(x)))
          : null,
      reportingTags: map['reportingTags'] != null
          ? List<RmTags>.from(
              map['reportingTags']?.map((x) => RmTags.fromMap(x)))
          : null,
      passengerKey: map['passengerKey'],
      flightDetailsWithPassengerPreferences:
          map['flightDetailsWithPassengerPreferences'] != null
              ? List<FlightDetailsWithPassengerPreferences>.from(
                  map['flightDetailsWithPassengerPreferences']?.map(
                      (x) => FlightDetailsWithPassengerPreferences.fromMap(x)))
              : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PassengerDetails.fromJson(String source) =>
      PassengerDetails.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PassengerDetails(passengerType: $passengerType, passengerTitle: $passengerTitle, firstName: $firstName, lastName: $lastName, username: $username, mobile: $mobile, email: $email, empId: $empId, gender: $gender, ticketNumber: $ticketNumber, universalPnr: $universalPnr, providerPnr: $providerPnr, profileType: $profileType, csrPNR: $csrPNR, pnr: $pnr, specialRequest: $specialRequest, gstBookingDetails: $gstBookingDetails, userPassportDetails: $userPassportDetails, userVisaDetails: $userVisaDetails, dob: $dob, seatMeal: $seatMeal, reportingTags: $reportingTags, passengerKey: $passengerKey, flightDetailsWithPassengerPreferences: $flightDetailsWithPassengerPreferences)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PassengerDetails &&
        other.passengerType == passengerType &&
        other.passengerTitle == passengerTitle &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.username == username &&
        other.mobile == mobile &&
        other.email == email &&
        other.empId == empId &&
        other.gender == gender &&
        other.ticketNumber == ticketNumber &&
        other.universalPnr == universalPnr &&
        other.providerPnr == providerPnr &&
        other.profileType == profileType &&
        other.csrPNR == csrPNR &&
        other.pnr == pnr &&
        other.specialRequest == specialRequest &&
        other.gstBookingDetails == gstBookingDetails &&
        other.userPassportDetails == userPassportDetails &&
        other.userVisaDetails == userVisaDetails &&
        other.dob == dob &&
        listEquals(other.seatMeal, seatMeal) &&
        listEquals(other.reportingTags, reportingTags) &&
        other.passengerKey == passengerKey &&
        listEquals(other.flightDetailsWithPassengerPreferences,
            flightDetailsWithPassengerPreferences);
  }

  @override
  int get hashCode {
    return passengerType.hashCode ^
        passengerTitle.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        username.hashCode ^
        mobile.hashCode ^
        email.hashCode ^
        empId.hashCode ^
        gender.hashCode ^
        ticketNumber.hashCode ^
        universalPnr.hashCode ^
        providerPnr.hashCode ^
        profileType.hashCode ^
        csrPNR.hashCode ^
        pnr.hashCode ^
        specialRequest.hashCode ^
        gstBookingDetails.hashCode ^
        userPassportDetails.hashCode ^
        userVisaDetails.hashCode ^
        dob.hashCode ^
        seatMeal.hashCode ^
        reportingTags.hashCode ^
        passengerKey.hashCode ^
        flightDetailsWithPassengerPreferences.hashCode;
  }
}
