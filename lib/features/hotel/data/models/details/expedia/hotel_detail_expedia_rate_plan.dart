import 'dart:convert';

import 'package:yellow_rose/features/hotel/data/models/details/expedia/bed_group.dart';
import 'package:yellow_rose/features/hotel/data/models/details/expedia/cancel_penalty.dart';
import 'package:yellow_rose/features/hotel/data/models/details/expedia/deposit.dart';
import 'package:yellow_rose/features/hotel/data/models/details/expedia/marketing_fee_incentive.dart';
import 'package:yellow_rose/features/hotel/data/models/details/expedia/occupancy_pricing.dart';
import 'package:yellow_rose/features/hotel/data/models/details/expedia/occupancy_pricing_total.dart';
import 'package:yellow_rose/features/hotel/data/models/details/expedia/payment_option_link.dart';
import 'package:yellow_rose/features/hotel/data/models/details/expedia/pricing_component.dart';
import 'package:yellow_rose/features/hotel/data/models/details/expedia/promotions.dart';
import 'package:yellow_rose/features/hotel/data/models/details/expedia/resp_id.dart';
import 'package:yellow_rose/features/hotel/data/models/details/expedia/response_value_currency.dart';
import 'package:yellow_rose/features/hotel/data/models/details/expedia/sale_sceneraio.dart';
import 'package:yellow_rose/features/hotel/data/models/details/expedia/search_response_fees.dart';
import 'package:yellow_rose/features/hotel/data/models/details/expedia/start_end.dart';
import 'package:yellow_rose/features/hotel/data/models/details/hotel_detail_commercial.dart';

class HotelDetailExpediaRatePlan  {
    final String? id;
  final String? status;
  final int? availableRooms;
  final bool? refundable;
  final bool? memberDealAvailable;
  final ExpediaHotelSearchRespSaleScenario? saleScenario;
  final String? merchantOfRecord;
  final List<ExpediaHotelSearchRespIdName>? amenities;
  final ExpediaHotelSearchResponsePaymentOptionLink? links;
  final List<ExpediaHotelSearchResponseBedGroup>? bedGroups;
  final List<ExpediaHotelSearchRespCancelPenalty>? cancelPenalties;
  final List<ExpediaHotelSearchResponseStartEnd>? nonrefundableDateRanges;
  final List<ExpediaHotelSearchRespMarketingFeeIncentive>? marketingFeeIncentives;
  final List<ExpediaHotelSearchResponseOccupancyPricing>? occupancyPricings;
  final ExpediaHotelSearchResponsePromotions? promotions;
  final ExpediaHotelSearchRespValueCurrency? cardOnFileLimit;
  final ExpediaHotelSearchRespValueCurrency? refundableDamageDeposit;
  final List<ExpediaHotelSearchRespDeposit>? deposits;

  // Extra fields
  final ExpediaHotelDetailUIRespPricingTotals? totalPrice;
  final ExpediaHotelSearchResponseFees? fees;
  final ExpediaPricingComponents? pricingComponents;
  final HotelDetailCommercial? commercial;
  final List<ExpediaHotelSearchRespCancelPenalty>? applyCancelPenalties;

  const HotelDetailExpediaRatePlan({
    this.id,
    this.status,
    this.availableRooms,
    this.refundable,
    this.memberDealAvailable,
    this.saleScenario,
    this.merchantOfRecord,
    this.amenities,
    this.links,
    this.bedGroups,
    this.cancelPenalties,
    this.nonrefundableDateRanges,
    this.marketingFeeIncentives,
    this.occupancyPricings,
    this.promotions,
    this.cardOnFileLimit,
    this.refundableDamageDeposit,
    this.deposits,
    this.totalPrice,
    this.fees,
    this.pricingComponents,
    this.commercial,
    this.applyCancelPenalties,
  });

  factory HotelDetailExpediaRatePlan.fromJson(String source) =>
      HotelDetailExpediaRatePlan.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());

  factory HotelDetailExpediaRatePlan.fromMap(Map<String, dynamic> map) {
    return HotelDetailExpediaRatePlan(
      id: map['id'],
      status: map['status'],
      availableRooms: map['available_rooms'],
      refundable: map['refundable'],
      memberDealAvailable: map['member_deal_available'],
      saleScenario: map['sale_scenario'] != null
          ? ExpediaHotelSearchRespSaleScenario.fromMap(map['sale_scenario'])
          : null,
      merchantOfRecord: map['merchant_of_record'],
      amenities: map['amenities'] != null
          ? List<ExpediaHotelSearchRespIdName>.from(
              map['amenities'].map((x) => ExpediaHotelSearchRespIdName.fromMap(x)))
          : null,
      links: map['links'] != null
          ? ExpediaHotelSearchResponsePaymentOptionLink.fromMap(map['links'])
          : null,
      bedGroups: map['bed_groups'] != null
          ? List<ExpediaHotelSearchResponseBedGroup>.from(
              map['bed_groups'].map((x) => ExpediaHotelSearchResponseBedGroup.fromMap(x)))
          : null,
      cancelPenalties: map['cancel_penalties'] != null
          ? List<ExpediaHotelSearchRespCancelPenalty>.from(
              map['cancel_penalties'].map((x) => ExpediaHotelSearchRespCancelPenalty.fromMap(x)))
          : null,
      nonrefundableDateRanges: map['nonrefundable_date_ranges'] != null
          ? List<ExpediaHotelSearchResponseStartEnd>.from(
              map['nonrefundable_date_ranges'].map((x) => ExpediaHotelSearchResponseStartEnd.fromMap(x)))
          : null,
      marketingFeeIncentives: map['marketing_fee_incentives'] != null
          ? List<ExpediaHotelSearchRespMarketingFeeIncentive>.from(
              map['marketing_fee_incentives'].map((x) => ExpediaHotelSearchRespMarketingFeeIncentive.fromMap(x)))
          : null,
      occupancyPricings: map['occupancy_pricing'] != null
          ? List<ExpediaHotelSearchResponseOccupancyPricing>.from(
              map['occupancy_pricing'].map((x) => ExpediaHotelSearchResponseOccupancyPricing.fromMap(x)))
          : null,
      promotions: map['promotions'] != null
          ? ExpediaHotelSearchResponsePromotions.fromMap(map['promotions'])
          : null,
      cardOnFileLimit: map['card_on_file_limit'] != null
          ? ExpediaHotelSearchRespValueCurrency.fromMap(map['card_on_file_limit'])
          : null,
      refundableDamageDeposit: map['refundable_damage_deposit'] != null
          ? ExpediaHotelSearchRespValueCurrency.fromMap(map['refundable_damage_deposit'])
          : null,
      deposits: map['deposits'] != null
          ? List<ExpediaHotelSearchRespDeposit>.from(
              map['deposits'].map((x) => ExpediaHotelSearchRespDeposit.fromMap(x)))
          : null,
      totalPrice: map['totalPrice'] != null
          ? ExpediaHotelDetailUIRespPricingTotals.fromMap(map['totalPrice'])
          : null,
      fees: map['fees'] != null
          ? ExpediaHotelSearchResponseFees.fromMap(map['fees'])
          : null,
      pricingComponents: map['pricingComponents'] != null
          ? ExpediaPricingComponents.fromMap(map['pricingComponents'])
          : null,
      commercial: map['commercial'] != null
          ? HotelDetailCommercial.fromMap(map['commercial'])
          : null,
      applyCancelPenalties: map['applyCancelPenalties'] != null
          ? List<ExpediaHotelSearchRespCancelPenalty>.from(
              map['applyCancelPenalties'].map((x) => ExpediaHotelSearchRespCancelPenalty.fromMap(x)))
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'status': status,
      'available_rooms': availableRooms,
      'refundable': refundable,
      'member_deal_available': memberDealAvailable,
      'sale_scenario': saleScenario?.toMap(),
      'merchant_of_record': merchantOfRecord,
      'amenities': amenities?.map((x) => x.toMap()).toList(),
      'links': links?.toMap(),
      'bed_groups': bedGroups?.map((x) => x.toMap()).toList(),
      'cancel_penalties': cancelPenalties?.map((x) => x.toMap()).toList(),
      'nonrefundable_date_ranges': nonrefundableDateRanges?.map((x) => x.toMap()).toList(),
      'marketing_fee_incentives': marketingFeeIncentives?.map((x) => x.toMap()).toList(),
      'occupancy_pricing': occupancyPricings?.map((x) => x.toMap()).toList(),
      'promotions': promotions?.toMap(),
      'card_on_file_limit': cardOnFileLimit?.toMap(),
      'refundable_damage_deposit': refundableDamageDeposit?.toMap(),
      'deposits': deposits?.map((x) => x.toMap()).toList(),
      'totalPrice': totalPrice?.toMap(),
      'fees': fees?.toMap(),
      'pricingComponents': pricingComponents?.toMap(),
      'commercial': commercial?.toMap(),
      'applyCancelPenalties': applyCancelPenalties?.map((x) => x.toMap()).toList(),
    };
  }

  HotelDetailExpediaRatePlan copyWith({
    String? id,
    String? status,
    int? availableRooms,
    bool? refundable,
    bool? memberDealAvailable,
    ExpediaHotelSearchRespSaleScenario? saleScenario,
    String? merchantOfRecord,
    List<ExpediaHotelSearchRespIdName>? amenities,
    ExpediaHotelSearchResponsePaymentOptionLink? links,
    List<ExpediaHotelSearchResponseBedGroup>? bedGroups,
    List<ExpediaHotelSearchRespCancelPenalty>? cancelPenalties,
    List<ExpediaHotelSearchResponseStartEnd>? nonrefundableDateRanges,
    List<ExpediaHotelSearchRespMarketingFeeIncentive>? marketingFeeIncentives,
    List<ExpediaHotelSearchResponseOccupancyPricing>? occupancyPricings,
    ExpediaHotelSearchResponsePromotions? promotions,
    ExpediaHotelSearchRespValueCurrency? cardOnFileLimit,
    ExpediaHotelSearchRespValueCurrency? refundableDamageDeposit,
    List<ExpediaHotelSearchRespDeposit>? deposits,
    ExpediaHotelDetailUIRespPricingTotals? totalPrice,
    ExpediaHotelSearchResponseFees? fees,
    ExpediaPricingComponents? pricingComponents,
    HotelDetailCommercial? commercial,
    List<ExpediaHotelSearchRespCancelPenalty>? applyCancelPenalties,
  }) {
    return HotelDetailExpediaRatePlan(
      id: id ?? this.id,
      status: status ?? this.status,
      availableRooms: availableRooms ?? this.availableRooms,
      refundable: refundable ?? this.refundable,
      memberDealAvailable: memberDealAvailable ?? this.memberDealAvailable,
      saleScenario: saleScenario ?? this.saleScenario,
      merchantOfRecord: merchantOfRecord ?? this.merchantOfRecord,
      amenities: amenities ?? this.amenities,
      links: links ?? this.links,
      bedGroups: bedGroups ?? this.bedGroups,
      cancelPenalties: cancelPenalties ?? this.cancelPenalties,
      nonrefundableDateRanges: nonrefundableDateRanges ?? this.nonrefundableDateRanges,
      marketingFeeIncentives: marketingFeeIncentives ?? this.marketingFeeIncentives,
      occupancyPricings: occupancyPricings ?? this.occupancyPricings,
      promotions: promotions ?? this.promotions,
      cardOnFileLimit: cardOnFileLimit ?? this.cardOnFileLimit,
      refundableDamageDeposit: refundableDamageDeposit ?? this.refundableDamageDeposit,
      deposits: deposits ?? this.deposits,
      totalPrice: totalPrice ?? this.totalPrice,
      fees: fees ?? this.fees,
      pricingComponents: pricingComponents ?? this.pricingComponents,
      commercial: commercial ?? this.commercial,
      applyCancelPenalties: applyCancelPenalties ?? this.applyCancelPenalties,
    );
  }
}