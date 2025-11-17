import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:yellow_rose/core/utils/extensions.dart';

import 'package:yellow_rose/features/flight/data/models/booking/order/customer_payment.dart';
import 'package:yellow_rose/features/flight/data/models/passenger_type_enum.dart';

class BusOrderPassengerDetails {
  final int? id;
  final String? orderUuid;

  final String? itineraryUuid;

  final String? username;

  final String? specialRequest;

  final String? profileType;

  final String? phoneNumber;

  final String? email;

  final String? profileId;

  final String? passengerUserUid;

  final String? empId;

  final String? address;

  final String? idNumber;

  final String? idType;

  final int? mobile;

  final int? age;

  final String? gender;

  final String? primary;

  final String? busBookingStatus;

  final String? ticketNumber;

  final String? title;

  final String? firstName;

  final String? lastName;

  final String? seatNumber;

  final PassengerTypeEnum? passengerType;

  final String? creationTs;

  final String? firstDepartureTime;

  final String cancellationTs;

  final String modTs;

  final String dob;

  final Map<String, dynamic>? errorDetails;

  final Map<String, dynamic>? commissionData;

  final CustomerPayment? customerPayment;
  BusOrderPassengerDetails({
    this.id,
    this.orderUuid,
    this.itineraryUuid,
    this.username,
    this.specialRequest,
    this.profileType,
    this.phoneNumber,
    this.email,
    this.profileId,
    this.passengerUserUid,
    this.empId,
    this.address,
    this.idNumber,
    this.idType,
    this.mobile,
    this.age,
    this.gender,
    this.primary,
    this.busBookingStatus,
    this.ticketNumber,
    this.title,
    this.firstName,
    this.lastName,
    this.seatNumber,
    this.passengerType,
    this.creationTs,
    this.firstDepartureTime,
    required this.cancellationTs,
    required this.modTs,
    required this.dob,
    this.errorDetails,
    this.commissionData,
    this.customerPayment,
  });

  // @Column(name="MarkUpData", columnDefinition = "json")
  // @Type(JsonType.class)
  // final Object markUpData;

  // @Column(name="FareDetails", columnDefinition = "json")
  // @Type(JsonType.class)
  // final Object fareDetails;

  // @Column(name="RMTags", columnDefinition = "json")
  // @Type(JsonType.class)
  // final Object rmTags;

  // @Column(name="SourceCancellationCharges", columnDefinition = "json")
  // @Type(JsonType.class)
  // final Object sourceCancellationCharges;

  // @Column(name="CancellationCharges", columnDefinition = "json")
  // @Type(JsonType.class)
  // final Object cancellationCharges;

  BusOrderPassengerDetails copyWith({
    int? id,
    String? orderUuid,
    String? itineraryUuid,
    String? username,
    String? specialRequest,
    String? profileType,
    String? phoneNumber,
    String? email,
    String? profileId,
    String? passengerUserUid,
    String? empId,
    String? address,
    String? idNumber,
    String? idType,
    int? mobile,
    int? age,
    String? gender,
    String? primary,
    String? busBookingStatus,
    String? ticketNumber,
    String? title,
    String? firstName,
    String? lastName,
    String? seatNumber,
    PassengerTypeEnum? passengerType,
    String? creationTs,
    String? firstDepartureTime,
    String? cancellationTs,
    String? modTs,
    String? dob,
    Map<String, dynamic>? errorDetails,
    Map<String, dynamic>? commissionData,
    CustomerPayment? customerPayment,
  }) {
    return BusOrderPassengerDetails(
      id: id ?? this.id,
      orderUuid: orderUuid ?? this.orderUuid,
      itineraryUuid: itineraryUuid ?? this.itineraryUuid,
      username: username ?? this.username,
      specialRequest: specialRequest ?? this.specialRequest,
      profileType: profileType ?? this.profileType,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      profileId: profileId ?? this.profileId,
      passengerUserUid: passengerUserUid ?? this.passengerUserUid,
      empId: empId ?? this.empId,
      address: address ?? this.address,
      idNumber: idNumber ?? this.idNumber,
      idType: idType ?? this.idType,
      mobile: mobile ?? this.mobile,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      primary: primary ?? this.primary,
      busBookingStatus: busBookingStatus ?? this.busBookingStatus,
      ticketNumber: ticketNumber ?? this.ticketNumber,
      title: title ?? this.title,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      seatNumber: seatNumber ?? this.seatNumber,
      passengerType: passengerType ?? this.passengerType,
      creationTs: creationTs ?? this.creationTs,
      firstDepartureTime: firstDepartureTime ?? this.firstDepartureTime,
      cancellationTs: cancellationTs ?? this.cancellationTs,
      modTs: modTs ?? this.modTs,
      dob: dob ?? this.dob,
      errorDetails: errorDetails ?? this.errorDetails,
      commissionData: commissionData ?? this.commissionData,
      customerPayment: customerPayment ?? this.customerPayment,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (orderUuid != null) {
      result.addAll({'orderUuid': orderUuid});
    }
    if (itineraryUuid != null) {
      result.addAll({'itineraryUuid': itineraryUuid});
    }
    if (username != null) {
      result.addAll({'username': username});
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
    if (email != null) {
      result.addAll({'email': email});
    }
    if (profileId != null) {
      result.addAll({'profileId': profileId});
    }
    if (passengerUserUid != null) {
      result.addAll({'passengerUserUid': passengerUserUid});
    }
    if (empId != null) {
      result.addAll({'empId': empId});
    }
    if (address != null) {
      result.addAll({'address': address});
    }
    if (idNumber != null) {
      result.addAll({'idNumber': idNumber});
    }
    if (idType != null) {
      result.addAll({'idType': idType});
    }
    if (mobile != null) {
      result.addAll({'mobile': mobile});
    }
    if (age != null) {
      result.addAll({'age': age});
    }
    if (gender != null) {
      result.addAll({'gender': gender});
    }
    if (primary != null) {
      result.addAll({'primary': primary});
    }
    if (busBookingStatus != null) {
      result.addAll({'busBookingStatus': busBookingStatus});
    }
    if (ticketNumber != null) {
      result.addAll({'ticketNumber': ticketNumber});
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
    if (seatNumber != null) {
      result.addAll({'seatNumber': seatNumber});
    }
    if (passengerType != null) {
      result.addAll({'passengerType': passengerType!.name});
    }
    if (creationTs != null) {
      result.addAll({'creationTs': creationTs});
    }
    if (firstDepartureTime != null) {
      result.addAll({'firstDepartureTime': firstDepartureTime});
    }
    result.addAll({'cancellationTs': cancellationTs});
    result.addAll({'modTs': modTs});
    result.addAll({'dob': dob});
    if (errorDetails != null) {
      result.addAll({'errorDetails': errorDetails});
    }
    if (commissionData != null) {
      result.addAll({'commissionData': commissionData});
    }
    if (customerPayment != null) {
      result.addAll({'customerPayment': customerPayment!.toMap()});
    }

    return result;
  }

  factory BusOrderPassengerDetails.fromMap(Map<String, dynamic> map) {
    return BusOrderPassengerDetails(
      id: map['id']?.toInt(),
      orderUuid: map['orderUuid'],
      itineraryUuid: map['itineraryUuid'],
      username: map['username'],
      specialRequest: map['specialRequest'],
      profileType: map['profileType'],
      phoneNumber: map['phoneNumber'],
      email: map['email'],
      profileId: map['profileId'],
      passengerUserUid: map['passengerUserUid'],
      empId: map['empId'],
      address: map['address'],
      idNumber: map['idNumber'],
      idType: map['idType'],
      mobile: map['mobile']?.toInt(),
      age: map['age']?.toInt(),
      gender: map['gender'],
      primary: map['primary'],
      busBookingStatus: map['busBookingStatus'],
      ticketNumber: map['ticketNumber'],
      title: map['title'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      seatNumber: map['seatNumber'],
      passengerType: map['passengerType'] != null
          ? (map['passengerType'] as String?)?.toEnum(PassengerTypeEnum.values)
          : null,
      creationTs: map['creationTs'],
      firstDepartureTime: map['firstDepartureTime'],
      cancellationTs: map['cancellationTs'] ?? '',
      modTs: map['modTs'] ?? '',
      dob: map['dob'] ?? '',
      errorDetails: map['errorDetails'] != null
          ? Map<String, dynamic>.from(map['errorDetails'])
          : null,
      commissionData: map['commissionData'] != null
          ? Map<String, dynamic>.from(map['commissionData'])
          : null,
      customerPayment: map['customerPayment'] != null
          ? CustomerPayment.fromMap(map['customerPayment'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BusOrderPassengerDetails.fromJson(String source) =>
      BusOrderPassengerDetails.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BusOrderPassengerDetails(id: $id, orderUuid: $orderUuid, itineraryUuid: $itineraryUuid, username: $username, specialRequest: $specialRequest, profileType: $profileType, phoneNumber: $phoneNumber, email: $email, profileId: $profileId, passengerUserUid: $passengerUserUid, empId: $empId, address: $address, idNumber: $idNumber, idType: $idType, mobile: $mobile, age: $age, gender: $gender, primary: $primary, busBookingStatus: $busBookingStatus, ticketNumber: $ticketNumber, title: $title, firstName: $firstName, lastName: $lastName, seatNumber: $seatNumber, passengerType: $passengerType, creationTs: $creationTs, firstDepartureTime: $firstDepartureTime, cancellationTs: $cancellationTs, modTs: $modTs, dob: $dob, errorDetails: $errorDetails, commissionData: $commissionData, customerPayment: $customerPayment)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BusOrderPassengerDetails &&
        other.id == id &&
        other.orderUuid == orderUuid &&
        other.itineraryUuid == itineraryUuid &&
        other.username == username &&
        other.specialRequest == specialRequest &&
        other.profileType == profileType &&
        other.phoneNumber == phoneNumber &&
        other.email == email &&
        other.profileId == profileId &&
        other.passengerUserUid == passengerUserUid &&
        other.empId == empId &&
        other.address == address &&
        other.idNumber == idNumber &&
        other.idType == idType &&
        other.mobile == mobile &&
        other.age == age &&
        other.gender == gender &&
        other.primary == primary &&
        other.busBookingStatus == busBookingStatus &&
        other.ticketNumber == ticketNumber &&
        other.title == title &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.seatNumber == seatNumber &&
        other.passengerType == passengerType &&
        other.creationTs == creationTs &&
        other.firstDepartureTime == firstDepartureTime &&
        other.cancellationTs == cancellationTs &&
        other.modTs == modTs &&
        other.dob == dob &&
        mapEquals(other.errorDetails, errorDetails) &&
        mapEquals(other.commissionData, commissionData) &&
        other.customerPayment == customerPayment;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        orderUuid.hashCode ^
        itineraryUuid.hashCode ^
        username.hashCode ^
        specialRequest.hashCode ^
        profileType.hashCode ^
        phoneNumber.hashCode ^
        email.hashCode ^
        profileId.hashCode ^
        passengerUserUid.hashCode ^
        empId.hashCode ^
        address.hashCode ^
        idNumber.hashCode ^
        idType.hashCode ^
        mobile.hashCode ^
        age.hashCode ^
        gender.hashCode ^
        primary.hashCode ^
        busBookingStatus.hashCode ^
        ticketNumber.hashCode ^
        title.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        seatNumber.hashCode ^
        passengerType.hashCode ^
        creationTs.hashCode ^
        firstDepartureTime.hashCode ^
        cancellationTs.hashCode ^
        modTs.hashCode ^
        dob.hashCode ^
        errorDetails.hashCode ^
        commissionData.hashCode ^
        customerPayment.hashCode;
  }
}
