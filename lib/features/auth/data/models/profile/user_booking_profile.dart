import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:yellow_rose/features/auth/data/models/profile/user_credit_card_info.dart';
import 'package:yellow_rose/features/auth/data/models/profile/user_profile_contact_details.dart';
import 'package:yellow_rose/features/auth/data/models/profile/user_profile_reporting_detail.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order/passport_details.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order/user_visa_details.dart';

class UserBookingProfile {
  final int? profile_id;

  final String? bookingProfileUuid;

  final String? parentUserUid;

  final String? foreignKey;

  final String? username;

  final String? userUid;

  final String? title;

  final String? firstName;

  final String? middleName;

  final String? lastName;

  final String? aliasName;

  final DateTime? dob;

  final String? gender;

  final String? designation;
  final String? band;

  final String? department;

  final String? location;

  final String? queueNo;

  final String? ownerPCC;

  final String? corporateSSR;

  final String? osi;

  final String? division;

  final String? extraCommands;

  final String? remarks;

  final String? frequentFlierInfo;

  final String? carMembershipInfo;

  final String? hotelMembershipInfo;

  final String? documentDetails;

  final String? emailDetails;

  final String? phoneDetails;

  final bool? updateFrequentFlierInfo;

  final String? accountCode;

  final String? costCenter;

  final String? employeeCode;

  final String? projectCode;

  final String? clientEmployeeCode;

  final String? billingEntity;

  final String? contactNumber;

  final String? primaryPhone;

  final String? secondaryPhone;

  final String? phoneExt;

  final String? email;

  final String? ccEmail;

  final String? tempCcEmail;

  final bool? IsCcEmailNotify;

  final String? emergencyInfo;

  final String? residencyCountry;

  final String? domesticEligibility;

  final String? internationalEligibility;

  final String? domSeatPref;

  final String? intlSeatPref;

  final String? domMealPref;

  final String? intlMealPref;

  final String? intlSpecialPref;

  final String? domSpecialPref;

  final String? domMealComment;

  final String? intlMealComment;

  final String? supervisorCodes;

  final bool? approver = false;

  final String? approvalLimit;

  final String? metaInfo;

  final String? executiveAssistants;

  final String? delegatingSupervisor;

  final String? profileType;

  final String? travelArranger1;

  final String? travelArranger2;

  final String? nationality;

  final String? businessGroupCode;

  final String? dateOfTermination;

  final String? dateOfJoining;

  final String? supervisor1;

  final String? supervisor2;

  final String? supervisor3;

  final String? supervisor4;

  final List<UserPassportDetails>? passportDetails;

  final List<UserVisaDetails>? visaDetails;

  final List<UserProfileContactDetails>? permanentContactDetails;
  final List<UserCreditCardInfo>? creditCardList;

  final UserProfileReportingDetails? reportingDetails;
  UserBookingProfile({
    this.profile_id,
    this.bookingProfileUuid,
    this.parentUserUid,
    this.foreignKey,
    this.username,
    this.userUid,
    this.title,
    this.firstName,
    this.middleName,
    this.lastName,
    this.aliasName,
    this.dob,
    this.gender,
    this.designation,
    this.band,
    this.department,
    this.location,
    this.queueNo,
    this.ownerPCC,
    this.corporateSSR,
    this.osi,
    this.division,
    this.extraCommands,
    this.remarks,
    this.frequentFlierInfo,
    this.carMembershipInfo,
    this.hotelMembershipInfo,
    this.documentDetails,
    this.emailDetails,
    this.phoneDetails,
    this.updateFrequentFlierInfo,
    this.accountCode,
    this.costCenter,
    this.employeeCode,
    this.projectCode,
    this.clientEmployeeCode,
    this.billingEntity,
    this.contactNumber,
    this.primaryPhone,
    this.secondaryPhone,
    this.phoneExt,
    this.email,
    this.ccEmail,
    this.tempCcEmail,
    this.IsCcEmailNotify,
    this.emergencyInfo,
    this.residencyCountry,
    this.domesticEligibility,
    this.internationalEligibility,
    this.domSeatPref,
    this.intlSeatPref,
    this.domMealPref,
    this.intlMealPref,
    this.intlSpecialPref,
    this.domSpecialPref,
    this.domMealComment,
    this.intlMealComment,
    this.supervisorCodes,
    this.approvalLimit,
    this.metaInfo,
    this.executiveAssistants,
    this.delegatingSupervisor,
    this.profileType,
    this.travelArranger1,
    this.travelArranger2,
    this.nationality,
    this.businessGroupCode,
    this.dateOfTermination,
    this.dateOfJoining,
    this.supervisor1,
    this.supervisor2,
    this.supervisor3,
    this.supervisor4,
    this.passportDetails,
    this.visaDetails,
    this.permanentContactDetails,
    this.creditCardList,
    this.reportingDetails,
  });

  UserBookingProfile copyWith({
    int? profile_id,
    String? bookingProfileUuid,
    String? parentUserUid,
    String? foreignKey,
    String? username,
    String? userUid,
    String? title,
    String? firstName,
    String? middleName,
    String? lastName,
    String? aliasName,
    DateTime? dob,
    String? gender,
    String? designation,
    String? band,
    String? department,
    String? location,
    String? queueNo,
    String? ownerPCC,
    String? corporateSSR,
    String? osi,
    String? division,
    String? extraCommands,
    String? remarks,
    String? frequentFlierInfo,
    String? carMembershipInfo,
    String? hotelMembershipInfo,
    String? documentDetails,
    String? emailDetails,
    String? phoneDetails,
    bool? updateFrequentFlierInfo,
    String? accountCode,
    String? costCenter,
    String? employeeCode,
    String? projectCode,
    String? clientEmployeeCode,
    String? billingEntity,
    String? contactNumber,
    String? primaryPhone,
    String? secondaryPhone,
    String? phoneExt,
    String? email,
    String? ccEmail,
    String? tempCcEmail,
    bool? IsCcEmailNotify,
    String? emergencyInfo,
    String? residencyCountry,
    String? domesticEligibility,
    String? internationalEligibility,
    String? domSeatPref,
    String? intlSeatPref,
    String? domMealPref,
    String? intlMealPref,
    String? intlSpecialPref,
    String? domSpecialPref,
    String? domMealComment,
    String? intlMealComment,
    String? supervisorCodes,
    String? approvalLimit,
    String? metaInfo,
    String? executiveAssistants,
    String? delegatingSupervisor,
    String? profileType,
    String? travelArranger1,
    String? travelArranger2,
    String? nationality,
    String? businessGroupCode,
    String? dateOfTermination,
    String? dateOfJoining,
    String? supervisor1,
    String? supervisor2,
    String? supervisor3,
    String? supervisor4,
    List<UserPassportDetails>? passportDetails,
    List<UserVisaDetails>? visaDetails,
    List<UserProfileContactDetails>? permanentContactDetails,
    List<UserCreditCardInfo>? creditCardList,
    UserProfileReportingDetails? reportingDetails,
  }) {
    return UserBookingProfile(
      profile_id: profile_id ?? this.profile_id,
      bookingProfileUuid: bookingProfileUuid ?? this.bookingProfileUuid,
      parentUserUid: parentUserUid ?? this.parentUserUid,
      foreignKey: foreignKey ?? this.foreignKey,
      username: username ?? this.username,
      userUid: userUid ?? this.userUid,
      title: title ?? this.title,
      firstName: firstName ?? this.firstName,
      middleName: middleName ?? this.middleName,
      lastName: lastName ?? this.lastName,
      aliasName: aliasName ?? this.aliasName,
      dob: dob ?? this.dob,
      gender: gender ?? this.gender,
      designation: designation ?? this.designation,
      band: band ?? this.band,
      department: department ?? this.department,
      location: location ?? this.location,
      queueNo: queueNo ?? this.queueNo,
      ownerPCC: ownerPCC ?? this.ownerPCC,
      corporateSSR: corporateSSR ?? this.corporateSSR,
      osi: osi ?? this.osi,
      division: division ?? this.division,
      extraCommands: extraCommands ?? this.extraCommands,
      remarks: remarks ?? this.remarks,
      frequentFlierInfo: frequentFlierInfo ?? this.frequentFlierInfo,
      carMembershipInfo: carMembershipInfo ?? this.carMembershipInfo,
      hotelMembershipInfo: hotelMembershipInfo ?? this.hotelMembershipInfo,
      documentDetails: documentDetails ?? this.documentDetails,
      emailDetails: emailDetails ?? this.emailDetails,
      phoneDetails: phoneDetails ?? this.phoneDetails,
      updateFrequentFlierInfo:
          updateFrequentFlierInfo ?? this.updateFrequentFlierInfo,
      accountCode: accountCode ?? this.accountCode,
      costCenter: costCenter ?? this.costCenter,
      employeeCode: employeeCode ?? this.employeeCode,
      projectCode: projectCode ?? this.projectCode,
      clientEmployeeCode: clientEmployeeCode ?? this.clientEmployeeCode,
      billingEntity: billingEntity ?? this.billingEntity,
      contactNumber: contactNumber ?? this.contactNumber,
      primaryPhone: primaryPhone ?? this.primaryPhone,
      secondaryPhone: secondaryPhone ?? this.secondaryPhone,
      phoneExt: phoneExt ?? this.phoneExt,
      email: email ?? this.email,
      ccEmail: ccEmail ?? this.ccEmail,
      tempCcEmail: tempCcEmail ?? this.tempCcEmail,
      IsCcEmailNotify: IsCcEmailNotify ?? this.IsCcEmailNotify,
      emergencyInfo: emergencyInfo ?? this.emergencyInfo,
      residencyCountry: residencyCountry ?? this.residencyCountry,
      domesticEligibility: domesticEligibility ?? this.domesticEligibility,
      internationalEligibility:
          internationalEligibility ?? this.internationalEligibility,
      domSeatPref: domSeatPref ?? this.domSeatPref,
      intlSeatPref: intlSeatPref ?? this.intlSeatPref,
      domMealPref: domMealPref ?? this.domMealPref,
      intlMealPref: intlMealPref ?? this.intlMealPref,
      intlSpecialPref: intlSpecialPref ?? this.intlSpecialPref,
      domSpecialPref: domSpecialPref ?? this.domSpecialPref,
      domMealComment: domMealComment ?? this.domMealComment,
      intlMealComment: intlMealComment ?? this.intlMealComment,
      supervisorCodes: supervisorCodes ?? this.supervisorCodes,
      approvalLimit: approvalLimit ?? this.approvalLimit,
      metaInfo: metaInfo ?? this.metaInfo,
      executiveAssistants: executiveAssistants ?? this.executiveAssistants,
      delegatingSupervisor: delegatingSupervisor ?? this.delegatingSupervisor,
      profileType: profileType ?? this.profileType,
      travelArranger1: travelArranger1 ?? this.travelArranger1,
      travelArranger2: travelArranger2 ?? this.travelArranger2,
      nationality: nationality ?? this.nationality,
      businessGroupCode: businessGroupCode ?? this.businessGroupCode,
      dateOfTermination: dateOfTermination ?? this.dateOfTermination,
      dateOfJoining: dateOfJoining ?? this.dateOfJoining,
      supervisor1: supervisor1 ?? this.supervisor1,
      supervisor2: supervisor2 ?? this.supervisor2,
      supervisor3: supervisor3 ?? this.supervisor3,
      supervisor4: supervisor4 ?? this.supervisor4,
      passportDetails: passportDetails ?? this.passportDetails,
      visaDetails: visaDetails ?? this.visaDetails,
      permanentContactDetails:
          permanentContactDetails ?? this.permanentContactDetails,
      creditCardList: creditCardList ?? this.creditCardList,
      reportingDetails: reportingDetails ?? this.reportingDetails,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (profile_id != null) {
      result.addAll({'profile_id': profile_id});
    }
    if (bookingProfileUuid != null) {
      result.addAll({'bookingProfileUuid': bookingProfileUuid});
    }
    if (parentUserUid != null) {
      result.addAll({'parentUserUid': parentUserUid});
    }
    if (foreignKey != null) {
      result.addAll({'foreignKey': foreignKey});
    }
    if (username != null) {
      result.addAll({'username': username});
    }
    if (userUid != null) {
      result.addAll({'userUid': userUid});
    }
    if (title != null) {
      result.addAll({'title': title});
    }
    if (firstName != null) {
      result.addAll({'firstName': firstName});
    }
    if (middleName != null) {
      result.addAll({'middleName': middleName});
    }
    if (lastName != null) {
      result.addAll({'lastName': lastName});
    }
    if (aliasName != null) {
      result.addAll({'aliasName': aliasName});
    }
    if (dob != null) {
      result.addAll({'dob': dob!.millisecondsSinceEpoch});
    }
    if (gender != null) {
      result.addAll({'gender': gender});
    }
    if (designation != null) {
      result.addAll({'designation': designation});
    }
    if (band != null) {
      result.addAll({'band': band});
    }
    if (department != null) {
      result.addAll({'department': department});
    }
    if (location != null) {
      result.addAll({'location': location});
    }
    if (queueNo != null) {
      result.addAll({'queueNo': queueNo});
    }
    if (ownerPCC != null) {
      result.addAll({'ownerPCC': ownerPCC});
    }
    if (corporateSSR != null) {
      result.addAll({'corporateSSR': corporateSSR});
    }
    if (osi != null) {
      result.addAll({'osi': osi});
    }
    if (division != null) {
      result.addAll({'division': division});
    }
    if (extraCommands != null) {
      result.addAll({'extraCommands': extraCommands});
    }
    if (remarks != null) {
      result.addAll({'remarks': remarks});
    }
    if (frequentFlierInfo != null) {
      result.addAll({'frequentFlierInfo': frequentFlierInfo});
    }
    if (carMembershipInfo != null) {
      result.addAll({'carMembershipInfo': carMembershipInfo});
    }
    if (hotelMembershipInfo != null) {
      result.addAll({'hotelMembershipInfo': hotelMembershipInfo});
    }
    if (documentDetails != null) {
      result.addAll({'documentDetails': documentDetails});
    }
    if (emailDetails != null) {
      result.addAll({'emailDetails': emailDetails});
    }
    if (phoneDetails != null) {
      result.addAll({'phoneDetails': phoneDetails});
    }
    if (updateFrequentFlierInfo != null) {
      result.addAll({'updateFrequentFlierInfo': updateFrequentFlierInfo});
    }
    if (accountCode != null) {
      result.addAll({'accountCode': accountCode});
    }
    if (costCenter != null) {
      result.addAll({'costCenter': costCenter});
    }
    if (employeeCode != null) {
      result.addAll({'employeeCode': employeeCode});
    }
    if (projectCode != null) {
      result.addAll({'projectCode': projectCode});
    }
    if (clientEmployeeCode != null) {
      result.addAll({'clientEmployeeCode': clientEmployeeCode});
    }
    if (billingEntity != null) {
      result.addAll({'billingEntity': billingEntity});
    }
    if (contactNumber != null) {
      result.addAll({'contactNumber': contactNumber});
    }
    if (primaryPhone != null) {
      result.addAll({'primaryPhone': primaryPhone});
    }
    if (secondaryPhone != null) {
      result.addAll({'secondaryPhone': secondaryPhone});
    }
    if (phoneExt != null) {
      result.addAll({'phoneExt': phoneExt});
    }
    if (email != null) {
      result.addAll({'email': email});
    }
    if (ccEmail != null) {
      result.addAll({'ccEmail': ccEmail});
    }
    if (tempCcEmail != null) {
      result.addAll({'tempCcEmail': tempCcEmail});
    }
    if (IsCcEmailNotify != null) {
      result.addAll({'IsCcEmailNotify': IsCcEmailNotify});
    }
    if (emergencyInfo != null) {
      result.addAll({'emergencyInfo': emergencyInfo});
    }
    if (residencyCountry != null) {
      result.addAll({'residencyCountry': residencyCountry});
    }
    if (domesticEligibility != null) {
      result.addAll({'domesticEligibility': domesticEligibility});
    }
    if (internationalEligibility != null) {
      result.addAll({'internationalEligibility': internationalEligibility});
    }
    if (domSeatPref != null) {
      result.addAll({'domSeatPref': domSeatPref});
    }
    if (intlSeatPref != null) {
      result.addAll({'intlSeatPref': intlSeatPref});
    }
    if (domMealPref != null) {
      result.addAll({'domMealPref': domMealPref});
    }
    if (intlMealPref != null) {
      result.addAll({'intlMealPref': intlMealPref});
    }
    if (intlSpecialPref != null) {
      result.addAll({'intlSpecialPref': intlSpecialPref});
    }
    if (domSpecialPref != null) {
      result.addAll({'domSpecialPref': domSpecialPref});
    }
    if (domMealComment != null) {
      result.addAll({'domMealComment': domMealComment});
    }
    if (intlMealComment != null) {
      result.addAll({'intlMealComment': intlMealComment});
    }
    if (supervisorCodes != null) {
      result.addAll({'supervisorCodes': supervisorCodes});
    }
    if (approvalLimit != null) {
      result.addAll({'approvalLimit': approvalLimit});
    }
    if (metaInfo != null) {
      result.addAll({'metaInfo': metaInfo});
    }
    if (executiveAssistants != null) {
      result.addAll({'executiveAssistants': executiveAssistants});
    }
    if (delegatingSupervisor != null) {
      result.addAll({'delegatingSupervisor': delegatingSupervisor});
    }
    if (profileType != null) {
      result.addAll({'profileType': profileType});
    }
    if (travelArranger1 != null) {
      result.addAll({'travelArranger1': travelArranger1});
    }
    if (travelArranger2 != null) {
      result.addAll({'travelArranger2': travelArranger2});
    }
    if (nationality != null) {
      result.addAll({'nationality': nationality});
    }
    if (businessGroupCode != null) {
      result.addAll({'businessGroupCode': businessGroupCode});
    }
    if (dateOfTermination != null) {
      result.addAll({'dateOfTermination': dateOfTermination});
    }
    if (dateOfJoining != null) {
      result.addAll({'dateOfJoining': dateOfJoining});
    }
    if (supervisor1 != null) {
      result.addAll({'supervisor1': supervisor1});
    }
    if (supervisor2 != null) {
      result.addAll({'supervisor2': supervisor2});
    }
    if (supervisor3 != null) {
      result.addAll({'supervisor3': supervisor3});
    }
    if (supervisor4 != null) {
      result.addAll({'supervisor4': supervisor4});
    }
    if (passportDetails != null) {
      result.addAll(
          {'passportDetails': passportDetails!.map((x) => x.toMap()).toList()});
    }
    if (visaDetails != null) {
      result
          .addAll({'visaDetails': visaDetails!.map((x) => x.toMap()).toList()});
    }
    if (permanentContactDetails != null) {
      result.addAll({
        'permanentContactDetails':
            permanentContactDetails!.map((x) => x.toMap()).toList()
      });
    }
    if (creditCardList != null) {
      result.addAll(
          {'creditCardList': creditCardList!.map((x) => x.toMap()).toList()});
    }
    if (reportingDetails != null) {
      result.addAll({'reportingDetails': reportingDetails!.toMap()});
    }

    return result;
  }

  factory UserBookingProfile.fromMap(Map<String, dynamic> map) {
    return UserBookingProfile(
      profile_id: map['profile_id']?.toInt(),
      bookingProfileUuid: map['bookingProfileUuid'],
      parentUserUid: map['parentUserUid'],
      foreignKey: map['foreignKey'],
      username: map['username'],
      userUid: map['userUid'],
      title: map['title'],
      firstName: map['firstName'],
      middleName: map['middleName'],
      lastName: map['lastName'],
      aliasName: map['aliasName'],
      dob: map['dob'] != null ? DateTime.tryParse(map['dob']) : null,
      gender: map['gender'],
      designation: map['designation'],
      band: map['band'],
      department: map['department'],
      location: map['location'],
      queueNo: map['queueNo'],
      ownerPCC: map['ownerPCC'],
      corporateSSR: map['corporateSSR'],
      osi: map['osi'],
      division: map['division'],
      extraCommands: map['extraCommands'],
      remarks: map['remarks'],
      frequentFlierInfo: map['frequentFlierInfo'],
      carMembershipInfo: map['carMembershipInfo'],
      hotelMembershipInfo: map['hotelMembershipInfo'],
      documentDetails: map['documentDetails'],
      emailDetails: map['emailDetails'],
      phoneDetails: map['phoneDetails'],
      updateFrequentFlierInfo: map['updateFrequentFlierInfo'],
      accountCode: map['accountCode'],
      costCenter: map['costCenter'],
      employeeCode: map['employeeCode'],
      projectCode: map['projectCode'],
      clientEmployeeCode: map['clientEmployeeCode'],
      billingEntity: map['billingEntity'],
      contactNumber: map['contactNumber'],
      primaryPhone: map['primaryPhone'],
      secondaryPhone: map['secondaryPhone'],
      phoneExt: map['phoneExt'],
      email: map['email'],
      ccEmail: map['ccEmail'],
      tempCcEmail: map['tempCcEmail'],
      IsCcEmailNotify: map['IsCcEmailNotify'],
      emergencyInfo: map['emergencyInfo'],
      residencyCountry: map['residencyCountry'],
      domesticEligibility: map['domesticEligibility'],
      internationalEligibility: map['internationalEligibility'],
      domSeatPref: map['domSeatPref'],
      intlSeatPref: map['intlSeatPref'],
      domMealPref: map['domMealPref'],
      intlMealPref: map['intlMealPref'],
      intlSpecialPref: map['intlSpecialPref'],
      domSpecialPref: map['domSpecialPref'],
      domMealComment: map['domMealComment'],
      intlMealComment: map['intlMealComment'],
      supervisorCodes: map['supervisorCodes'],
      approvalLimit: map['approvalLimit'],
      metaInfo: map['metaInfo'],
      executiveAssistants: map['executiveAssistants'],
      delegatingSupervisor: map['delegatingSupervisor'],
      profileType: map['profileType'],
      travelArranger1: map['travelArranger1'],
      travelArranger2: map['travelArranger2'],
      nationality: map['nationality'],
      businessGroupCode: map['businessGroupCode'],
      dateOfTermination: map['dateOfTermination'],
      dateOfJoining: map['dateOfJoining'],
      supervisor1: map['supervisor1'],
      supervisor2: map['supervisor2'],
      supervisor3: map['supervisor3'],
      supervisor4: map['supervisor4'],
      passportDetails: map['passportDetails'] != null
          ? List<UserPassportDetails>.from(map['passportDetails']
              ?.map((x) => UserPassportDetails.fromMap(x)))
          : null,
      visaDetails: map['visaDetails'] != null
          ? List<UserVisaDetails>.from(
              map['visaDetails']?.map((x) => UserVisaDetails.fromMap(x)))
          : null,
      permanentContactDetails: map['permanentContactDetails'] != null
          ? List<UserProfileContactDetails>.from(map['permanentContactDetails']
              ?.map((x) => UserProfileContactDetails.fromMap(x)))
          : null,
      creditCardList: map['creditCardList'] != null
          ? List<UserCreditCardInfo>.from(
              map['creditCardList']?.map((x) => UserCreditCardInfo.fromMap(x)))
          : null,
      reportingDetails: map['reportingDetails'] != null
          ? UserProfileReportingDetails.fromMap(map['reportingDetails'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserBookingProfile.fromJson(String source) =>
      UserBookingProfile.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserBookingProfile(profile_id: $profile_id, bookingProfileUuid: $bookingProfileUuid, parentUserUid: $parentUserUid, foreignKey: $foreignKey, username: $username, userUid: $userUid, title: $title, firstName: $firstName, middleName: $middleName, lastName: $lastName, aliasName: $aliasName, dob: $dob, gender: $gender, designation: $designation, band: $band, department: $department, location: $location, queueNo: $queueNo, ownerPCC: $ownerPCC, corporateSSR: $corporateSSR, osi: $osi, division: $division, extraCommands: $extraCommands, remarks: $remarks, frequentFlierInfo: $frequentFlierInfo, carMembershipInfo: $carMembershipInfo, hotelMembershipInfo: $hotelMembershipInfo, documentDetails: $documentDetails, emailDetails: $emailDetails, phoneDetails: $phoneDetails, updateFrequentFlierInfo: $updateFrequentFlierInfo, accountCode: $accountCode, costCenter: $costCenter, employeeCode: $employeeCode, projectCode: $projectCode, clientEmployeeCode: $clientEmployeeCode, billingEntity: $billingEntity, contactNumber: $contactNumber, primaryPhone: $primaryPhone, secondaryPhone: $secondaryPhone, phoneExt: $phoneExt, email: $email, ccEmail: $ccEmail, tempCcEmail: $tempCcEmail, IsCcEmailNotify: $IsCcEmailNotify, emergencyInfo: $emergencyInfo, residencyCountry: $residencyCountry, domesticEligibility: $domesticEligibility, internationalEligibility: $internationalEligibility, domSeatPref: $domSeatPref, intlSeatPref: $intlSeatPref, domMealPref: $domMealPref, intlMealPref: $intlMealPref, intlSpecialPref: $intlSpecialPref, domSpecialPref: $domSpecialPref, domMealComment: $domMealComment, intlMealComment: $intlMealComment, supervisorCodes: $supervisorCodes, approvalLimit: $approvalLimit, metaInfo: $metaInfo, executiveAssistants: $executiveAssistants, delegatingSupervisor: $delegatingSupervisor, profileType: $profileType, travelArranger1: $travelArranger1, travelArranger2: $travelArranger2, nationality: $nationality, businessGroupCode: $businessGroupCode, dateOfTermination: $dateOfTermination, dateOfJoining: $dateOfJoining, supervisor1: $supervisor1, supervisor2: $supervisor2, supervisor3: $supervisor3, supervisor4: $supervisor4, passportDetails: $passportDetails, visaDetails: $visaDetails, permanentContactDetails: $permanentContactDetails, creditCardList: $creditCardList, reportingDetails: $reportingDetails)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserBookingProfile &&
        other.profile_id == profile_id &&
        other.bookingProfileUuid == bookingProfileUuid &&
        other.parentUserUid == parentUserUid &&
        other.foreignKey == foreignKey &&
        other.username == username &&
        other.userUid == userUid &&
        other.title == title &&
        other.firstName == firstName &&
        other.middleName == middleName &&
        other.lastName == lastName &&
        other.aliasName == aliasName &&
        other.dob == dob &&
        other.gender == gender &&
        other.designation == designation &&
        other.band == band &&
        other.department == department &&
        other.location == location &&
        other.queueNo == queueNo &&
        other.ownerPCC == ownerPCC &&
        other.corporateSSR == corporateSSR &&
        other.osi == osi &&
        other.division == division &&
        other.extraCommands == extraCommands &&
        other.remarks == remarks &&
        other.frequentFlierInfo == frequentFlierInfo &&
        other.carMembershipInfo == carMembershipInfo &&
        other.hotelMembershipInfo == hotelMembershipInfo &&
        other.documentDetails == documentDetails &&
        other.emailDetails == emailDetails &&
        other.phoneDetails == phoneDetails &&
        other.updateFrequentFlierInfo == updateFrequentFlierInfo &&
        other.accountCode == accountCode &&
        other.costCenter == costCenter &&
        other.employeeCode == employeeCode &&
        other.projectCode == projectCode &&
        other.clientEmployeeCode == clientEmployeeCode &&
        other.billingEntity == billingEntity &&
        other.contactNumber == contactNumber &&
        other.primaryPhone == primaryPhone &&
        other.secondaryPhone == secondaryPhone &&
        other.phoneExt == phoneExt &&
        other.email == email &&
        other.ccEmail == ccEmail &&
        other.tempCcEmail == tempCcEmail &&
        other.IsCcEmailNotify == IsCcEmailNotify &&
        other.emergencyInfo == emergencyInfo &&
        other.residencyCountry == residencyCountry &&
        other.domesticEligibility == domesticEligibility &&
        other.internationalEligibility == internationalEligibility &&
        other.domSeatPref == domSeatPref &&
        other.intlSeatPref == intlSeatPref &&
        other.domMealPref == domMealPref &&
        other.intlMealPref == intlMealPref &&
        other.intlSpecialPref == intlSpecialPref &&
        other.domSpecialPref == domSpecialPref &&
        other.domMealComment == domMealComment &&
        other.intlMealComment == intlMealComment &&
        other.supervisorCodes == supervisorCodes &&
        other.approvalLimit == approvalLimit &&
        other.metaInfo == metaInfo &&
        other.executiveAssistants == executiveAssistants &&
        other.delegatingSupervisor == delegatingSupervisor &&
        other.profileType == profileType &&
        other.travelArranger1 == travelArranger1 &&
        other.travelArranger2 == travelArranger2 &&
        other.nationality == nationality &&
        other.businessGroupCode == businessGroupCode &&
        other.dateOfTermination == dateOfTermination &&
        other.dateOfJoining == dateOfJoining &&
        other.supervisor1 == supervisor1 &&
        other.supervisor2 == supervisor2 &&
        other.supervisor3 == supervisor3 &&
        other.supervisor4 == supervisor4 &&
        listEquals(other.passportDetails, passportDetails) &&
        listEquals(other.visaDetails, visaDetails) &&
        listEquals(other.permanentContactDetails, permanentContactDetails) &&
        listEquals(other.creditCardList, creditCardList) &&
        other.reportingDetails == reportingDetails;
  }

  @override
  int get hashCode {
    return profile_id.hashCode ^
        bookingProfileUuid.hashCode ^
        parentUserUid.hashCode ^
        foreignKey.hashCode ^
        username.hashCode ^
        userUid.hashCode ^
        title.hashCode ^
        firstName.hashCode ^
        middleName.hashCode ^
        lastName.hashCode ^
        aliasName.hashCode ^
        dob.hashCode ^
        gender.hashCode ^
        designation.hashCode ^
        band.hashCode ^
        department.hashCode ^
        location.hashCode ^
        queueNo.hashCode ^
        ownerPCC.hashCode ^
        corporateSSR.hashCode ^
        osi.hashCode ^
        division.hashCode ^
        extraCommands.hashCode ^
        remarks.hashCode ^
        frequentFlierInfo.hashCode ^
        carMembershipInfo.hashCode ^
        hotelMembershipInfo.hashCode ^
        documentDetails.hashCode ^
        emailDetails.hashCode ^
        phoneDetails.hashCode ^
        updateFrequentFlierInfo.hashCode ^
        accountCode.hashCode ^
        costCenter.hashCode ^
        employeeCode.hashCode ^
        projectCode.hashCode ^
        clientEmployeeCode.hashCode ^
        billingEntity.hashCode ^
        contactNumber.hashCode ^
        primaryPhone.hashCode ^
        secondaryPhone.hashCode ^
        phoneExt.hashCode ^
        email.hashCode ^
        ccEmail.hashCode ^
        tempCcEmail.hashCode ^
        IsCcEmailNotify.hashCode ^
        emergencyInfo.hashCode ^
        residencyCountry.hashCode ^
        domesticEligibility.hashCode ^
        internationalEligibility.hashCode ^
        domSeatPref.hashCode ^
        intlSeatPref.hashCode ^
        domMealPref.hashCode ^
        intlMealPref.hashCode ^
        intlSpecialPref.hashCode ^
        domSpecialPref.hashCode ^
        domMealComment.hashCode ^
        intlMealComment.hashCode ^
        supervisorCodes.hashCode ^
        approvalLimit.hashCode ^
        metaInfo.hashCode ^
        executiveAssistants.hashCode ^
        delegatingSupervisor.hashCode ^
        profileType.hashCode ^
        travelArranger1.hashCode ^
        travelArranger2.hashCode ^
        nationality.hashCode ^
        businessGroupCode.hashCode ^
        dateOfTermination.hashCode ^
        dateOfJoining.hashCode ^
        supervisor1.hashCode ^
        supervisor2.hashCode ^
        supervisor3.hashCode ^
        supervisor4.hashCode ^
        passportDetails.hashCode ^
        visaDetails.hashCode ^
        permanentContactDetails.hashCode ^
        creditCardList.hashCode ^
        reportingDetails.hashCode;
  }
}
