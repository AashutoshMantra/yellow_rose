import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:yellow_rose/core/utils/date_time_parser.dart';
import 'package:yellow_rose/core/utils/date_utils.dart';
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
  final int? id;

  final String? orderUuid;
  final String? itineraryUuid;
  final String? specialRequest;
  final String? profileType;
  final String? phoneNumber;
  final String? profileId;
  final String? passengerUserUid;
  final bool? ticketIssuance;
  final String? empId;
  final String? hotelBookingId;
  final int? age;
  final String? hotelBookingStatus;
  final String? passiveStatus;
  final String? docIssuanceStatus;
  final String? seatNumber;
  final String? seatMealSource;
  final String? mealPreferences;
  final int? rescheduledPassengerRef;
  final DateTime? creationTs;
  final DateTime? firstDepartureTime;
  final DateTime? cancellationTs;
  final DateTime? modTs;
  final Map<String, dynamic>? webCheckin;
  final Map<String, dynamic>? webCheckinRequest;
  final Map<String, dynamic>? errorDetails;
  final Map<String, dynamic>? commissionData;
  final Map<String, dynamic>? markUpData;
  final Map<String, dynamic>? taxComponent;
  final Map<String, dynamic>? rescheduleComponent;
  final Map<String, dynamic>? cancellationCharges;
  final Map<String, dynamic>? rescheduleCharges;

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
    this.id,
    this.orderUuid,
    this.itineraryUuid,
    this.specialRequest,
    this.profileType,
    this.phoneNumber,
    this.profileId,
    this.passengerUserUid,
    this.ticketIssuance,
    this.empId,
    this.hotelBookingId,
    this.age,
    this.hotelBookingStatus,
    this.passiveStatus,
    this.docIssuanceStatus,
    this.seatNumber,
    this.seatMealSource,
    this.mealPreferences,
    this.rescheduledPassengerRef,
    this.creationTs,
    this.firstDepartureTime,
    this.cancellationTs,
    this.modTs,
    this.webCheckin,
    this.webCheckinRequest,
    this.errorDetails,
    this.commissionData,
    this.markUpData,
    this.taxComponent,
    this.rescheduleComponent,
    this.cancellationCharges,
    this.rescheduleCharges,
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
    int? id,
    String? orderUuid,
    String? itineraryUuid,
    String? specialRequest,
    String? profileType,
    String? phoneNumber,
    String? profileId,
    String? passengerUserUid,
    bool? ticketIssuance,
    String? empId,
    String? hotelBookingId,
    int? age,
    String? hotelBookingStatus,
    String? passiveStatus,
    String? docIssuanceStatus,
    String? seatNumber,
    String? seatMealSource,
    String? mealPreferences,
    int? rescheduledPassengerRef,
    DateTime? creationTs,
    DateTime? firstDepartureTime,
    DateTime? cancellationTs,
    DateTime? modTs,
    Map<String, dynamic>? webCheckin,
    Map<String, dynamic>? webCheckinRequest,
    Map<String, dynamic>? errorDetails,
    Map<String, dynamic>? commissionData,
    Map<String, dynamic>? markUpData,
    Map<String, dynamic>? taxComponent,
    Map<String, dynamic>? rescheduleComponent,
    Map<String, dynamic>? cancellationCharges,
    Map<String, dynamic>? rescheduleCharges,
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
      id: id ?? this.id,
      orderUuid: orderUuid ?? this.orderUuid,
      itineraryUuid: itineraryUuid ?? this.itineraryUuid,
      specialRequest: specialRequest ?? this.specialRequest,
      profileType: profileType ?? this.profileType,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profileId: profileId ?? this.profileId,
      passengerUserUid: passengerUserUid ?? this.passengerUserUid,
      ticketIssuance: ticketIssuance ?? this.ticketIssuance,
      empId: empId ?? this.empId,
      hotelBookingId: hotelBookingId ?? this.hotelBookingId,
      age: age ?? this.age,
      hotelBookingStatus: hotelBookingStatus ?? this.hotelBookingStatus,
      passiveStatus: passiveStatus ?? this.passiveStatus,
      docIssuanceStatus: docIssuanceStatus ?? this.docIssuanceStatus,
      seatNumber: seatNumber ?? this.seatNumber,
      seatMealSource: seatMealSource ?? this.seatMealSource,
      mealPreferences: mealPreferences ?? this.mealPreferences,
      rescheduledPassengerRef:
          rescheduledPassengerRef ?? this.rescheduledPassengerRef,
      creationTs: creationTs ?? this.creationTs,
      firstDepartureTime: firstDepartureTime ?? this.firstDepartureTime,
      cancellationTs: cancellationTs ?? this.cancellationTs,
      modTs: modTs ?? this.modTs,
      webCheckin: webCheckin ?? this.webCheckin,
      webCheckinRequest: webCheckinRequest ?? this.webCheckinRequest,
      errorDetails: errorDetails ?? this.errorDetails,
      commissionData: commissionData ?? this.commissionData,
      markUpData: markUpData ?? this.markUpData,
      taxComponent: taxComponent ?? this.taxComponent,
      rescheduleComponent: rescheduleComponent ?? this.rescheduleComponent,
      cancellationCharges: cancellationCharges ?? this.cancellationCharges,
      rescheduleCharges: rescheduleCharges ?? this.rescheduleCharges,
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
      result.addAll(
          {'dob': CustomDateUtils.dateTimeInIsoFormatWithoutZone(dob!)});
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
    if (id != null) {
      result.addAll({'id': id});
    }
    if (orderUuid != null) {
      result.addAll({'orderUuid': orderUuid});
    }
    if (itineraryUuid != null) {
      result.addAll({'itineraryUuid': itineraryUuid});
    }
    if (specialRequest != null) {
      result.addAll({'specialRequest': specialRequest});
    }
    if (profileType != null) {
      result.addAll({'profileType': profileType});
    }
    if (phoneNumber != null) {
      result.addAll({'phoneNumber': phoneNumber});
    }
    if (profileId != null) {
      result.addAll({'profileId': profileId});
    }
    if (passengerUserUid != null) {
      result.addAll({'passengerUserUid': passengerUserUid});
    }
    if (ticketIssuance != null) {
      result.addAll({'ticketIssuance': ticketIssuance});
    }
    if (empId != null) {
      result.addAll({'empId': empId});
    }
    if (hotelBookingId != null) {
      result.addAll({'hotelBookingId': hotelBookingId});
    }
    if (age != null) {
      result.addAll({'age': age});
    }
    if (hotelBookingStatus != null) {
      result.addAll({'hotelBookingStatus': hotelBookingStatus});
    }
    if (passiveStatus != null) {
      result.addAll({'passiveStatus': passiveStatus});
    }
    if (docIssuanceStatus != null) {
      result.addAll({'docIssuanceStatus': docIssuanceStatus});
    }
    if (seatNumber != null) {
      result.addAll({'seatNumber': seatNumber});
    }
    if (seatMealSource != null) {
      result.addAll({'seatMealSource': seatMealSource});
    }
    if (mealPreferences != null) {
      result.addAll({'mealPreferences': mealPreferences});
    }
    if (rescheduledPassengerRef != null) {
      result.addAll({'rescheduledPassengerRef': rescheduledPassengerRef});
    }
    if (creationTs != null) {
      result.addAll({
        'creationTs':
            CustomDateUtils.dateTimeInIsoFormatWithoutZone(creationTs!)
      });
    }
    if (firstDepartureTime != null) {
      result.addAll({
        'firstDepartureTime':
            CustomDateUtils.dateTimeInIsoFormatWithoutZone(firstDepartureTime!)
      });
    }
    if (cancellationTs != null) {
      result.addAll({
        'cancellationTs':
            CustomDateUtils.dateTimeInIsoFormatWithoutZone(cancellationTs!)
      });
    }
    if (modTs != null) {
      result.addAll(
          {'modTs': CustomDateUtils.dateTimeInIsoFormatWithoutZone(modTs!)});
    }
    if (webCheckin != null) {
      result.addAll({'webCheckin': webCheckin});
    }
    if (webCheckinRequest != null) {
      result.addAll({'webCheckinRequest': webCheckinRequest});
    }
    if (errorDetails != null) {
      result.addAll({'errorDetails': errorDetails});
    }
    if (commissionData != null) {
      result.addAll({'commissionData': commissionData});
    }
    if (markUpData != null) {
      result.addAll({'markUpData': markUpData});
    }
    if (taxComponent != null) {
      result.addAll({'taxComponent': taxComponent});
    }
    if (rescheduleComponent != null) {
      result.addAll({'rescheduleComponent': rescheduleComponent});
    }
    if (cancellationCharges != null) {
      result.addAll({'cancellationCharges': cancellationCharges});
    }
    if (rescheduleCharges != null) {
      result.addAll({'rescheduleCharges': rescheduleCharges});
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
        dob: map['dob'] != null
            ? DateTimeParser.tryParseFromMap(map, 'dob')
            : null,
        reportingTags: map['reportingTags'] != null
            ? List<RmTags>.from(
                map['reportingTags']?.map((x) => RmTags.fromMap(x)))
            : null,
        rmTags:
            map['rmTags'] != null ? RmTagsList.fromMap(map['rmTags']) : null,
        passengerType:
            (map['passengerType'] as String?)?.toEnum(PassengerTypeEnum.values),
        passengerKey: map['passengerKey'],
        userPassportDetails: map['userPassportDetails'] != null
            ? UserPassportDetails.fromMap(map['userPassportDetails'] is String
                ? json.decode(map['userPassportDetails'])
                : map['userPassportDetails'])
            : null,
        userVisaDetails: map['userVisaDetails'] != null
            ? UserVisaDetails.fromMap(map['userVisaDetails'] is String
                ? json.decode(map['userVisaDetails'])
                : map['userVisaDetails'])
            : null,
        id: map['id'],
        orderUuid: map['orderUuid'],
        itineraryUuid: map['itineraryUuid'],
        specialRequest: map['specialRequest'],
        profileType: map['profileType'],
        phoneNumber: map['phoneNumber'],
        profileId: map['profileId'],
        passengerUserUid: map['passengerUserUid'],
        ticketIssuance: map['ticketIssuance'],
        empId: map['empId'],
        hotelBookingId: map['hotelBookingId'],
        age: map['age'],
        hotelBookingStatus: map['hotelBookingStatus'],
        passiveStatus: map['passiveStatus'],
        docIssuanceStatus: map['docIssuanceStatus'],
        seatNumber: map['seatNumber'],
        seatMealSource: map['seatMealSource'],
        mealPreferences: map['mealPreferences'],
        rescheduledPassengerRef: map['rescheduledPassengerRef'],
        creationTs: map['creationTs'] != null
            ? DateTimeParser.tryParseFromMap(map, 'creationTs')
            : null,
        firstDepartureTime: map['firstDepartureTime'] != null
            ? DateTimeParser.tryParseFromMap(map, 'firstDepartureTime')
            : null,
        cancellationTs: map['cancellationTs'] != null
            ? DateTimeParser.tryParseFromMap(map, 'cancellationTs')
            : null,
        modTs: map['modTs'] != null
            ? DateTimeParser.tryParseFromMap(map, 'modTs')
            : null,
        webCheckin: map['webCheckin'] != null
            ? Map<String, dynamic>.from(map['webCheckin'])
            : null,
        webCheckinRequest: map['webCheckinRequest'] != null
            ? Map<String, dynamic>.from(map['webCheckinRequest'])
            : null,
        errorDetails: map['errorDetails'] != null
            ? Map<String, dynamic>.from(map['errorDetails'])
            : null,
        commissionData: map['commissionData'] != null
            ? Map<String, dynamic>.from(map['commissionData'])
            : null,
        markUpData: map['markUpData'] != null ? Map<String, dynamic>.from(map['markUpData']) : null,
        taxComponent: map['taxComponent'] != null ? Map<String, dynamic>.from(map['taxComponent']) : null,
        rescheduleComponent: map['rescheduleComponent'] != null ? Map<String, dynamic>.from(map['rescheduleComponent']) : null,
        cancellationCharges: map['cancellationCharges'] != null ? Map<String, dynamic>.from(map['cancellationCharges']) : null,
        rescheduleCharges: map['rescheduleCharges'] != null ? Map<String, dynamic>.from(map['rescheduleCharges']) : null);
  }

  String toJson() => json.encode(toMap());

  factory OrdersPassengersDetails.fromJson(String source) =>
      OrdersPassengersDetails.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OrdersPassengersDetails(username: $username, title: $title, firstName: $firstName, lastName: $lastName, email: $email, mobile: $mobile, seatMeal: $seatMeal, frequentFlyerNumber: $frequentFlyerNumber, fareDetails: $fareDetails, ticketNumber: $ticketNumber, universalPnr: $universalPnr, providerPnr: $providerPnr, csrPNR: $csrPNR, pnr: $pnr, pnrStatus: $pnrStatus, dob: $dob, reportingTags: $reportingTags, rmTags: $rmTags, passengerType: $passengerType, passengerKey: $passengerKey, userPassportDetails: $userPassportDetails, userVisaDetails: $userVisaDetails, id: $id, orderUuid: $orderUuid, itineraryUuid: $itineraryUuid, specialRequest: $specialRequest, profileType: $profileType, phoneNumber: $phoneNumber, profileId: $profileId, passengerUserUid: $passengerUserUid, ticketIssuance: $ticketIssuance, empId: $empId, hotelBookingId: $hotelBookingId, age: $age, hotelBookingStatus: $hotelBookingStatus, passiveStatus: $passiveStatus, docIssuanceStatus: $docIssuanceStatus, seatNumber: $seatNumber, seatMealSource: $seatMealSource, mealPreferences: $mealPreferences, rescheduledPassengerRef: $rescheduledPassengerRef, creationTs: $creationTs, firstDepartureTime: $firstDepartureTime, cancellationTs: $cancellationTs, modTs: $modTs, webCheckin: $webCheckin, webCheckinRequest: $webCheckinRequest, errorDetails: $errorDetails, commissionData: $commissionData, markUpData: $markUpData, taxComponent: $taxComponent, rescheduleComponent: $rescheduleComponent, cancellationCharges: $cancellationCharges, rescheduleCharges: $rescheduleCharges)';
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
        other.userVisaDetails == userVisaDetails &&
        other.id == id &&
        other.orderUuid == orderUuid &&
        other.itineraryUuid == itineraryUuid &&
        other.specialRequest == specialRequest &&
        other.profileType == profileType &&
        other.phoneNumber == phoneNumber &&
        other.profileId == profileId &&
        other.passengerUserUid == passengerUserUid &&
        other.ticketIssuance == ticketIssuance &&
        other.empId == empId &&
        other.hotelBookingId == hotelBookingId &&
        other.age == age &&
        other.hotelBookingStatus == hotelBookingStatus &&
        other.passiveStatus == passiveStatus &&
        other.docIssuanceStatus == docIssuanceStatus &&
        other.seatNumber == seatNumber &&
        other.seatMealSource == seatMealSource &&
        other.mealPreferences == mealPreferences &&
        other.rescheduledPassengerRef == rescheduledPassengerRef &&
        other.creationTs == creationTs &&
        other.firstDepartureTime == firstDepartureTime &&
        other.cancellationTs == cancellationTs &&
        other.modTs == modTs &&
        mapEquals(other.webCheckin, webCheckin) &&
        mapEquals(other.webCheckinRequest, webCheckinRequest) &&
        mapEquals(other.errorDetails, errorDetails) &&
        mapEquals(other.commissionData, commissionData) &&
        mapEquals(other.markUpData, markUpData) &&
        mapEquals(other.taxComponent, taxComponent) &&
        mapEquals(other.rescheduleComponent, rescheduleComponent) &&
        mapEquals(other.cancellationCharges, cancellationCharges) &&
        mapEquals(other.rescheduleCharges, rescheduleCharges);
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
        userVisaDetails.hashCode ^
        id.hashCode ^
        orderUuid.hashCode ^
        itineraryUuid.hashCode ^
        specialRequest.hashCode ^
        profileType.hashCode ^
        phoneNumber.hashCode ^
        profileId.hashCode ^
        passengerUserUid.hashCode ^
        ticketIssuance.hashCode ^
        empId.hashCode ^
        hotelBookingId.hashCode ^
        age.hashCode ^
        hotelBookingStatus.hashCode ^
        passiveStatus.hashCode ^
        docIssuanceStatus.hashCode ^
        seatNumber.hashCode ^
        seatMealSource.hashCode ^
        mealPreferences.hashCode ^
        rescheduledPassengerRef.hashCode ^
        creationTs.hashCode ^
        firstDepartureTime.hashCode ^
        cancellationTs.hashCode ^
        modTs.hashCode ^
        webCheckin.hashCode ^
        webCheckinRequest.hashCode ^
        errorDetails.hashCode ^
        commissionData.hashCode ^
        markUpData.hashCode ^
        taxComponent.hashCode ^
        rescheduleComponent.hashCode ^
        cancellationCharges.hashCode ^
        rescheduleCharges.hashCode;
  }
}
