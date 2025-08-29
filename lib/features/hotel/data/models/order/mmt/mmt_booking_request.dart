import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:yellow_rose/features/hotel/data/models/order/hotel_traveller.dart';

class MmtBookingRequest {
  final String? blockId;
  final bool? recheckRequired;
  final String? gstinNumber;
  final String? gstinCompanyAddress;
  final String? gstinCompanyName;
  final String? panCard;
  final String? specialRequest;

  final String? source;
  final String? requestId;
  final String? currency;
  final List<HotelTraveler>? travellers;
  MmtBookingRequest({
    this.blockId,
    this.recheckRequired,
    this.gstinNumber,
    this.gstinCompanyAddress,
    this.gstinCompanyName,
    this.panCard,
    this.specialRequest,
    this.source,
    this.requestId,
    this.currency,
    this.travellers,
  });

  MmtBookingRequest copyWith({
    String? blockId,
    bool? recheckRequired,
    String? gstinNumber,
    String? gstinCompanyAddress,
    String? gstinCompanyName,
    String? panCard,
    String? specialRequest,
    String? source,
    String? requestId,
    String? currency,
    List<HotelTraveler>? travellers,
  }) {
    return MmtBookingRequest(
      blockId: blockId ?? this.blockId,
      recheckRequired: recheckRequired ?? this.recheckRequired,
      gstinNumber: gstinNumber ?? this.gstinNumber,
      gstinCompanyAddress: gstinCompanyAddress ?? this.gstinCompanyAddress,
      gstinCompanyName: gstinCompanyName ?? this.gstinCompanyName,
      panCard: panCard ?? this.panCard,
      specialRequest: specialRequest ?? this.specialRequest,
      source: source ?? this.source,
      requestId: requestId ?? this.requestId,
      currency: currency ?? this.currency,
      travellers: travellers ?? this.travellers,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (blockId != null) {
      result.addAll({'blockId': blockId});
    }
    if (recheckRequired != null) {
      result.addAll({'recheckRequired': recheckRequired});
    }
    if (gstinNumber != null) {
      result.addAll({'gstinNumber': gstinNumber});
    }
    if (gstinCompanyAddress != null) {
      result.addAll({'gstinCompanyAddress': gstinCompanyAddress});
    }
    if (gstinCompanyName != null) {
      result.addAll({'gstinCompanyName': gstinCompanyName});
    }
    if (panCard != null) {
      result.addAll({'panCard': panCard});
    }
    if (specialRequest != null) {
      result.addAll({'specialRequest': specialRequest});
    }
    if (source != null) {
      result.addAll({'source': source});
    }
    if (requestId != null) {
      result.addAll({'requestId': requestId});
    }
    if (currency != null) {
      result.addAll({'currency': currency});
    }
    if (travellers != null) {
      result.addAll({'travellers': travellers!.map((x) => x.toMap()).toList()});
    }

    return result;
  }

  factory MmtBookingRequest.fromMap(Map<String, dynamic> map) {
    return MmtBookingRequest(
      blockId: map['blockId'],
      recheckRequired: map['recheckRequired'],
      gstinNumber: map['gstinNumber'],
      gstinCompanyAddress: map['gstinCompanyAddress'],
      gstinCompanyName: map['gstinCompanyName'],
      panCard: map['panCard'],
      specialRequest: map['specialRequest'],
      source: map['source'],
      requestId: map['requestId'],
      currency: map['currency'],
      travellers: map['travellers'] != null
          ? List<HotelTraveler>.from(
              map['travellers']?.map((x) => HotelTraveler.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory MmtBookingRequest.fromJson(String source) =>
      MmtBookingRequest.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MmtBookingRequest(blockId: $blockId, recheckRequired: $recheckRequired, gstinNumber: $gstinNumber, gstinCompanyAddress: $gstinCompanyAddress, gstinCompanyName: $gstinCompanyName, panCard: $panCard, specialRequest: $specialRequest, source: $source, requestId: $requestId, currency: $currency, travellers: $travellers)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MmtBookingRequest &&
        other.blockId == blockId &&
        other.recheckRequired == recheckRequired &&
        other.gstinNumber == gstinNumber &&
        other.gstinCompanyAddress == gstinCompanyAddress &&
        other.gstinCompanyName == gstinCompanyName &&
        other.panCard == panCard &&
        other.specialRequest == specialRequest &&
        other.source == source &&
        other.requestId == requestId &&
        other.currency == currency &&
        listEquals(other.travellers, travellers);
  }

  @override
  int get hashCode {
    return blockId.hashCode ^
        recheckRequired.hashCode ^
        gstinNumber.hashCode ^
        gstinCompanyAddress.hashCode ^
        gstinCompanyName.hashCode ^
        panCard.hashCode ^
        specialRequest.hashCode ^
        source.hashCode ^
        requestId.hashCode ^
        currency.hashCode ^
        travellers.hashCode;
  }
}
