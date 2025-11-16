import 'dart:convert';

class BusPoint {
  final String? dpId;
  final String? bpId;
  final String? location;
  final DateTime? time;
  final String? address;
  final String? contactNumber;
  final String? prime;
  BusPoint({
    this.dpId,
    this.bpId,
    this.location,
    this.time,
    this.address,
    this.contactNumber,
    this.prime,
  });

  BusPoint copyWith({
    String? dpId,
    String? bpId,
    String? location,
    DateTime? time,
    String? address,
    String? contactNumber,
    String? prime,
  }) {
    return BusPoint(
      dpId: dpId ?? this.dpId,
      bpId: bpId ?? this.bpId,
      location: location ?? this.location,
      time: time ?? this.time,
      address: address ?? this.address,
      contactNumber: contactNumber ?? this.contactNumber,
      prime: prime ?? this.prime,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (dpId != null) {
      result.addAll({'dpId': dpId});
    }
    if (bpId != null) {
      result.addAll({'bpId': bpId});
    }
    if (location != null) {
      result.addAll({'location': location});
    }
    if (time != null) {
      result.addAll({'time': time!.millisecondsSinceEpoch});
    }
    if (address != null) {
      result.addAll({'address': address});
    }
    if (contactNumber != null) {
      result.addAll({'contactNumber': contactNumber});
    }
    if (prime != null) {
      result.addAll({'prime': prime});
    }

    return result;
  }

  factory BusPoint.fromMap(Map<String, dynamic> map) {
    return BusPoint(
      dpId: map['dpId'],
      bpId: map['bpId'],
      location: map['location'],
      time: map['time'] != null
          ? DateTime.tryParse(map['time'])
          : null,
      address: map['address'],
      contactNumber: map['contactNumber'],
      prime: map['prime'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BusPoint.fromJson(String source) =>
      BusPoint.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BusPoint(dpId: $dpId, bpId: $bpId, location: $location, time: $time, address: $address, contactNumber: $contactNumber, prime: $prime)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BusPoint &&
        other.dpId == dpId &&
        other.bpId == bpId &&
        other.location == location &&
        other.time == time &&
        other.address == address &&
        other.contactNumber == contactNumber &&
        other.prime == prime;
  }

  @override
  int get hashCode {
    return dpId.hashCode ^
        bpId.hashCode ^
        location.hashCode ^
        time.hashCode ^
        address.hashCode ^
        contactNumber.hashCode ^
        prime.hashCode;
  }

  String get id {
    return bpId ?? dpId ?? "";
  }

  bool get isBoardingPoint {
    return bpId != null;
  }

  bool get isDroppingPoint {
    return dpId != null;
  }
}
