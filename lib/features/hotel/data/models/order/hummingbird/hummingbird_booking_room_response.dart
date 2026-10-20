import 'dart:convert';

class HummingbirdBookingRoomResponse {
  final String? status;
  final String? externalReferenceId;
  final String? hummingbirdStatus;
  final String? clientRequestNumber;
  final String? requestNumber;
  final String? reservationNumber;
  HummingbirdBookingRoomResponse({
    this.status,
    this.externalReferenceId,
    this.hummingbirdStatus,
    this.clientRequestNumber,
    this.requestNumber,
    this.reservationNumber,
  });

  bool get isConfirmed {
    return const ['ok', 'confirmed', 'confirmation', '1']
        .contains(status?.trim().toLowerCase());
  }

  bool get isPending {
    return const [
      'hp',
      'pending',
      'hotel pending',
      'pending hotel confirmation',
      '4'
    ].contains(status?.trim().toLowerCase());
  }

  HummingbirdBookingRoomResponse copyWith({
    String? status,
    String? externalReferenceId,
    String? hummingbirdStatus,
    String? clientRequestNumber,
    String? requestNumber,
    String? reservationNumber,
  }) {
    return HummingbirdBookingRoomResponse(
      status: status ?? this.status,
      externalReferenceId: externalReferenceId ?? this.externalReferenceId,
      hummingbirdStatus: hummingbirdStatus ?? this.hummingbirdStatus,
      clientRequestNumber: clientRequestNumber ?? this.clientRequestNumber,
      requestNumber: requestNumber ?? this.requestNumber,
      reservationNumber: reservationNumber ?? this.reservationNumber,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (status != null) {
      result.addAll({'status': status});
    }
    if (externalReferenceId != null) {
      result.addAll({'externalReferenceId': externalReferenceId});
    }
    if (hummingbirdStatus != null) {
      result.addAll({'hummingbirdStatus': hummingbirdStatus});
    }
    if (clientRequestNumber != null) {
      result.addAll({'clientRequestNumber': clientRequestNumber});
    }
    if (requestNumber != null) {
      result.addAll({'requestNumber': requestNumber});
    }
    if (reservationNumber != null) {
      result.addAll({'reservationNumber': reservationNumber});
    }

    return result;
  }

  factory HummingbirdBookingRoomResponse.fromMap(Map<String, dynamic> map) {
    return HummingbirdBookingRoomResponse(
      status: map['status']?.toString(),
      externalReferenceId: map['externalReferenceId'],
      hummingbirdStatus: map['hummingbirdStatus']?.toString(),
      clientRequestNumber: map['clientRequestNumber'],
      requestNumber: map['requestNumber'],
      reservationNumber: map['reservationNumber'],
    );
  }

  String toJson() => json.encode(toMap());

  factory HummingbirdBookingRoomResponse.fromJson(String source) =>
      HummingbirdBookingRoomResponse.fromMap(json.decode(source));

  @override
  String toString() {
    return 'HummingbirdBookingRoomResponse(status: $status, externalReferenceId: $externalReferenceId, hummingbirdStatus: $hummingbirdStatus, clientRequestNumber: $clientRequestNumber, requestNumber: $requestNumber, reservationNumber: $reservationNumber)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HummingbirdBookingRoomResponse &&
        other.status == status &&
        other.externalReferenceId == externalReferenceId &&
        other.hummingbirdStatus == hummingbirdStatus &&
        other.clientRequestNumber == clientRequestNumber &&
        other.requestNumber == requestNumber &&
        other.reservationNumber == reservationNumber;
  }

  @override
  int get hashCode {
    return status.hashCode ^
        externalReferenceId.hashCode ^
        hummingbirdStatus.hashCode ^
        clientRequestNumber.hashCode ^
        requestNumber.hashCode ^
        reservationNumber.hashCode;
  }
}
