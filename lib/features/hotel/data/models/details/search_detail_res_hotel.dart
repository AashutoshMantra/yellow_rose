import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:yellow_rose/features/hotel/data/models/details/agoda/agoda_detail_room.dart';
import 'package:yellow_rose/features/hotel/data/models/details/expedia/content_resposne_policy.dart';
import 'package:yellow_rose/features/hotel/data/models/details/expedia/hotel_detail_expedia_room.dart';
import 'package:yellow_rose/features/hotel/data/models/details/expedia/onsite_payment.dart';
import 'package:yellow_rose/features/hotel/data/models/details/expedia/room/content_room_images.dart';
import 'package:yellow_rose/features/hotel/data/models/details/hotel_detail_rating.dart';
import 'package:yellow_rose/features/hotel/data/models/details/mmt/hotel_detail_mmt_room.dart';
import 'package:yellow_rose/features/hotel/data/models/details/mmt/hotel_metadata_policy.dart';
import 'package:yellow_rose/features/hotel/data/models/search/hotel_search_response_entoty.dart';

class SearchDetailRespHotels {
  final int? hotelId;
  final String? mmtId;
  final int? agodaId;
  final String? expediaId;

  final String? name;
  final String? hotelChainName;
  final String? address;
  final String? pinCode;
  final String? propertyType;
  final String? childrenAgeFrom;
  final String? childrenAgeTo;
  final String? childrenStayFree;
  final String? infantAge;
  final String? minGuestAge;
  final double? latitude;
  final double? longitude;
  final List<HotelDetailRating> ratings;
  final String? checkInInstruction;
  final String? checkInSpecialInstruction;

  final bool? singleRoomProperty;
  final String? checkIn;
  final String? checkOut;
  final String? description;
  final bool? myBizAssured;
  final String? gstin;
  final List<HotelSearchResponseAmenity>? mmtAmenities;
  final List<HotelSearchResponseAmenity>? expediaAmenities;

  final List<String>? mmtMedia;

  final List<HotelSearchResponseAmenity>? agodaAmenities;
  final List<String>? agodaMedia;

  final List<HotelDetailMmtRoom>? mmtRooms;
  final List<HotelDetailAgodaRoom>? agodaRooms;
  final List<MMTHotelMetadataPolicy>? mmtPolicies;

  final List<HotelDetailExpediaRoom>? expediaRooms;

  final ExpediaHotelContentResponsePolicy? expediaPolicies;

  final ExpediaHotelContentResponseOnsitePayment? expediaOnsitePayment;
  final List<ExpediaHotelContentResponseImage>? expediaImages;
  SearchDetailRespHotels({
    this.hotelId,
    this.mmtId,
    this.agodaId,
    this.expediaId,
    this.name,
    this.hotelChainName,
    this.address,
    this.pinCode,
    this.propertyType,
    this.childrenAgeFrom,
    this.childrenAgeTo,
    this.childrenStayFree,
    this.infantAge,
    this.minGuestAge,
    this.latitude,
    this.longitude,
    required this.ratings,
    this.checkInInstruction,
    this.checkInSpecialInstruction,
    this.singleRoomProperty,
    this.checkIn,
    this.checkOut,
    this.description,
    this.myBizAssured,
    this.gstin,
    this.mmtAmenities,
    this.expediaAmenities,
    this.mmtMedia,
    this.agodaAmenities,
    this.agodaMedia,
    this.mmtRooms,
    this.agodaRooms,
    this.mmtPolicies,
    this.expediaRooms,
    this.expediaPolicies,
    this.expediaOnsitePayment,
    this.expediaImages,
  });

  SearchDetailRespHotels copyWith({
    int? hotelId,
    String? mmtId,
    int? agodaId,
    String? expediaId,
    String? name,
    String? hotelChainName,
    String? address,
    String? pinCode,
    String? propertyType,
    String? childrenAgeFrom,
    String? childrenAgeTo,
    String? childrenStayFree,
    String? infantAge,
    String? minGuestAge,
    double? latitude,
    double? longitude,
    List<HotelDetailRating>? ratings,
    String? checkInInstruction,
    String? checkInSpecialInstruction,
    bool? singleRoomProperty,
    String? checkIn,
    String? checkOut,
    String? description,
    bool? myBizAssured,
    String? gstin,
    List<HotelSearchResponseAmenity>? mmtAmenities,
    List<HotelSearchResponseAmenity>? expediaAmenities,
    List<String>? mmtMedia,
    List<HotelSearchResponseAmenity>? agodaAmenities,
    List<String>? agodaMedia,
    List<HotelDetailMmtRoom>? mmtRooms,
    List<HotelDetailAgodaRoom>? agodaRooms,
    List<MMTHotelMetadataPolicy>? mmtPolicies,
    List<HotelDetailExpediaRoom>? expediaRooms,
    ExpediaHotelContentResponsePolicy? expediaPolicies,
    ExpediaHotelContentResponseOnsitePayment? expediaOnsitePayment,
    List<ExpediaHotelContentResponseImage>? expediaImages,
  }) {
    return SearchDetailRespHotels(
      hotelId: hotelId ?? this.hotelId,
      mmtId: mmtId ?? this.mmtId,
      agodaId: agodaId ?? this.agodaId,
      expediaId: expediaId ?? this.expediaId,
      name: name ?? this.name,
      hotelChainName: hotelChainName ?? this.hotelChainName,
      address: address ?? this.address,
      pinCode: pinCode ?? this.pinCode,
      propertyType: propertyType ?? this.propertyType,
      childrenAgeFrom: childrenAgeFrom ?? this.childrenAgeFrom,
      childrenAgeTo: childrenAgeTo ?? this.childrenAgeTo,
      childrenStayFree: childrenStayFree ?? this.childrenStayFree,
      infantAge: infantAge ?? this.infantAge,
      minGuestAge: minGuestAge ?? this.minGuestAge,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      ratings: ratings ?? this.ratings,
      checkInInstruction: checkInInstruction ?? this.checkInInstruction,
      checkInSpecialInstruction:
          checkInSpecialInstruction ?? this.checkInSpecialInstruction,
      singleRoomProperty: singleRoomProperty ?? this.singleRoomProperty,
      checkIn: checkIn ?? this.checkIn,
      checkOut: checkOut ?? this.checkOut,
      description: description ?? this.description,
      myBizAssured: myBizAssured ?? this.myBizAssured,
      gstin: gstin ?? this.gstin,
      mmtAmenities: mmtAmenities ?? this.mmtAmenities,
      expediaAmenities: expediaAmenities ?? this.expediaAmenities,
      mmtMedia: mmtMedia ?? this.mmtMedia,
      agodaAmenities: agodaAmenities ?? this.agodaAmenities,
      agodaMedia: agodaMedia ?? this.agodaMedia,
      mmtRooms: mmtRooms ?? this.mmtRooms,
      agodaRooms: agodaRooms ?? this.agodaRooms,
      mmtPolicies: mmtPolicies ?? this.mmtPolicies,
      expediaRooms: expediaRooms ?? this.expediaRooms,
      expediaPolicies: expediaPolicies ?? this.expediaPolicies,
      expediaOnsitePayment: expediaOnsitePayment ?? this.expediaOnsitePayment,
      expediaImages: expediaImages ?? this.expediaImages,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (hotelId != null) {
      result.addAll({'hotelId': hotelId});
    }
    if (mmtId != null) {
      result.addAll({'mmtId': mmtId});
    }
    if (agodaId != null) {
      result.addAll({'agodaId': agodaId});
    }
    if (expediaId != null) {
      result.addAll({'expediaId': expediaId});
    }
    if (name != null) {
      result.addAll({'name': name});
    }
    if (hotelChainName != null) {
      result.addAll({'hotelChainName': hotelChainName});
    }
    if (address != null) {
      result.addAll({'address': address});
    }
    if (pinCode != null) {
      result.addAll({'pinCode': pinCode});
    }
    if (propertyType != null) {
      result.addAll({'propertyType': propertyType});
    }
    if (childrenAgeFrom != null) {
      result.addAll({'childrenAgeFrom': childrenAgeFrom});
    }
    if (childrenAgeTo != null) {
      result.addAll({'childrenAgeTo': childrenAgeTo});
    }
    if (childrenStayFree != null) {
      result.addAll({'childrenStayFree': childrenStayFree});
    }
    if (infantAge != null) {
      result.addAll({'infantAge': infantAge});
    }
    if (minGuestAge != null) {
      result.addAll({'minGuestAge': minGuestAge});
    }
    if (latitude != null) {
      result.addAll({'latitude': latitude});
    }
    if (longitude != null) {
      result.addAll({'longitude': longitude});
    }
    result.addAll({'ratings': ratings.map((x) => x.toMap()).toList()});
    if (checkInInstruction != null) {
      result.addAll({'checkInInstruction': checkInInstruction});
    }
    if (checkInSpecialInstruction != null) {
      result.addAll({'checkInSpecialInstruction': checkInSpecialInstruction});
    }
    if (singleRoomProperty != null) {
      result.addAll({'singleRoomProperty': singleRoomProperty});
    }
    if (checkIn != null) {
      result.addAll({'checkIn': checkIn});
    }
    if (checkOut != null) {
      result.addAll({'checkOut': checkOut});
    }
    if (description != null) {
      result.addAll({'description': description});
    }
    if (myBizAssured != null) {
      result.addAll({'myBizAssured': myBizAssured});
    }
    if (gstin != null) {
      result.addAll({'gstin': gstin});
    }
    if (mmtAmenities != null) {
      result.addAll(
          {'mmtAmenities': mmtAmenities!.map((x) => x.toMap()).toList()});
    }
    if (expediaAmenities != null) {
      result.addAll({
        'expediaAmenities': expediaAmenities!.map((x) => x.toMap()).toList()
      });
    }
    if (mmtMedia != null) {
      result.addAll({'mmtMedia': mmtMedia});
    }
    if (agodaAmenities != null) {
      result.addAll(
          {'agodaAmenities': agodaAmenities!.map((x) => x.toMap()).toList()});
    }
    if (agodaMedia != null) {
      result.addAll({'agodaMedia': agodaMedia});
    }
    if (mmtRooms != null) {
      result.addAll({'mmtRooms': mmtRooms!.map((x) => x.toMap()).toList()});
    }
    if (agodaRooms != null) {
      result.addAll({'agodaRooms': agodaRooms!.map((x) => x.toMap()).toList()});
    }
    if (mmtPolicies != null) {
      result
          .addAll({'mmtPolicies': mmtPolicies!.map((x) => x.toMap()).toList()});
    }
    if (expediaRooms != null) {
      result.addAll(
          {'expediaRooms': expediaRooms!.map((x) => x.toMap()).toList()});
    }
    if (expediaPolicies != null) {
      result.addAll({'expediaPolicies': expediaPolicies!.toMap()});
    }
    if (expediaOnsitePayment != null) {
      result.addAll({'expediaOnsitePayment': expediaOnsitePayment!.toMap()});
    }
    if (expediaImages != null) {
      result.addAll(
          {'expediaImages': expediaImages!.map((x) => x.toMap()).toList()});
    }

    return result;
  }

  factory SearchDetailRespHotels.fromMap(Map<String, dynamic> map) {
    return SearchDetailRespHotels(
      hotelId: map['hotelId']?.toInt(),
      mmtId: map['mmtId'],
      agodaId: map['agodaId']?.toInt(),
      expediaId: map['expediaId']?.toString(),
      name: map['name'],
      hotelChainName: map['hotelChainName'],
      address: map['address'],
      pinCode: map['pinCode'],
      propertyType: map['propertyType'],
      childrenAgeFrom: map['childrenAgeFrom'],
      childrenAgeTo: map['childrenAgeTo'],
      childrenStayFree: map['childrenStayFree'],
      infantAge: map['infantAge'],
      minGuestAge: map['minGuestAge'],
      latitude: map['latitude']?.toDouble(),
      longitude: map['longitude']?.toDouble(),
      ratings: map['ratings'] != null
          ? List<HotelDetailRating>.from(
              map['ratings']?.map((x) => HotelDetailRating.fromMap(x)))
          : [],
      checkInInstruction: map['checkInInstruction'],
      checkInSpecialInstruction: map['checkInSpecialInstruction'],
      singleRoomProperty: map['singleRoomProperty'],
      checkIn: map['checkIn'],
      checkOut: map['checkOut'],
      description: map['description'],
      myBizAssured: map['myBizAssured'],
      gstin: map['gstin'],
      mmtAmenities: map['mmtAmenities'] != null
          ? List<HotelSearchResponseAmenity>.from(map['mmtAmenities']
              ?.map((x) => HotelSearchResponseAmenity.fromMap(x)))
          : null,
      expediaAmenities: map['expediaAmenities'] != null
          ? List<HotelSearchResponseAmenity>.from(map['expediaAmenities']
              ?.map((x) => HotelSearchResponseAmenity.fromMap(x)))
          : null,
      mmtMedia:
          map['mmtMedia'] != null ? List<String>.from(map['mmtMedia']) : null,
      agodaAmenities: map['agodaAmenities'] != null
          ? List<HotelSearchResponseAmenity>.from(map['agodaAmenities']
              ?.map((x) => HotelSearchResponseAmenity.fromMap(x)))
          : null,
      agodaMedia: map['agodaMedia'] != null
          ? List<String>.from(map['agodaMedia'])
          : null,
      mmtRooms: map['mmtRooms'] != null
          ? List<HotelDetailMmtRoom>.from(
              map['mmtRooms']?.map((x) => HotelDetailMmtRoom.fromMap(x)))
          : null,
      agodaRooms: map['agodaRooms'] != null
          ? List<HotelDetailAgodaRoom>.from(
              map['agodaRooms']?.map((x) => HotelDetailAgodaRoom.fromMap(x)))
          : null,
      mmtPolicies: map['mmtPolicies'] != null
          ? List<MMTHotelMetadataPolicy>.from(
              map['mmtPolicies']?.map((x) => MMTHotelMetadataPolicy.fromMap(x)))
          : null,
      expediaRooms: map['expediaRooms'] != null
          ? List<HotelDetailExpediaRoom>.from(map['expediaRooms']
              ?.map((x) => HotelDetailExpediaRoom.fromMap(x)))
          : null,
      expediaPolicies: map['expediaPolicies'] != null
          ? ExpediaHotelContentResponsePolicy.fromMap(map['expediaPolicies'])
          : null,
      expediaOnsitePayment: map['expediaOnsitePayment'] != null
          ? ExpediaHotelContentResponseOnsitePayment.fromMap(
              map['expediaOnsitePayment'])
          : null,
      expediaImages: map['expediaImages'] != null
          ? List<ExpediaHotelContentResponseImage>.from(map['expediaImages']
              ?.map((x) => ExpediaHotelContentResponseImage.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SearchDetailRespHotels.fromJson(String source) =>
      SearchDetailRespHotels.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SearchDetailRespHotels(hotelId: $hotelId, mmtId: $mmtId, agodaId: $agodaId, expediaId: $expediaId, name: $name, hotelChainName: $hotelChainName, address: $address, pinCode: $pinCode, propertyType: $propertyType, childrenAgeFrom: $childrenAgeFrom, childrenAgeTo: $childrenAgeTo, childrenStayFree: $childrenStayFree, infantAge: $infantAge, minGuestAge: $minGuestAge, latitude: $latitude, longitude: $longitude, ratings: $ratings, checkInInstruction: $checkInInstruction, checkInSpecialInstruction: $checkInSpecialInstruction, singleRoomProperty: $singleRoomProperty, checkIn: $checkIn, checkOut: $checkOut, description: $description, myBizAssured: $myBizAssured, gstin: $gstin, mmtAmenities: $mmtAmenities, expediaAmenities: $expediaAmenities, mmtMedia: $mmtMedia, agodaAmenities: $agodaAmenities, agodaMedia: $agodaMedia, mmtRooms: $mmtRooms, agodaRooms: $agodaRooms, mmtPolicies: $mmtPolicies, expediaRooms: $expediaRooms, expediaPolicies: $expediaPolicies, expediaOnsitePayment: $expediaOnsitePayment, expediaImages: $expediaImages)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SearchDetailRespHotels &&
        other.hotelId == hotelId &&
        other.mmtId == mmtId &&
        other.agodaId == agodaId &&
        other.expediaId == expediaId &&
        other.name == name &&
        other.hotelChainName == hotelChainName &&
        other.address == address &&
        other.pinCode == pinCode &&
        other.propertyType == propertyType &&
        other.childrenAgeFrom == childrenAgeFrom &&
        other.childrenAgeTo == childrenAgeTo &&
        other.childrenStayFree == childrenStayFree &&
        other.infantAge == infantAge &&
        other.minGuestAge == minGuestAge &&
        other.latitude == latitude &&
        other.longitude == longitude &&
        listEquals(other.ratings, ratings) &&
        other.checkInInstruction == checkInInstruction &&
        other.checkInSpecialInstruction == checkInSpecialInstruction &&
        other.singleRoomProperty == singleRoomProperty &&
        other.checkIn == checkIn &&
        other.checkOut == checkOut &&
        other.description == description &&
        other.myBizAssured == myBizAssured &&
        other.gstin == gstin &&
        listEquals(other.mmtAmenities, mmtAmenities) &&
        listEquals(other.expediaAmenities, expediaAmenities) &&
        listEquals(other.mmtMedia, mmtMedia) &&
        listEquals(other.agodaAmenities, agodaAmenities) &&
        listEquals(other.agodaMedia, agodaMedia) &&
        listEquals(other.mmtRooms, mmtRooms) &&
        listEquals(other.agodaRooms, agodaRooms) &&
        listEquals(other.mmtPolicies, mmtPolicies) &&
        listEquals(other.expediaRooms, expediaRooms) &&
        other.expediaPolicies == expediaPolicies &&
        other.expediaOnsitePayment == expediaOnsitePayment &&
        listEquals(other.expediaImages, expediaImages);
  }

  @override
  int get hashCode {
    return hotelId.hashCode ^
        mmtId.hashCode ^
        agodaId.hashCode ^
        expediaId.hashCode ^
        name.hashCode ^
        hotelChainName.hashCode ^
        address.hashCode ^
        pinCode.hashCode ^
        propertyType.hashCode ^
        childrenAgeFrom.hashCode ^
        childrenAgeTo.hashCode ^
        childrenStayFree.hashCode ^
        infantAge.hashCode ^
        minGuestAge.hashCode ^
        latitude.hashCode ^
        longitude.hashCode ^
        ratings.hashCode ^
        checkInInstruction.hashCode ^
        checkInSpecialInstruction.hashCode ^
        singleRoomProperty.hashCode ^
        checkIn.hashCode ^
        checkOut.hashCode ^
        description.hashCode ^
        myBizAssured.hashCode ^
        gstin.hashCode ^
        mmtAmenities.hashCode ^
        expediaAmenities.hashCode ^
        mmtMedia.hashCode ^
        agodaAmenities.hashCode ^
        agodaMedia.hashCode ^
        mmtRooms.hashCode ^
        agodaRooms.hashCode ^
        mmtPolicies.hashCode ^
        expediaRooms.hashCode ^
        expediaPolicies.hashCode ^
        expediaOnsitePayment.hashCode ^
        expediaImages.hashCode;
  }
}
