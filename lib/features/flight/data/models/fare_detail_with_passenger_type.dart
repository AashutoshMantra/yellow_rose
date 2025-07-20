import 'dart:convert';

import 'package:yellow_rose/core/utils/extensions.dart';
import 'package:yellow_rose/features/flight/data/models/all_passenger_type.dart';
import 'package:yellow_rose/features/flight/domain/entities/passenger_type.dart';

class FareDetailsPerPassengerType {
  final double baseFare;
  final double finalTax;
  final Map<String, Object>? miscellaneousData;
  final Map<String, List<double>>? taxes;
  final AllPassengerType passengerType;
  FareDetailsPerPassengerType({
    this.baseFare = 0,
    this.finalTax = 0,
    this.miscellaneousData,
    this.taxes,
    required this.passengerType,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'baseFare': baseFare});
    result.addAll({'finalTax': finalTax});
    if (miscellaneousData != null) {
      result.addAll({'miscellaneousData': miscellaneousData});
    }
    if (taxes != null) {
      result.addAll({'taxes': taxes});
    }
    result.addAll({'passengerType': passengerType.name});

    return result;
  }

  factory FareDetailsPerPassengerType.fromMap(Map<String, dynamic> map) {
    return FareDetailsPerPassengerType(
      baseFare: map['baseFare']?.toDouble() ?? 0.0,
      finalTax: map['finalTax']?.toDouble() ?? 0.0,
      miscellaneousData: map['miscellaneousData'] != null
          ? Map<String, Object>.from(map['miscellaneousData'])
          : null,
      taxes: map['taxes'] != null
          ? (map['taxes'] as Map).map<String, List<double>>(
              (key, value) => MapEntry(
                key.toString(), // Ensure key is a String
                (value as List).map((e) => (e as num).toDouble()).toList(),
              ),
            )
          : null,
      passengerType:
          stringToEnum(map['passengerType'], AllPassengerType.values) ??
              AllPassengerType.ADT,
    );
  }

  String toJson() => json.encode(toMap());

  factory FareDetailsPerPassengerType.fromJson(String source) =>
      FareDetailsPerPassengerType.fromMap(json.decode(source));
}
