import 'dart:convert';

import 'package:yellow_rose/features/hotel/data/models/details/expedia/room/bed_group.dart';
import 'package:yellow_rose/features/hotel/data/models/details/expedia/room/content_response_arear.dart';
import 'package:yellow_rose/features/hotel/data/models/details/expedia/room/content_room_images.dart';
import 'package:yellow_rose/features/hotel/data/models/details/expedia/room/resposne_id_name.dart';
import 'package:yellow_rose/features/hotel/data/models/details/expedia/room/room_animeties.dart';
import 'package:yellow_rose/features/hotel/data/models/details/expedia/room/room_description.dart';
import 'package:yellow_rose/features/hotel/data/models/details/expedia/room/room_occupancy.dart';

class ExpediaHotelContentResponseRoom {
  final String? id;
  final String? name;
  final ExpediaHotelContentResponseRoomDescription? descriptions;
  final List<ExpediaHotelContentResponseAmenity>? amenities;
  final List<ExpediaHotelContentResponseImage>? images;
  final List<ExpediaHotelContentResponseBedGroup>? bedGroups;
  final ExpediaHotelContentResponseArea? area;
  final List<ExpediaHotelContentResponseIdName>? views;
  final ExpediaHotelContentResponseRoomOccupancy? occupancy;

  const ExpediaHotelContentResponseRoom({
    this.id,
    this.name,
    this.descriptions,
    this.amenities,
    this.images,
    this.bedGroups,
    this.area,
    this.views,
    this.occupancy,
  });

  factory ExpediaHotelContentResponseRoom.fromMap(Map<String, dynamic> map) {
    return ExpediaHotelContentResponseRoom(
      id: map['id'],
      name: map['name'],
      descriptions: map['descriptions'] != null
          ? ExpediaHotelContentResponseRoomDescription.fromMap(
              map['descriptions'])
          : null,
      amenities: (map['amenities'] as List?)
          ?.map((e) => ExpediaHotelContentResponseAmenity.fromMap(e))
          .toList(),
      images: (map['images'] as List?)
          ?.map((e) => ExpediaHotelContentResponseImage.fromMap(e))
          .toList(),
      bedGroups: (map['bed_groups'] as List?)
          ?.map((e) => ExpediaHotelContentResponseBedGroup.fromMap(e))
          .toList(),
      area: map['area'] != null
          ? ExpediaHotelContentResponseArea.fromMap(map['area'])
          : null,
      views: (map['views'] as List?)
          ?.map((e) => ExpediaHotelContentResponseIdName.fromMap(e))
          .toList(),
      occupancy: map['occupancy'] != null
          ? ExpediaHotelContentResponseRoomOccupancy.fromMap(map['occupancy'])
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'descriptions': descriptions?.toMap(),
      'amenities': amenities?.map((e) => e.toMap()).toList(),
      'images': images?.map((e) => e.toMap()).toList(),
      'bed_groups': bedGroups?.map((e) => e.toMap()).toList(),
      'area': area?.toMap(),
      'views': views?.map((e) => e.toMap()).toList(),
      'occupancy': occupancy?.toMap(),
    };
  }

  String toJson() => json.encode(toMap());

  factory ExpediaHotelContentResponseRoom.fromJson(String source) =>
      ExpediaHotelContentResponseRoom.fromMap(json.decode(source));
}
