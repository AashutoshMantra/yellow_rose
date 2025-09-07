import 'dart:convert';

import 'package:yellow_rose/features/hotel/data/models/details/expedia/response_link.dart';

class ExpediaHotelSearchResponsePriceCheckLink {
  final ExpediaResponseLink? priceCheck;
  ExpediaHotelSearchResponsePriceCheckLink({
    this.priceCheck,
  });

  ExpediaHotelSearchResponsePriceCheckLink copyWith({
    ExpediaResponseLink? priceCheck,
  }) {
    return ExpediaHotelSearchResponsePriceCheckLink(
      priceCheck: priceCheck ?? this.priceCheck,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (priceCheck != null) {
      result.addAll({'price_check': priceCheck!.toMap()});
    }

    return result;
  }

  factory ExpediaHotelSearchResponsePriceCheckLink.fromMap(
      Map<String, dynamic> map) {
    return ExpediaHotelSearchResponsePriceCheckLink(
      priceCheck: map['price_check'] != null
          ? ExpediaResponseLink.fromMap(map['price_check'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ExpediaHotelSearchResponsePriceCheckLink.fromJson(String source) =>
      ExpediaHotelSearchResponsePriceCheckLink.fromMap(json.decode(source));

  @override
  String toString() =>
      'ExpediaHotelSearchResponsePriceCheckLink(priceCheck: $priceCheck)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ExpediaHotelSearchResponsePriceCheckLink &&
        other.priceCheck == priceCheck;
  }

  @override
  int get hashCode => priceCheck.hashCode;
}
