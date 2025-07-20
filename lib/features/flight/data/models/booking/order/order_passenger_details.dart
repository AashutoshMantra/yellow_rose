import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:yellow_rose/core/utils/extensions.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order/passenger_booking_class.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order/passport_details.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order/seat_meal_segment.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order/user_visa_details.dart';
import 'package:yellow_rose/features/flight/data/models/passenger_type_enum.dart';
import 'package:yellow_rose/features/flight/data/models/rm_tag_list.dart';
import 'package:yellow_rose/features/flight/data/models/rmtags.dart';

class OrdersPassengersDetails {
  final String? username;
  final String? title;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? mobile;
  final SeatMealSegment? seatMeal;
  final String? frequentFlyerNumber;
  final PassengerBookingClasses? fareDetails;
  final String? ticketNumber;
  final String? universalPnr;
  final String? providerPnr;
  final String? csrPNR;
  final String? pnr;
  final String? pnrStatus;

  final DateTime? dob;
  final List<RmTags>? reportingTags;
  final RmTagsList? rmTags;
  final PassengerTypeEnum? passengerType;
  final String? passengerKey;
  final UserPassportDetails? userPassportDetails;
  final UserVisaDetails? userVisaDetails;
  OrdersPassengersDetails({
    this.username,
    this.title,
    this.firstName,
    this.lastName,
    this.email,
    this.mobile,
    this.seatMeal,
    this.frequentFlyerNumber,
    this.fareDetails,
    this.ticketNumber,
    this.universalPnr,
    this.providerPnr,
    this.csrPNR,
    this.pnr,
    this.pnrStatus,
    this.dob,
    this.reportingTags,
    this.rmTags,
    this.passengerType,
    this.passengerKey,
    this.userPassportDetails,
    this.userVisaDetails,
  });

  OrdersPassengersDetails copyWith({
    String? username,
    String? title,
    String? firstName,
    String? lastName,
    String? email,
    String? mobile,
    SeatMealSegment? seatMeal,
    String? frequentFlyerNumber,
    PassengerBookingClasses? fareDetails,
    String? ticketNumber,
    String? universalPnr,
    String? providerPnr,
    String? csrPNR,
    String? pnr,
    String? pnrStatus,
    DateTime? dob,
    List<RmTags>? reportingTags,
    RmTagsList? rmTags,
    PassengerTypeEnum? passengerType,
    String? passengerKey,
    UserPassportDetails? userPassportDetails,
    UserVisaDetails? userVisaDetails,
  }) {
    return OrdersPassengersDetails(
      username: username ?? this.username,
      title: title ?? this.title,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      mobile: mobile ?? this.mobile,
      seatMeal: seatMeal ?? this.seatMeal,
      frequentFlyerNumber: frequentFlyerNumber ?? this.frequentFlyerNumber,
      fareDetails: fareDetails ?? this.fareDetails,
      ticketNumber: ticketNumber ?? this.ticketNumber,
      universalPnr: universalPnr ?? this.universalPnr,
      providerPnr: providerPnr ?? this.providerPnr,
      csrPNR: csrPNR ?? this.csrPNR,
      pnr: pnr ?? this.pnr,
      pnrStatus: pnrStatus ?? this.pnrStatus,
      dob: dob ?? this.dob,
      reportingTags: reportingTags ?? this.reportingTags,
      rmTags: rmTags ?? this.rmTags,
      passengerType: passengerType ?? this.passengerType,
      passengerKey: passengerKey ?? this.passengerKey,
      userPassportDetails: userPassportDetails ?? this.userPassportDetails,
      userVisaDetails: userVisaDetails ?? this.userVisaDetails,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (username != null) {
      result.addAll({'username': username});
    }
    if (title != null) {
      result.addAll({'title': title});
    }
    if (firstName != null) {
      result.addAll({'firstName': firstName});
    }
    if (lastName != null) {
      result.addAll({'lastName': lastName});
    }
    if (email != null) {
      result.addAll({'email': email});
    }
    if (mobile != null) {
      result.addAll({'mobile': mobile});
    }
    if (seatMeal != null) {
      result.addAll({'seatMeal': seatMeal!.toMap()});
    }
    if (frequentFlyerNumber != null) {
      result.addAll({'frequentFlyerNumber': frequentFlyerNumber});
    }
    if (fareDetails != null) {
      result.addAll({'fareDetails': fareDetails!.toMap()});
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
    if (csrPNR != null) {
      result.addAll({'csrPNR': csrPNR});
    }
    if (pnr != null) {
      result.addAll({'pnr': pnr});
    }
    if (pnrStatus != null) {
      result.addAll({'pnrStatus': pnrStatus});
    }
    if (dob != null) {
      result.addAll({'dob': dob!.millisecondsSinceEpoch});
    }
    if (reportingTags != null) {
      result.addAll(
          {'reportingTags': reportingTags!.map((x) => x.toMap()).toList()});
    }
    if (rmTags != null) {
      result.addAll({'rmTags': rmTags!.toMap()});
    }
    if (passengerType != null) {
      result.addAll({'passengerType': passengerType!.name});
    }
    if (passengerKey != null) {
      result.addAll({'passengerKey': passengerKey});
    }
    if (userPassportDetails != null) {
      result.addAll({'userPassportDetails': userPassportDetails!.toMap()});
    }
    if (userVisaDetails != null) {
      result.addAll({'userVisaDetails': userVisaDetails!.toMap()});
    }

    return result;
  }

  factory OrdersPassengersDetails.fromMap(Map<String, dynamic> map) {
    return OrdersPassengersDetails(
      username: map['username'],
      title: map['title'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      email: map['email'],
      mobile: map['mobile'],
      seatMeal: map['seatMeal'] != null
          ? SeatMealSegment.fromMap(map['seatMeal'])
          : null,
      frequentFlyerNumber: map['frequentFlyerNumber'],
      fareDetails: map['fareDetails'] != null
          ? PassengerBookingClasses.fromMap(map['fareDetails'])
          : null,
      ticketNumber: map['ticketNumber'],
      universalPnr: map['universalPnr'],
      providerPnr: map['providerPnr'],
      csrPNR: map['csrPNR'],
      pnr: map['pnr'],
      pnrStatus: map['pnrStatus'],
      dob: map['dob'] != null ? DateTime.tryParse(map['dob']) : null,
      reportingTags: map['reportingTags'] != null
          ? List<RmTags>.from(
              map['reportingTags']?.map((x) => RmTags.fromMap(x)))
          : null,
      rmTags: map['rmTags'] != null ? RmTagsList.fromMap(map['rmTags']) : null,
      passengerType:
          (map['passengerType'] as String?)?.toEnum(PassengerTypeEnum.values),
      passengerKey: map['passengerKey'],
      userPassportDetails: map['userPassportDetails'] != null
          ? UserPassportDetails.fromMap(map['userPassportDetails'])
          : null,
      userVisaDetails: map['userVisaDetails'] != null
          ? UserVisaDetails.fromMap(map['userVisaDetails'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrdersPassengersDetails.fromJson(String source) =>
      OrdersPassengersDetails.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OrdersPassengersDetails(username: $username, title: $title, firstName: $firstName, lastName: $lastName, email: $email, mobile: $mobile, seatMeal: $seatMeal, frequentFlyerNumber: $frequentFlyerNumber, fareDetails: $fareDetails, ticketNumber: $ticketNumber, universalPnr: $universalPnr, providerPnr: $providerPnr, csrPNR: $csrPNR, pnr: $pnr, pnrStatus: $pnrStatus, dob: $dob, reportingTags: $reportingTags, rmTags: $rmTags, passengerType: $passengerType, passengerKey: $passengerKey, userPassportDetails: $userPassportDetails, userVisaDetails: $userVisaDetails)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrdersPassengersDetails &&
        other.username == username &&
        other.title == title &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.email == email &&
        other.mobile == mobile &&
        other.seatMeal == seatMeal &&
        other.frequentFlyerNumber == frequentFlyerNumber &&
        other.fareDetails == fareDetails &&
        other.ticketNumber == ticketNumber &&
        other.universalPnr == universalPnr &&
        other.providerPnr == providerPnr &&
        other.csrPNR == csrPNR &&
        other.pnr == pnr &&
        other.pnrStatus == pnrStatus &&
        other.dob == dob &&
        listEquals(other.reportingTags, reportingTags) &&
        other.rmTags == rmTags &&
        other.passengerType == passengerType &&
        other.passengerKey == passengerKey &&
        other.userPassportDetails == userPassportDetails &&
        other.userVisaDetails == userVisaDetails;
  }

  @override
  int get hashCode {
    return username.hashCode ^
        title.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        email.hashCode ^
        mobile.hashCode ^
        seatMeal.hashCode ^
        frequentFlyerNumber.hashCode ^
        fareDetails.hashCode ^
        ticketNumber.hashCode ^
        universalPnr.hashCode ^
        providerPnr.hashCode ^
        csrPNR.hashCode ^
        pnr.hashCode ^
        pnrStatus.hashCode ^
        dob.hashCode ^
        reportingTags.hashCode ^
        rmTags.hashCode ^
        passengerType.hashCode ^
        passengerKey.hashCode ^
        userPassportDetails.hashCode ^
        userVisaDetails.hashCode;
  }
}
