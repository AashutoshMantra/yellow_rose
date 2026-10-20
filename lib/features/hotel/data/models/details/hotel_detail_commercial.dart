import 'dart:convert';

import 'package:flutter/foundation.dart';

class HotelDetailCommercial {
  final double? rootMarkup;
  final double? markup;
  final double? totalMarkup;
  final List<String>? markupDesc;
  final double? charge;
  final double? tax;
  final List<String>? taxDesc;
  final List<String>? chargeDesc;
  HotelDetailCommercial({
    this.rootMarkup,
    this.markup,
    this.totalMarkup,
    this.markupDesc,
    this.charge,
    this.tax,
    this.taxDesc,
    this.chargeDesc,
  });

  HotelDetailCommercial copyWith({
    double? rootMarkup,
    double? markup,
    double? totalMarkup,
    List<String>? markupDesc,
    double? charge,
    double? tax,
    List<String>? taxDesc,
    List<String>? chargeDesc,
  }) {
    return HotelDetailCommercial(
      rootMarkup: rootMarkup ?? this.rootMarkup,
      markup: markup ?? this.markup,
      totalMarkup: totalMarkup ?? this.totalMarkup,
      markupDesc: markupDesc ?? this.markupDesc,
      charge: charge ?? this.charge,
      tax: tax ?? this.tax,
      taxDesc: taxDesc ?? this.taxDesc,
      chargeDesc: chargeDesc ?? this.chargeDesc,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if(rootMarkup != null){
      result.addAll({'rootMarkup': rootMarkup});
    }
    if(markup != null){
      result.addAll({'markup': markup});
    }
    if(totalMarkup != null){
      result.addAll({'totalMarkup': totalMarkup});
    }
    if(markupDesc != null){
      result.addAll({'markupDesc': markupDesc});
    }
    if(charge != null){
      result.addAll({'charge': charge});
    }
    if(tax != null){
      result.addAll({'tax': tax});
    }
    if(taxDesc != null){
      result.addAll({'taxDesc': taxDesc});
    }
    if(chargeDesc != null){
      result.addAll({'chargeDesc': chargeDesc});
    }

    return result;
  }

  factory HotelDetailCommercial.fromMap(Map<String, dynamic> map) {
    return HotelDetailCommercial(
      rootMarkup: map['rootMarkup']?.toDouble(),
      markup: map['markup']?.toDouble(),
      totalMarkup: map['totalMarkup']?.toDouble(),
      markupDesc: map['markupDesc'] != null
          ? List<String>.from(map['markupDesc'])
          : null,
      charge: map['charge']?.toDouble(),
      tax: map['tax']?.toDouble(),
      taxDesc:
          map['taxDesc'] != null ? List<String>.from(map['taxDesc']) : null,
      chargeDesc: map['chargeDesc'] != null
          ? List<String>.from(map['chargeDesc'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory HotelDetailCommercial.fromJson(String source) => HotelDetailCommercial.fromMap(json.decode(source));

  @override
  String toString() {
    return 'HotelDetailCommercial(rootMarkup: $rootMarkup, markup: $markup, totalMarkup: $totalMarkup, markupDesc: $markupDesc, charge: $charge, tax: $tax, taxDesc: $taxDesc, chargeDesc: $chargeDesc)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HotelDetailCommercial &&
      other.rootMarkup == rootMarkup &&
      other.markup == markup &&
      other.totalMarkup == totalMarkup &&
      listEquals(other.markupDesc, markupDesc) &&
      other.charge == charge &&
      other.tax == tax &&
      listEquals(other.taxDesc, taxDesc) &&
      listEquals(other.chargeDesc, chargeDesc);
  }

  @override
  int get hashCode {
    return rootMarkup.hashCode ^
      markup.hashCode ^
      totalMarkup.hashCode ^
      markupDesc.hashCode ^
      charge.hashCode ^
      tax.hashCode ^
      taxDesc.hashCode ^
      chargeDesc.hashCode;
  }
}
