import 'dart:convert';

class HotelConfirmationPostBooking {
  final String? contactNumber;
  final String? contactPerson;
  final String? bookingId;
  final bool? verifiedByStaff;
  final bool? hotelPrePayment;
  final bool? extraBedding;

  final DateTime? confirmationDate;

  final DateTime? reConfirmationDate;
  HotelConfirmationPostBooking({
    this.contactNumber,
    this.contactPerson,
    this.bookingId,
    this.verifiedByStaff,
    this.hotelPrePayment,
    this.extraBedding,
    this.confirmationDate,
    this.reConfirmationDate,
  });

  HotelConfirmationPostBooking copyWith({
    String? contactNumber,
    String? contactPerson,
    String? bookingId,
    bool? verifiedByStaff,
    bool? hotelPrePayment,
    bool? extraBedding,
    DateTime? confirmationDate,
    DateTime? reConfirmationDate,
  }) {
    return HotelConfirmationPostBooking(
      contactNumber: contactNumber ?? this.contactNumber,
      contactPerson: contactPerson ?? this.contactPerson,
      bookingId: bookingId ?? this.bookingId,
      verifiedByStaff: verifiedByStaff ?? this.verifiedByStaff,
      hotelPrePayment: hotelPrePayment ?? this.hotelPrePayment,
      extraBedding: extraBedding ?? this.extraBedding,
      confirmationDate: confirmationDate ?? this.confirmationDate,
      reConfirmationDate: reConfirmationDate ?? this.reConfirmationDate,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (contactNumber != null) {
      result.addAll({'contactNumber': contactNumber});
    }
    if (contactPerson != null) {
      result.addAll({'contactPerson': contactPerson});
    }
    if (bookingId != null) {
      result.addAll({'bookingId': bookingId});
    }
    if (verifiedByStaff != null) {
      result.addAll({'verifiedByStaff': verifiedByStaff});
    }
    if (hotelPrePayment != null) {
      result.addAll({'hotelPrePayment': hotelPrePayment});
    }
    if (extraBedding != null) {
      result.addAll({'extraBedding': extraBedding});
    }
    if (confirmationDate != null) {
      result.addAll(
          {'confirmationDate': confirmationDate!.millisecondsSinceEpoch});
    }
    if (reConfirmationDate != null) {
      result.addAll(
          {'reConfirmationDate': reConfirmationDate!.millisecondsSinceEpoch});
    }

    return result;
  }

  factory HotelConfirmationPostBooking.fromMap(Map<String, dynamic> map) {
    return HotelConfirmationPostBooking(
      contactNumber: map['contactNumber'],
      contactPerson: map['contactPerson'],
      bookingId: map['bookingId'],
      verifiedByStaff: map['verifiedByStaff'],
      hotelPrePayment: map['hotelPrePayment'],
      extraBedding: map['extraBedding'],
      confirmationDate: map['confirmationDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['confirmationDate'])
          : null,
      reConfirmationDate: map['reConfirmationDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['reConfirmationDate'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory HotelConfirmationPostBooking.fromJson(String source) =>
      HotelConfirmationPostBooking.fromMap(json.decode(source));

  @override
  String toString() {
    return 'HotelConfirmationPostBooking(contactNumber: $contactNumber, contactPerson: $contactPerson, bookingId: $bookingId, verifiedByStaff: $verifiedByStaff, hotelPrePayment: $hotelPrePayment, extraBedding: $extraBedding, confirmationDate: $confirmationDate, reConfirmationDate: $reConfirmationDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HotelConfirmationPostBooking &&
        other.contactNumber == contactNumber &&
        other.contactPerson == contactPerson &&
        other.bookingId == bookingId &&
        other.verifiedByStaff == verifiedByStaff &&
        other.hotelPrePayment == hotelPrePayment &&
        other.extraBedding == extraBedding &&
        other.confirmationDate == confirmationDate &&
        other.reConfirmationDate == reConfirmationDate;
  }

  @override
  int get hashCode {
    return contactNumber.hashCode ^
        contactPerson.hashCode ^
        bookingId.hashCode ^
        verifiedByStaff.hashCode ^
        hotelPrePayment.hashCode ^
        extraBedding.hashCode ^
        confirmationDate.hashCode ^
        reConfirmationDate.hashCode;
  }
}
