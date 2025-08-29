import 'dart:convert';

import 'package:yellow_rose/features/hotel/data/models/details/expedia/room/occupancy_max_allowed.dart';
import 'package:yellow_rose/features/hotel/data/models/details/expedia/room/room_age_category.dart';

class ExpediaHotelContentResponseRoomOccupancy {
  final ExpediaHotelContentResponseRoomOccupancyMaxAllowed? maxAllowed;
  final List<ExpediaHotelContentResponseRoomAgeCategory>? ageCategories;

  const ExpediaHotelContentResponseRoomOccupancy({
    this.maxAllowed,
    this.ageCategories,
  });

  factory ExpediaHotelContentResponseRoomOccupancy.fromMap(
      Map<String, dynamic> map) {
    return ExpediaHotelContentResponseRoomOccupancy(
      maxAllowed: map['max_allowed'] != null
          ? ExpediaHotelContentResponseRoomOccupancyMaxAllowed.fromMap(
              map['max_allowed'])
          : null,
      ageCategories: (map['age_categories'] as List?)
          ?.map((e) => ExpediaHotelContentResponseRoomAgeCategory.fromMap(e))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'max_allowed': maxAllowed?.toMap(),
      'age_categories': ageCategories?.map((e) => e.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());

  factory ExpediaHotelContentResponseRoomOccupancy.fromJson(String source) =>
      ExpediaHotelContentResponseRoomOccupancy.fromMap(json.decode(source));
}
