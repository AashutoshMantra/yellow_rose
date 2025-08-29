import 'dart:convert';

import 'package:yellow_rose/features/hotel/data/models/details/expedia/occupancy_pricing_total.dart';
import 'package:yellow_rose/features/hotel/data/models/details/expedia/search_response_fees.dart';
import 'package:yellow_rose/features/hotel/data/models/details/expedia/type_val_currency.dart';

class ExpediaHotelSearchResponseOccupancyPricing {
  final String? type;
  final int? adults;
  final List<int>? childrenAges;
  final List<List<ExpediaHotelSearchRespTypeValCurr>>? nightly;
  final List<ExpediaHotelSearchRespTypeValCurr>? stay;
  final ExpediaHotelDetailUIRespPricingTotals? totals;
  final ExpediaHotelSearchResponseFees? fees;

  const ExpediaHotelSearchResponseOccupancyPricing({
    this.type,
    this.adults,
    this.childrenAges,
    this.nightly,
    this.stay,
    this.totals,
    this.fees,
  });

  factory ExpediaHotelSearchResponseOccupancyPricing.fromMap(
      Map<String, dynamic> map) {
    return ExpediaHotelSearchResponseOccupancyPricing(
      type: map['type'],
      adults: map['adults'],
      childrenAges: map['childrenAges'] != null
          ? List<int>.from(map['childrenAges'])
          : null,
      nightly: map['nightly'] != null
          ? List<List<ExpediaHotelSearchRespTypeValCurr>>.from(
              (map['nightly'] as List)
                  .map((row) => List<ExpediaHotelSearchRespTypeValCurr>.from(
                        row.map((e) =>
                            ExpediaHotelSearchRespTypeValCurr.fromMap(e)),
                      )),
            )
          : null,
      stay: map['stay'] != null
          ? List<ExpediaHotelSearchRespTypeValCurr>.from(map['stay']
              .map((e) => ExpediaHotelSearchRespTypeValCurr.fromMap(e)))
          : null,
      totals: map['totals'] != null
          ? ExpediaHotelDetailUIRespPricingTotals.fromMap(map['totals'])
          : null,
      fees: map['fees'] != null
          ? ExpediaHotelSearchResponseFees.fromMap(map['fees'])
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'adults': adults,
      'childrenAges': childrenAges,
      'nightly':
          nightly?.map((row) => row.map((e) => e.toMap()).toList()).toList(),
      'stay': stay?.map((e) => e.toMap()).toList(),
      'totals': totals?.toMap(),
      'fees': fees?.toMap(),
    };
  }

  String toJson() => json.encode(toMap());

  factory ExpediaHotelSearchResponseOccupancyPricing.fromJson(String source) =>
      ExpediaHotelSearchResponseOccupancyPricing.fromMap(json.decode(source));
}
