import 'dart:convert';

import 'package:yellow_rose/features/flight/data/models/erro_code_handler.dart';

class GstBookingDetails {
  final String? gstNumber;
  final String? gstName;
  final String? gstPhone;
  final String? gstAddress;
  final String? gstCity;
  final String? gstState;
  final String? gstPostalCode;
  final String? gstEmail;
  final String? companyName;
  final ErrorCodeHandler errorDetails;
  GstBookingDetails({
    this.gstNumber,
    this.gstName,
    this.gstPhone,
    this.gstAddress,
    this.gstCity,
    this.gstState,
    this.gstPostalCode,
    this.gstEmail,
    this.companyName,
    required this.errorDetails,
  });

  GstBookingDetails copyWith({
    String? gstNumber,
    String? gstName,
    String? gstPhone,
    String? gstAddress,
    String? gstCity,
    String? gstState,
    String? gstPostalCode,
    String? gstEmail,
    String? companyName,
    ErrorCodeHandler? errorDetails,
  }) {
    return GstBookingDetails(
      gstNumber: gstNumber ?? this.gstNumber,
      gstName: gstName ?? this.gstName,
      gstPhone: gstPhone ?? this.gstPhone,
      gstAddress: gstAddress ?? this.gstAddress,
      gstCity: gstCity ?? this.gstCity,
      gstState: gstState ?? this.gstState,
      gstPostalCode: gstPostalCode ?? this.gstPostalCode,
      gstEmail: gstEmail ?? this.gstEmail,
      companyName: companyName ?? this.companyName,
      errorDetails: errorDetails ?? this.errorDetails,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (gstNumber != null) {
      result.addAll({'gstNumber': gstNumber});
    }
    if (gstName != null) {
      result.addAll({'gstName': gstName});
    }
    if (gstPhone != null) {
      result.addAll({'gstPhone': gstPhone});
    }
    if (gstAddress != null) {
      result.addAll({'gstAddress': gstAddress});
    }
    if (gstCity != null) {
      result.addAll({'gstCity': gstCity});
    }
    if (gstState != null) {
      result.addAll({'gstState': gstState});
    }
    if (gstPostalCode != null) {
      result.addAll({'gstPostalCode': gstPostalCode});
    }
    if (gstEmail != null) {
      result.addAll({'gstEmail': gstEmail});
    }
    if (companyName != null) {
      result.addAll({'companyName': companyName});
    }
    result.addAll({'errorDetails': errorDetails.toMap()});

    return result;
  }

  factory GstBookingDetails.fromMap(Map<String, dynamic> map) {
    return GstBookingDetails(
      gstNumber: map['gstNumber'],
      gstName: map['gstName'],
      gstPhone: map['gstPhone'],
      gstAddress: map['gstAddress'],
      gstCity: map['gstCity'],
      gstState: map['gstState'],
      gstPostalCode: map['gstPostalCode'],
      gstEmail: map['gstEmail'],
      companyName: map['companyName'],
      errorDetails: ErrorCodeHandler.fromMap(map['errorDetails']),
    );
  }

  String toJson() => json.encode(toMap());

  factory GstBookingDetails.fromJson(String source) =>
      GstBookingDetails.fromMap(json.decode(source));

  @override
  String toString() {
    return 'GstBookingDetails(gstNumber: $gstNumber, gstName: $gstName, gstPhone: $gstPhone, gstAddress: $gstAddress, gstCity: $gstCity, gstState: $gstState, gstPostalCode: $gstPostalCode, gstEmail: $gstEmail, companyName: $companyName, errorDetails: $errorDetails)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GstBookingDetails &&
        other.gstNumber == gstNumber &&
        other.gstName == gstName &&
        other.gstPhone == gstPhone &&
        other.gstAddress == gstAddress &&
        other.gstCity == gstCity &&
        other.gstState == gstState &&
        other.gstPostalCode == gstPostalCode &&
        other.gstEmail == gstEmail &&
        other.companyName == companyName &&
        other.errorDetails == errorDetails;
  }

  @override
  int get hashCode {
    return gstNumber.hashCode ^
        gstName.hashCode ^
        gstPhone.hashCode ^
        gstAddress.hashCode ^
        gstCity.hashCode ^
        gstState.hashCode ^
        gstPostalCode.hashCode ^
        gstEmail.hashCode ^
        companyName.hashCode ^
        errorDetails.hashCode;
  }
}
