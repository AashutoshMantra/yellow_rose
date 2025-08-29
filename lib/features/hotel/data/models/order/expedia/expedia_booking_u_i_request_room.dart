import 'dart:convert';

class ExpediaBookingUIRequestRoom {
  final String? firstName;

  final String? lastName;
  final bool? smoking;
  final String? specialRequest;
  final String? loyaltyMemberId;
  final String? loyaltyProgramId;
  ExpediaBookingUIRequestRoom({
    this.firstName,
    this.lastName,
    this.smoking,
    this.specialRequest,
    this.loyaltyMemberId,
    this.loyaltyProgramId,
  });

  ExpediaBookingUIRequestRoom copyWith({
    String? firstName,
    String? lastName,
    bool? smoking,
    String? specialRequest,
    String? loyaltyMemberId,
    String? loyaltyProgramId,
  }) {
    return ExpediaBookingUIRequestRoom(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      smoking: smoking ?? this.smoking,
      specialRequest: specialRequest ?? this.specialRequest,
      loyaltyMemberId: loyaltyMemberId ?? this.loyaltyMemberId,
      loyaltyProgramId: loyaltyProgramId ?? this.loyaltyProgramId,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (firstName != null) {
      result.addAll({'firstName': firstName});
    }
    if (lastName != null) {
      result.addAll({'lastName': lastName});
    }
    if (smoking != null) {
      result.addAll({'smoking': smoking});
    }
    if (specialRequest != null) {
      result.addAll({'specialRequest': specialRequest});
    }
    if (loyaltyMemberId != null) {
      result.addAll({'loyaltyMemberId': loyaltyMemberId});
    }
    if (loyaltyProgramId != null) {
      result.addAll({'loyaltyProgramId': loyaltyProgramId});
    }

    return result;
  }

  factory ExpediaBookingUIRequestRoom.fromMap(Map<String, dynamic> map) {
    return ExpediaBookingUIRequestRoom(
      firstName: map['firstName'],
      lastName: map['lastName'],
      smoking: map['smoking'],
      specialRequest: map['specialRequest'],
      loyaltyMemberId: map['loyaltyMemberId'],
      loyaltyProgramId: map['loyaltyProgramId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ExpediaBookingUIRequestRoom.fromJson(String source) =>
      ExpediaBookingUIRequestRoom.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ExpediaBookingUIRequestRoom(firstName: $firstName, lastName: $lastName, smoking: $smoking, specialRequest: $specialRequest, loyaltyMemberId: $loyaltyMemberId, loyaltyProgramId: $loyaltyProgramId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ExpediaBookingUIRequestRoom &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.smoking == smoking &&
        other.specialRequest == specialRequest &&
        other.loyaltyMemberId == loyaltyMemberId &&
        other.loyaltyProgramId == loyaltyProgramId;
  }

  @override
  int get hashCode {
    return firstName.hashCode ^
        lastName.hashCode ^
        smoking.hashCode ^
        specialRequest.hashCode ^
        loyaltyMemberId.hashCode ^
        loyaltyProgramId.hashCode;
  }
}
