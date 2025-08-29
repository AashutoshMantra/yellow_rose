import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:yellow_rose/features/hotel/data/models/details/expedia/room/content_response_link.dart';

class ExpediaHotelContentResponseImage {
  final bool? heroImage;
  final int? category;
  final String? caption;
  final List<ExpediaHotelContentResponseLink>? links;
  ExpediaHotelContentResponseImage({
    this.heroImage,
    this.category,
    this.caption,
    this.links,
  });

  ExpediaHotelContentResponseImage copyWith({
    bool? heroImage,
    int? category,
    String? caption,
    List<ExpediaHotelContentResponseLink>? links,
  }) {
    return ExpediaHotelContentResponseImage(
      heroImage: heroImage ?? this.heroImage,
      category: category ?? this.category,
      caption: caption ?? this.caption,
      links: links ?? this.links,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (heroImage != null) {
      result.addAll({'heroImage': heroImage});
    }
    if (category != null) {
      result.addAll({'category': category});
    }
    if (caption != null) {
      result.addAll({'caption': caption});
    }
    if (links != null) {
      result.addAll({'links': links!.map((x) => x.toMap()).toList()});
    }

    return result;
  }

  factory ExpediaHotelContentResponseImage.fromMap(Map<String, dynamic> map) {
    return ExpediaHotelContentResponseImage(
      heroImage: map['hero_image'],
      category: map['category']?.toInt(),
      caption: map['caption'],
      links: map['links'] != null
          ? List<ExpediaHotelContentResponseLink>.from(map['links']
              ?.map((x) => ExpediaHotelContentResponseLink.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ExpediaHotelContentResponseImage.fromJson(String source) =>
      ExpediaHotelContentResponseImage.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ExpediaHotelContentResponseImage(heroImage: $heroImage, category: $category, caption: $caption, links: $links)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ExpediaHotelContentResponseImage &&
        other.heroImage == heroImage &&
        other.category == category &&
        other.caption == caption &&
        listEquals(other.links, links);
  }

  @override
  int get hashCode {
    return heroImage.hashCode ^
        category.hashCode ^
        caption.hashCode ^
        links.hashCode;
  }
}
