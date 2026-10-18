import 'dart:convert';

class TripGuest {
  final String? title;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? mobile;
  final String? passengerType;
  final String? justification;
  final String? organization;
  final bool? isGov;

  TripGuest({
    this.title,
    this.firstName,
    this.lastName,
    this.email,
    this.mobile,
    this.passengerType,
    this.justification,
    this.organization,
    this.isGov,
  });

  TripGuest copyWith({
    String? title,
    String? firstName,
    String? lastName,
    String? email,
    String? mobile,
    String? passengerType,
    String? justification,
    String? organization,
    bool? isGov,
  }) {
    return TripGuest(
      title: title ?? this.title,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      mobile: mobile ?? this.mobile,
      passengerType: passengerType ?? this.passengerType,
      justification: justification ?? this.justification,
      organization: organization ?? this.organization,
      isGov: isGov ?? this.isGov,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

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
    if (passengerType != null) {
      result.addAll({'passengerType': passengerType});
    }
    if (justification != null) {
      result.addAll({'justification': justification});
    }
    if (organization != null) {
      result.addAll({'organization': organization});
    }
    if (isGov != null) {
      result.addAll({'isGov': isGov});
    }

    return result;
  }

  factory TripGuest.fromMap(Map<String, dynamic> map) {
    return TripGuest(
      title: map['title'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      email: map['email'],
      mobile: map['mobile'],
      passengerType: map['passengerType'],
      justification: map['justification'],
      organization: map['organization'],
      isGov: map['isGov'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TripGuest.fromJson(String source) =>
      TripGuest.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TripGuest(title: $title, firstName: $firstName, lastName: $lastName, email: $email, mobile: $mobile, passengerType: $passengerType, justification: $justification, organization: $organization, isGov: $isGov)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TripGuest &&
        other.title == title &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.email == email &&
        other.mobile == mobile &&
        other.passengerType == passengerType &&
        other.justification == justification &&
        other.organization == organization &&
        other.isGov == isGov;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        email.hashCode ^
        mobile.hashCode ^
        passengerType.hashCode ^
        justification.hashCode ^
        organization.hashCode ^
        isGov.hashCode;
  }
}
