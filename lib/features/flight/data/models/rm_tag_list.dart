import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:yellow_rose/features/flight/data/models/rmtags.dart';

class RmTagsList {
  List<RmTags> rmTagsList;
  RmTagsList({
    required this.rmTagsList,
  });

  RmTagsList copyWith({
    List<RmTags>? rmTagsList,
  }) {
    return RmTagsList(
      rmTagsList: rmTagsList ?? this.rmTagsList,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'rmTagsList': rmTagsList.map((x) => x.toMap()).toList()});

    return result;
  }

  factory RmTagsList.fromMap(Map<String, dynamic> map) {
    return RmTagsList(
      rmTagsList:
          List<RmTags>.from(map['rmTagsList']?.map((x) => RmTags.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory RmTagsList.fromJson(String source) =>
      RmTagsList.fromMap(json.decode(source));

  @override
  String toString() => 'RmTagsList(rmTagsList: $rmTagsList)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RmTagsList && listEquals(other.rmTagsList, rmTagsList);
  }

  @override
  int get hashCode => rmTagsList.hashCode;
}
