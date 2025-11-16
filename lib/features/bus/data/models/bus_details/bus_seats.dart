import 'dart:convert';

import 'package:yellow_rose/features/bus/data/models/search/red_bus_comercial.dart';

class BusSeats {
  String? name;
  int? row;
  int? column;
  double? baseFare;
  double? fare;
  double? serviceTaxAbsolute;
  bool? available;
  bool? ladiesSeat;
  bool? malesSeat;
  bool? window;
  bool? doubleBirth;
  double? markupFareAbsolute;
  String? berth;
  int? length;
  int? width;
  RedbusCommercial? commercialData;
  BusSeats({
    this.name,
    this.row,
    this.column,
    this.baseFare,
    this.fare,
    this.serviceTaxAbsolute,
    this.available,
    this.ladiesSeat,
    this.malesSeat,
    this.window,
    this.doubleBirth,
    this.markupFareAbsolute,
    this.berth,
    this.length,
    this.width,
    this.commercialData,
  });

  BusSeats copyWith({
    String? name,
    int? row,
    int? column,
    double? baseFare,
    double? fare,
    double? serviceTaxAbsolute,
    bool? available,
    bool? ladiesSeat,
    bool? malesSeat,
    bool? window,
    bool? doubleBirth,
    double? markupFareAbsolute,
    String? berth,
    int? length,
    int? width,
    RedbusCommercial? commercialData,
  }) {
    return BusSeats(
      name: name ?? this.name,
      row: row ?? this.row,
      column: column ?? this.column,
      baseFare: baseFare ?? this.baseFare,
      fare: fare ?? this.fare,
      serviceTaxAbsolute: serviceTaxAbsolute ?? this.serviceTaxAbsolute,
      available: available ?? this.available,
      ladiesSeat: ladiesSeat ?? this.ladiesSeat,
      malesSeat: malesSeat ?? this.malesSeat,
      window: window ?? this.window,
      doubleBirth: doubleBirth ?? this.doubleBirth,
      markupFareAbsolute: markupFareAbsolute ?? this.markupFareAbsolute,
      berth: berth ?? this.berth,
      length: length ?? this.length,
      width: width ?? this.width,
      commercialData: commercialData ?? this.commercialData,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (name != null) {
      result.addAll({'name': name});
    }
    if (row != null) {
      result.addAll({'row': row});
    }
    if (column != null) {
      result.addAll({'column': column});
    }
    if (baseFare != null) {
      result.addAll({'baseFare': baseFare});
    }
    if (fare != null) {
      result.addAll({'fare': fare});
    }
    if (serviceTaxAbsolute != null) {
      result.addAll({'serviceTaxAbsolute': serviceTaxAbsolute});
    }
    if (available != null) {
      result.addAll({'available': available});
    }
    if (ladiesSeat != null) {
      result.addAll({'ladiesSeat': ladiesSeat});
    }
    if (malesSeat != null) {
      result.addAll({'malesSeat': malesSeat});
    }
    if (window != null) {
      result.addAll({'window': window});
    }
    if (doubleBirth != null) {
      result.addAll({'doubleBirth': doubleBirth});
    }
    if (markupFareAbsolute != null) {
      result.addAll({'markupFareAbsolute': markupFareAbsolute});
    }
    if (berth != null) {
      result.addAll({'berth': berth});
    }
    if (length != null) {
      result.addAll({'length': length});
    }
    if (width != null) {
      result.addAll({'width': width});
    }
    if (commercialData != null) {
      result.addAll({'commercialData': commercialData!.toMap()});
    }

    return result;
  }

  factory BusSeats.fromMap(Map<String, dynamic> map) {
    return BusSeats(
      name: map['name'],
      row: map['row']?.toInt(),
      column: map['column']?.toInt(),
      baseFare: map['baseFare']?.toDouble(),
      fare: map['fare']?.toDouble(),
      serviceTaxAbsolute: map['serviceTaxAbsolute']?.toDouble(),
      available: map['available'],
      ladiesSeat: map['ladiesSeat'],
      malesSeat: map['malesSeat'],
      window: map['window'],
      doubleBirth: map['doubleBirth'],
      markupFareAbsolute: map['markupFareAbsolute']?.toDouble(),
      berth: map['berth'],
      length: map['length']?.toInt(),
      width: map['width']?.toInt(),
      commercialData: map['commercialData'] != null
          ? RedbusCommercial.fromMap(map['commercialData'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BusSeats.fromJson(String source) =>
      BusSeats.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BusSeats(name: $name, row: $row, column: $column, baseFare: $baseFare, fare: $fare, serviceTaxAbsolute: $serviceTaxAbsolute, available: $available, ladiesSeat: $ladiesSeat, malesSeat: $malesSeat, window: $window, doubleBirth: $doubleBirth, markupFareAbsolute: $markupFareAbsolute, berth: $berth, length: $length, width: $width, commercialData: $commercialData)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BusSeats &&
        other.name == name &&
        other.row == row &&
        other.column == column &&
        other.baseFare == baseFare &&
        other.fare == fare &&
        other.serviceTaxAbsolute == serviceTaxAbsolute &&
        other.available == available &&
        other.ladiesSeat == ladiesSeat &&
        other.malesSeat == malesSeat &&
        other.window == window &&
        other.doubleBirth == doubleBirth &&
        other.markupFareAbsolute == markupFareAbsolute &&
        other.berth == berth &&
        other.length == length &&
        other.width == width &&
        other.commercialData == commercialData;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        row.hashCode ^
        column.hashCode ^
        baseFare.hashCode ^
        fare.hashCode ^
        serviceTaxAbsolute.hashCode ^
        available.hashCode ^
        ladiesSeat.hashCode ^
        malesSeat.hashCode ^
        window.hashCode ^
        doubleBirth.hashCode ^
        markupFareAbsolute.hashCode ^
        berth.hashCode ^
        length.hashCode ^
        width.hashCode ^
        commercialData.hashCode;
  }

  bool get isSeat {
    return length == 1 && width == 1;
  }

  bool get isSleeperHorizontal {
    return length == 2 && width == 1;
  }

  bool get isSleeperVertical {
    return length == 1 && width == 2;
  }
}
