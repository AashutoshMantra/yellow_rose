import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:yellow_rose/features/hotel/data/models/review_rating.dart';
import 'package:yellow_rose/features/hotel/data/models/search/geo_locations.dart';
import 'package:yellow_rose/features/hotel/data/models/search/hotel_search_response_entoty.dart';
import 'package:yellow_rose/features/hotel/data/models/search/hotel_search_response_room.dart';

class HotelSearchResponse {
  final int? id;
  final String? agodaSearchId;
  final String? mmtHotelId;
  final String? agodaHotelId;
  final String? name;
  final String? checkIn;
  final String? checkOut;
  final GeoLocation? geo;
  final double? starRating;
  final String? propertyType;
  final ReviewDetail? reviewDetails;
  final List<HotelSearchResponseAmenity>? amenities;
  final List<String>? media;
  final List<HotelSearchResponseRoom>? rooms;
  final String? source;
  final String? address;
  HotelSearchResponse({
    this.id,
    this.agodaSearchId,
    this.mmtHotelId,
    this.agodaHotelId,
    this.name,
    this.checkIn,
    this.checkOut,
    this.geo,
    this.starRating,
    this.propertyType,
    this.reviewDetails,
    this.amenities,
    this.media,
    this.rooms,
    this.source,
    this.address,
  });

  HotelSearchResponse copyWith({
    int? id,
    String? agodaSearchId,
    String? mmtHotelId,
    String? agodaHotelId,
    String? name,
    String? checkIn,
    String? checkOut,
    GeoLocation? geo,
    double? starRating,
    String? propertyType,
    ReviewDetail? reviewDetails,
    List<HotelSearchResponseAmenity>? amenities,
    List<String>? media,
    List<HotelSearchResponseRoom>? rooms,
    String? source,
    String? address,
  }) {
    return HotelSearchResponse(
      id: id ?? this.id,
      agodaSearchId: agodaSearchId ?? this.agodaSearchId,
      mmtHotelId: mmtHotelId ?? this.mmtHotelId,
      agodaHotelId: agodaHotelId ?? this.agodaHotelId,
      name: name ?? this.name,
      checkIn: checkIn ?? this.checkIn,
      checkOut: checkOut ?? this.checkOut,
      geo: geo ?? this.geo,
      starRating: starRating ?? this.starRating,
      propertyType: propertyType ?? this.propertyType,
      reviewDetails: reviewDetails ?? this.reviewDetails,
      amenities: amenities ?? this.amenities,
      media: media ?? this.media,
      rooms: rooms ?? this.rooms,
      source: source ?? this.source,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(id != null){
      result.addAll({'id': id});
    }
    if(agodaSearchId != null){
      result.addAll({'agodaSearchId': agodaSearchId});
    }
    if(mmtHotelId != null){
      result.addAll({'mmtHotelId': mmtHotelId});
    }
    if(agodaHotelId != null){
      result.addAll({'agodaHotelId': agodaHotelId});
    }
    if(name != null){
      result.addAll({'name': name});
    }
    if(checkIn != null){
      result.addAll({'checkIn': checkIn});
    }
    if(checkOut != null){
      result.addAll({'checkOut': checkOut});
    }
    if(geo != null){
      result.addAll({'geo': geo!.toMap()});
    }
    if(starRating != null){
      result.addAll({'starRating': starRating});
    }
    if(propertyType != null){
      result.addAll({'propertyType': propertyType});
    }
    if(reviewDetails != null){
      result.addAll({'reviewDetails': reviewDetails!.toMap()});
    }
    if(amenities != null){
      result.addAll({'amenities': amenities!.map((x) => x?.toMap()).toList()});
    }
    if(media != null){
      result.addAll({'media': media});
    }
    if(rooms != null){
      result.addAll({'rooms': rooms!.map((x) => x?.toMap()).toList()});
    }
    if(source != null){
      result.addAll({'source': source});
    }
    if(address != null){
      result.addAll({'address': address});
    }
  
    return result;
  }

  factory HotelSearchResponse.fromMap(Map<String, dynamic> map) {
    return HotelSearchResponse(
      id: map['id']?.toInt(),
      agodaSearchId: map['agodaSearchId'],
      mmtHotelId: map['mmtHotelId'],
      agodaHotelId: map['agodaHotelId'],
      name: map['name'],
      checkIn: map['checkIn'],
      checkOut: map['checkOut'],
      geo: map['geo'] != null ? GeoLocation.fromMap(map['geo']) : null,
      starRating: map['starRating']?.toDouble(),
      propertyType: map['propertyType'],
      reviewDetails: map['reviewDetails'] != null ? ReviewDetail.fromMap(map['reviewDetails']) : null,
      amenities: map['amenities'] != null ? List<HotelSearchResponseAmenity>.from(map['amenities']?.map((x) => HotelSearchResponseAmenity.fromMap(x))) : null,
      media: List<String>.from(map['media']??[]),
      rooms: map['rooms'] != null ? List<HotelSearchResponseRoom>.from(map['rooms']?.map((x) => HotelSearchResponseRoom.fromMap(x))) : null,
      source: map['source'],
      address: map['address'],
    );
  }

  String toJson() => json.encode(toMap());

  factory HotelSearchResponse.fromJson(String source) =>
      HotelSearchResponse.fromMap(json.decode(source));

  @override
  String toString() {
    return 'HotelSearchResponse(id: $id, agodaSearchId: $agodaSearchId, mmtHotelId: $mmtHotelId, agodaHotelId: $agodaHotelId, name: $name, checkIn: $checkIn, checkOut: $checkOut, geo: $geo, starRating: $starRating, propertyType: $propertyType, reviewDetails: $reviewDetails, amenities: $amenities, media: $media, rooms: $rooms, source: $source, address: $address)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is HotelSearchResponse &&
      other.id == id &&
      other.agodaSearchId == agodaSearchId &&
      other.mmtHotelId == mmtHotelId &&
      other.agodaHotelId == agodaHotelId &&
      other.name == name &&
      other.checkIn == checkIn &&
      other.checkOut == checkOut &&
      other.geo == geo &&
      other.starRating == starRating &&
      other.propertyType == propertyType &&
      other.reviewDetails == reviewDetails &&
      listEquals(other.amenities, amenities) &&
      listEquals(other.media, media) &&
      listEquals(other.rooms, rooms) &&
      other.source == source &&
      other.address == address;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      agodaSearchId.hashCode ^
      mmtHotelId.hashCode ^
      agodaHotelId.hashCode ^
      name.hashCode ^
      checkIn.hashCode ^
      checkOut.hashCode ^
      geo.hashCode ^
      starRating.hashCode ^
      propertyType.hashCode ^
      reviewDetails.hashCode ^
      amenities.hashCode ^
      media.hashCode ^
      rooms.hashCode ^
      source.hashCode ^
      address.hashCode;
  }
}
