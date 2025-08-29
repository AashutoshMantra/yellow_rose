
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:yellow_rose/core/utils/extensions.dart';

import 'package:yellow_rose/features/hotel/data/models/details/agoda/benefit.dart';
import 'package:yellow_rose/features/hotel/data/models/details/agoda/cancellation_policy.dart';
import 'package:yellow_rose/features/hotel/data/models/details/agoda/dailey_rate.dart';
import 'package:yellow_rose/features/hotel/data/models/details/agoda/payment_mode.dart';
import 'package:yellow_rose/features/hotel/data/models/details/agoda/promotion_detail.dart';
import 'package:yellow_rose/features/hotel/data/models/details/agoda/res_per_room_per_rate_room.dart';
import 'package:yellow_rose/features/hotel/data/models/details/agoda/res_rate.dart';
import 'package:yellow_rose/features/hotel/data/models/details/agoda/surcharge_break_down.dart';
import 'package:yellow_rose/features/hotel/data/models/details/agoda/tax_break_donw.dart';
import 'package:yellow_rose/features/hotel/data/models/details/agoda/total_payment.dart';
import 'package:yellow_rose/features/hotel/data/models/details/hotel_detail_commercial.dart';

class HotelDetailAgodaRoom {
  final HotelDetailCommercial? commercial;
  final double? inclusive;

  final int? roomId;
  final String? roomName;
  final String? parentRoomName;
  final String? translatedRoomName;
  final String? blockIdBackup;
  final int? parentRoomId;
  final int? ratePlanId;
  final String? blockId;
  final AgodaHotelSearchResRate? rate;
  final AgodaHotelSearchResPerRoomPerNightRate? perRoomPerNightRate;
  final bool? freeBreakfast;
  final bool? freeCancellation;
  final String? freeCancellationDate;
  final String? landingUrl;
  final bool? payAtHotel;
  final AgodaHotelSearchResPromotionDetail? promotionDetail;
  final AgodaHotelSearchResTotalPayment? totalPayment;
  final AgodaPaymentModelEnum? paymentModel;
  final int? remainingRooms;
  final int? normalBedding;
  final int? extraBeds;
  final bool? roomTypeNotGuaranteed;
  final List<AgodaHotelSearchResBenefit>? benefits;
  final List<AgodaHotelSearchResDailyRate>? dailyBreakdown;
  final List<AgodaHotelSearchResDailyRate>? dailyRate;
  final AgodaHotelSearchResCancellationPolicy? cancellationPolicy;
  final bool? freeWifi;
  final List<AgodaHotelSearchResTaxBreakdown>? taxBreakdown;
  final List<AgodaHotelSearchResSurchargeBreakdown>? surcharges;
  final List<int>? channelIds;
  final DateTime? bookNowPayLaterDate;
  HotelDetailAgodaRoom({
    this.commercial,
    this.inclusive,
    this.roomId,
    this.roomName,
    this.parentRoomName,
    this.translatedRoomName,
    this.blockIdBackup,
    this.parentRoomId,
    this.ratePlanId,
    this.blockId,
    this.rate,
    this.perRoomPerNightRate,
    this.freeBreakfast,
    this.freeCancellation,
    this.freeCancellationDate,
    this.landingUrl,
    this.payAtHotel,
    this.promotionDetail,
    this.totalPayment,
    this.paymentModel,
    this.remainingRooms,
    this.normalBedding,
    this.extraBeds,
    this.roomTypeNotGuaranteed,
    this.benefits,
    this.dailyBreakdown,
    this.dailyRate,
    this.cancellationPolicy,
    this.freeWifi,
    this.taxBreakdown,
    this.surcharges,
    this.channelIds,
    this.bookNowPayLaterDate,
  });

  HotelDetailAgodaRoom copyWith({
    HotelDetailCommercial? commercial,
    double? inclusive,
    int? roomId,
    String? roomName,
    String? parentRoomName,
    String? translatedRoomName,
    String? blockIdBackup,
    int? parentRoomId,
    int? ratePlanId,
    String? blockId,
    AgodaHotelSearchResRate? rate,
    AgodaHotelSearchResPerRoomPerNightRate? perRoomPerNightRate,
    bool? freeBreakfast,
    bool? freeCancellation,
    String? freeCancellationDate,
    String? landingUrl,
    bool? payAtHotel,
    AgodaHotelSearchResPromotionDetail? promotionDetail,
    AgodaHotelSearchResTotalPayment? totalPayment,
    AgodaPaymentModelEnum? paymentModel,
    int? remainingRooms,
    int? normalBedding,
    int? extraBeds,
    bool? roomTypeNotGuaranteed,
    List<AgodaHotelSearchResBenefit>? benefits,
    List<AgodaHotelSearchResDailyRate>? dailyBreakdown,
    List<AgodaHotelSearchResDailyRate>? dailyRate,
    AgodaHotelSearchResCancellationPolicy? cancellationPolicy,
    bool? freeWifi,
    List<AgodaHotelSearchResTaxBreakdown>? taxBreakdown,
    List<AgodaHotelSearchResSurchargeBreakdown>? surcharges,
    List<int>? channelIds,
    DateTime? bookNowPayLaterDate,
  }) {
    return HotelDetailAgodaRoom(
      commercial: commercial ?? this.commercial,
      inclusive: inclusive ?? this.inclusive,
      roomId: roomId ?? this.roomId,
      roomName: roomName ?? this.roomName,
      parentRoomName: parentRoomName ?? this.parentRoomName,
      translatedRoomName: translatedRoomName ?? this.translatedRoomName,
      blockIdBackup: blockIdBackup ?? this.blockIdBackup,
      parentRoomId: parentRoomId ?? this.parentRoomId,
      ratePlanId: ratePlanId ?? this.ratePlanId,
      blockId: blockId ?? this.blockId,
      rate: rate ?? this.rate,
      perRoomPerNightRate: perRoomPerNightRate ?? this.perRoomPerNightRate,
      freeBreakfast: freeBreakfast ?? this.freeBreakfast,
      freeCancellation: freeCancellation ?? this.freeCancellation,
      freeCancellationDate: freeCancellationDate ?? this.freeCancellationDate,
      landingUrl: landingUrl ?? this.landingUrl,
      payAtHotel: payAtHotel ?? this.payAtHotel,
      promotionDetail: promotionDetail ?? this.promotionDetail,
      totalPayment: totalPayment ?? this.totalPayment,
      paymentModel: paymentModel ?? this.paymentModel,
      remainingRooms: remainingRooms ?? this.remainingRooms,
      normalBedding: normalBedding ?? this.normalBedding,
      extraBeds: extraBeds ?? this.extraBeds,
      roomTypeNotGuaranteed:
          roomTypeNotGuaranteed ?? this.roomTypeNotGuaranteed,
      benefits: benefits ?? this.benefits,
      dailyBreakdown: dailyBreakdown ?? this.dailyBreakdown,
      dailyRate: dailyRate ?? this.dailyRate,
      cancellationPolicy: cancellationPolicy ?? this.cancellationPolicy,
      freeWifi: freeWifi ?? this.freeWifi,
      taxBreakdown: taxBreakdown ?? this.taxBreakdown,
      surcharges: surcharges ?? this.surcharges,
      channelIds: channelIds ?? this.channelIds,
      bookNowPayLaterDate: bookNowPayLaterDate ?? this.bookNowPayLaterDate,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (commercial != null) {
      result.addAll({'commercial': commercial!.toMap()});
    }
    if (inclusive != null) {
      result.addAll({'inclusive': inclusive});
    }
    if (roomId != null) {
      result.addAll({'roomId': roomId});
    }
    if (roomName != null) {
      result.addAll({'roomName': roomName});
    }
    if (parentRoomName != null) {
      result.addAll({'parentRoomName': parentRoomName});
    }
    if (translatedRoomName != null) {
      result.addAll({'translatedRoomName': translatedRoomName});
    }
    if (blockIdBackup != null) {
      result.addAll({'blockIdBackup': blockIdBackup});
    }
    if (parentRoomId != null) {
      result.addAll({'parentRoomId': parentRoomId});
    }
    if (ratePlanId != null) {
      result.addAll({'ratePlanId': ratePlanId});
    }
    if (blockId != null) {
      result.addAll({'blockId': blockId});
    }
    if (rate != null) {
      result.addAll({'rate': rate!.toMap()});
    }
    if (perRoomPerNightRate != null) {
      result.addAll({'perRoomPerNightRate': perRoomPerNightRate!.toMap()});
    }
    if (freeBreakfast != null) {
      result.addAll({'freeBreakfast': freeBreakfast});
    }
    if (freeCancellation != null) {
      result.addAll({'freeCancellation': freeCancellation});
    }
    if (freeCancellationDate != null) {
      result.addAll({'freeCancellationDate': freeCancellationDate});
    }
    if (landingUrl != null) {
      result.addAll({'landingUrl': landingUrl});
    }
    if (payAtHotel != null) {
      result.addAll({'payAtHotel': payAtHotel});
    }
    if (promotionDetail != null) {
      result.addAll({'promotionDetail': promotionDetail!.toMap()});
    }
    if (totalPayment != null) {
      result.addAll({'totalPayment': totalPayment!.toMap()});
    }
    if (paymentModel != null) {
      result.addAll({'paymentModel': paymentModel!.name});
    }
    if (remainingRooms != null) {
      result.addAll({'remainingRooms': remainingRooms});
    }
    if (normalBedding != null) {
      result.addAll({'normalBedding': normalBedding});
    }
    if (extraBeds != null) {
      result.addAll({'extraBeds': extraBeds});
    }
    if (roomTypeNotGuaranteed != null) {
      result.addAll({'roomTypeNotGuaranteed': roomTypeNotGuaranteed});
    }
    if (benefits != null) {
      result.addAll({'benefits': benefits!.map((x) => x.toMap()).toList()});
    }
    if (dailyBreakdown != null) {
      result.addAll(
          {'dailyBreakdown': dailyBreakdown!.map((x) => x.toMap()).toList()});
    }
    if (dailyRate != null) {
      result.addAll({'dailyRate': dailyRate!.map((x) => x.toMap()).toList()});
    }
    if (cancellationPolicy != null) {
      result.addAll({'cancellationPolicy': cancellationPolicy!.toMap()});
    }
    if (freeWifi != null) {
      result.addAll({'freeWifi': freeWifi});
    }
    if (taxBreakdown != null) {
      result.addAll(
          {'taxBreakdown': taxBreakdown!.map((x) => x.toMap()).toList()});
    }
    if (surcharges != null) {
      result.addAll({'surcharges': surcharges!.map((x) => x.toMap()).toList()});
    }
    if (channelIds != null) {
      result.addAll({'channelIds': channelIds});
    }
    if (bookNowPayLaterDate != null) {
      result.addAll(
          {'bookNowPayLaterDate': bookNowPayLaterDate!.millisecondsSinceEpoch});
    }

    return result;
  }

  factory HotelDetailAgodaRoom.fromMap(Map<String, dynamic> map) {
    return HotelDetailAgodaRoom(
      commercial: map['commercial'] != null
          ? HotelDetailCommercial.fromMap(map['commercial'])
          : null,
      inclusive: map['inclusive']?.toDouble(),
      roomId: map['roomId']?.toInt(),
      roomName: map['roomName'],
      parentRoomName: map['parentRoomName'],
      translatedRoomName: map['translatedRoomName'],
      blockIdBackup: map['blockIdBackup'],
      parentRoomId: map['parentRoomId']?.toInt(),
      ratePlanId: map['ratePlanId']?.toInt(),
      blockId: map['blockId'],
      rate: map['rate'] != null
          ? AgodaHotelSearchResRate.fromMap(map['rate'])
          : null,
      perRoomPerNightRate: map['perRoomPerNightRate'] != null
          ? AgodaHotelSearchResPerRoomPerNightRate.fromMap(
              map['perRoomPerNightRate'])
          : null,
      freeBreakfast: map['freeBreakfast'],
      freeCancellation: map['freeCancellation'],
      freeCancellationDate: map['freeCancellationDate'],
      landingUrl: map['landingUrl'],
      payAtHotel: map['payAtHotel'],
      promotionDetail: map['promotionDetail'] != null
          ? AgodaHotelSearchResPromotionDetail.fromMap(map['promotionDetail'])
          : null,
      totalPayment: map['totalPayment'] != null
          ? AgodaHotelSearchResTotalPayment.fromMap(map['totalPayment'])
          : null,
      paymentModel: map['paymentModel'] != null
          ? stringToEnum(map['paymentModel'], AgodaPaymentModelEnum.values)
          : null,
      remainingRooms: map['remainingRooms']?.toInt(),
      normalBedding: map['normalBedding']?.toInt(),
      extraBeds: map['extraBeds']?.toInt(),
      roomTypeNotGuaranteed: map['roomTypeNotGuaranteed'],
      benefits: map['benefits'] != null
          ? List<AgodaHotelSearchResBenefit>.from(map['benefits']
              ?.map((x) => AgodaHotelSearchResBenefit.fromMap(x)))
          : null,
      dailyBreakdown: map['dailyBreakdown'] != null
          ? List<AgodaHotelSearchResDailyRate>.from(map['dailyBreakdown']
              ?.map((x) => AgodaHotelSearchResDailyRate.fromMap(x)))
          : null,
      dailyRate: map['dailyRate'] != null
          ? List<AgodaHotelSearchResDailyRate>.from(map['dailyRate']
              ?.map((x) => AgodaHotelSearchResDailyRate.fromMap(x)))
          : null,
      cancellationPolicy: map['cancellationPolicy'] != null
          ? AgodaHotelSearchResCancellationPolicy.fromMap(
              map['cancellationPolicy'])
          : null,
      freeWifi: map['freeWifi'],
      taxBreakdown: map['taxBreakdown'] != null
          ? List<AgodaHotelSearchResTaxBreakdown>.from(map['taxBreakdown']
              ?.map((x) => AgodaHotelSearchResTaxBreakdown.fromMap(x)))
          : null,
      surcharges: map['surcharges'] != null
          ? List<AgodaHotelSearchResSurchargeBreakdown>.from(map['surcharges']
              ?.map((x) => AgodaHotelSearchResSurchargeBreakdown.fromMap(x)))
          : null,
      channelIds: List<int>.from(map['channelIds']),
      bookNowPayLaterDate: map['bookNowPayLaterDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['bookNowPayLaterDate'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory HotelDetailAgodaRoom.fromJson(String source) =>
      HotelDetailAgodaRoom.fromMap(json.decode(source));

  @override
  String toString() {
    return 'HotelDetailAgodaRoom(commercial: $commercial, inclusive: $inclusive, roomId: $roomId, roomName: $roomName, parentRoomName: $parentRoomName, translatedRoomName: $translatedRoomName, blockIdBackup: $blockIdBackup, parentRoomId: $parentRoomId, ratePlanId: $ratePlanId, blockId: $blockId, rate: $rate, perRoomPerNightRate: $perRoomPerNightRate, freeBreakfast: $freeBreakfast, freeCancellation: $freeCancellation, freeCancellationDate: $freeCancellationDate, landingUrl: $landingUrl, payAtHotel: $payAtHotel, promotionDetail: $promotionDetail, totalPayment: $totalPayment, paymentModel: $paymentModel, remainingRooms: $remainingRooms, normalBedding: $normalBedding, extraBeds: $extraBeds, roomTypeNotGuaranteed: $roomTypeNotGuaranteed, benefits: $benefits, dailyBreakdown: $dailyBreakdown, dailyRate: $dailyRate, cancellationPolicy: $cancellationPolicy, freeWifi: $freeWifi, taxBreakdown: $taxBreakdown, surcharges: $surcharges, channelIds: $channelIds, bookNowPayLaterDate: $bookNowPayLaterDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HotelDetailAgodaRoom &&
        other.commercial == commercial &&
        other.inclusive == inclusive &&
        other.roomId == roomId &&
        other.roomName == roomName &&
        other.parentRoomName == parentRoomName &&
        other.translatedRoomName == translatedRoomName &&
        other.blockIdBackup == blockIdBackup &&
        other.parentRoomId == parentRoomId &&
        other.ratePlanId == ratePlanId &&
        other.blockId == blockId &&
        other.rate == rate &&
        other.perRoomPerNightRate == perRoomPerNightRate &&
        other.freeBreakfast == freeBreakfast &&
        other.freeCancellation == freeCancellation &&
        other.freeCancellationDate == freeCancellationDate &&
        other.landingUrl == landingUrl &&
        other.payAtHotel == payAtHotel &&
        other.promotionDetail == promotionDetail &&
        other.totalPayment == totalPayment &&
        other.paymentModel == paymentModel &&
        other.remainingRooms == remainingRooms &&
        other.normalBedding == normalBedding &&
        other.extraBeds == extraBeds &&
        other.roomTypeNotGuaranteed == roomTypeNotGuaranteed &&
        listEquals(other.benefits, benefits) &&
        listEquals(other.dailyBreakdown, dailyBreakdown) &&
        listEquals(other.dailyRate, dailyRate) &&
        other.cancellationPolicy == cancellationPolicy &&
        other.freeWifi == freeWifi &&
        listEquals(other.taxBreakdown, taxBreakdown) &&
        listEquals(other.surcharges, surcharges) &&
        listEquals(other.channelIds, channelIds) &&
        other.bookNowPayLaterDate == bookNowPayLaterDate;
  }

  @override
  int get hashCode {
    return commercial.hashCode ^
        inclusive.hashCode ^
        roomId.hashCode ^
        roomName.hashCode ^
        parentRoomName.hashCode ^
        translatedRoomName.hashCode ^
        blockIdBackup.hashCode ^
        parentRoomId.hashCode ^
        ratePlanId.hashCode ^
        blockId.hashCode ^
        rate.hashCode ^
        perRoomPerNightRate.hashCode ^
        freeBreakfast.hashCode ^
        freeCancellation.hashCode ^
        freeCancellationDate.hashCode ^
        landingUrl.hashCode ^
        payAtHotel.hashCode ^
        promotionDetail.hashCode ^
        totalPayment.hashCode ^
        paymentModel.hashCode ^
        remainingRooms.hashCode ^
        normalBedding.hashCode ^
        extraBeds.hashCode ^
        roomTypeNotGuaranteed.hashCode ^
        benefits.hashCode ^
        dailyBreakdown.hashCode ^
        dailyRate.hashCode ^
        cancellationPolicy.hashCode ^
        freeWifi.hashCode ^
        taxBreakdown.hashCode ^
        surcharges.hashCode ^
        channelIds.hashCode ^
        bookNowPayLaterDate.hashCode;
  }
}
