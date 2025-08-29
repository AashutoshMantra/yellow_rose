import 'dart:convert';

import 'package:yellow_rose/features/hotel/data/models/details/expedia/value_add.dart';

class ExpediaHotelSearchResponsePromotions {
  final List<ExpediaHotelSearchRespValueAdds>? valueAdds;
  final Object? deal;

  const ExpediaHotelSearchResponsePromotions({
    this.valueAdds,
    this.deal,
  });

  factory ExpediaHotelSearchResponsePromotions.fromMap(
      Map<String, dynamic> map) {
    return ExpediaHotelSearchResponsePromotions(
      valueAdds: map['value_adds'] != null
          ? List<ExpediaHotelSearchRespValueAdds>.from(
              map['value_adds']
                  .map((e) => ExpediaHotelSearchRespValueAdds.fromMap(e)),
            )
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'value_adds': valueAdds?.map((e) => e.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());

  factory ExpediaHotelSearchResponsePromotions.fromJson(String source) =>
      ExpediaHotelSearchResponsePromotions.fromMap(json.decode(source));
}
