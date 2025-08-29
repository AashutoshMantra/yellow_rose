import 'dart:convert';

import 'package:flutter/foundation.dart';

class ExpediRoomImageModel {
  bool? heroImage;
  int? category;
  String? caption;
  List<ExpediImagesLink>? links;

  ExpediRoomImageModel({
    this.heroImage,
    this.category,
    this.caption,
    this.links,
  });

  ExpediRoomImageModel copyWith({
    bool? heroImage,
    int? category,
    String? caption,
    List<ExpediImagesLink>? links,
  }) {
    return ExpediRoomImageModel(
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

  factory ExpediRoomImageModel.fromMap(Map<String, dynamic> map) {
    return ExpediRoomImageModel(
      heroImage: map['heroImage'],
      category: map['category']?.toInt(),
      caption: map['caption'],
      links: map['links'] != null
          ? List<ExpediImagesLink>.from(
              map['links']?.map((x) => ExpediImagesLink.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ExpediRoomImageModel.fromJson(String source) =>
      ExpediRoomImageModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ExpediRoomImageModel(heroImage: $heroImage, category: $category, caption: $caption, links: $links)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ExpediRoomImageModel &&
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

class ExpediImagesLink {
  String? id;
  String? method;
  String? href;
  String? expires;

  ExpediImagesLink({
    this.id,
    this.method,
    this.href,
    this.expires,
  });

  ExpediImagesLink copyWith({
    String? id,
    String? method,
    String? href,
    String? expires,
  }) {
    return ExpediImagesLink(
      id: id ?? this.id,
      method: method ?? this.method,
      href: href ?? this.href,
      expires: expires ?? this.expires,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (method != null) {
      result.addAll({'method': method});
    }
    if (href != null) {
      result.addAll({'href': href});
    }
    if (expires != null) {
      result.addAll({'expires': expires});
    }

    return result;
  }

  factory ExpediImagesLink.fromMap(Map<String, dynamic> map) {
    return ExpediImagesLink(
      id: map['id'],
      method: map['method'],
      href: map['href'],
      expires: map['expires'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ExpediImagesLink.fromJson(String source) =>
      ExpediImagesLink.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ExpediImagesLink(id: $id, method: $method, href: $href, expires: $expires)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ExpediImagesLink &&
        other.id == id &&
        other.method == method &&
        other.href == href &&
        other.expires == expires;
  }

  @override
  int get hashCode {
    return id.hashCode ^ method.hashCode ^ href.hashCode ^ expires.hashCode;
  }
}
