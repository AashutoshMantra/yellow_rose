import 'dart:convert';

class BusPassengerGSTDetails {
  final String? registrationName;
  final String? gstId;
  final String? address;
  final String? emailId;
  BusPassengerGSTDetails({
    this.registrationName,
    this.gstId,
    this.address,
    this.emailId,
  });

  BusPassengerGSTDetails copyWith({
    String? registrationName,
    String? gstId,
    String? address,
    String? emailId,
  }) {
    return BusPassengerGSTDetails(
      registrationName: registrationName ?? this.registrationName,
      gstId: gstId ?? this.gstId,
      address: address ?? this.address,
      emailId: emailId ?? this.emailId,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(registrationName != null){
      result.addAll({'registrationName': registrationName});
    }
    if(gstId != null){
      result.addAll({'gstId': gstId});
    }
    if(address != null){
      result.addAll({'address': address});
    }
    if(emailId != null){
      result.addAll({'emailId': emailId});
    }
  
    return result;
  }

  factory BusPassengerGSTDetails.fromMap(Map<String, dynamic> map) {
    return BusPassengerGSTDetails(
      registrationName: map['registrationName'],
      gstId: map['gstId'],
      address: map['address'],
      emailId: map['emailId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BusPassengerGSTDetails.fromJson(String source) => BusPassengerGSTDetails.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PassengerGSTDetails(registrationName: $registrationName, gstId: $gstId, address: $address, emailId: $emailId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is BusPassengerGSTDetails &&
      other.registrationName == registrationName &&
      other.gstId == gstId &&
      other.address == address &&
      other.emailId == emailId;
  }

  @override
  int get hashCode {
    return registrationName.hashCode ^
      gstId.hashCode ^
      address.hashCode ^
      emailId.hashCode;
  }
}
