import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:yellow_rose/features/flight/data/models/booking/order/customer_payment.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order/payment_medium_request_res.dart';

class UpdateOrderDetailResponse {
  final String? orderNumber;
  final String? userBookingContext;
  final PaymentMediumRequestRes? paymentConfig;
  final CustomerPayment? priceData;
  final List<BookingPassThroughData>? passThroughInfo;
  bool isHoldAllowed = false;
  bool fopUpdatedSuccess = false;
  UpdateOrderDetailResponse({
    this.orderNumber,
    this.userBookingContext,
    required this.paymentConfig,
    required this.priceData,
    required this.passThroughInfo,
    required this.isHoldAllowed,
    required this.fopUpdatedSuccess,
  });

  UpdateOrderDetailResponse copyWith({
    String? orderNumber,
    String? userBookingContext,
    PaymentMediumRequestRes? paymentConfig,
    CustomerPayment? priceData,
    List<BookingPassThroughData>? passThroughInfo,
    bool? isHoldAllowed,
    bool? fopUpdatedSuccess,
  }) {
    return UpdateOrderDetailResponse(
      orderNumber: orderNumber ?? this.orderNumber,
      userBookingContext: userBookingContext ?? this.userBookingContext,
      paymentConfig: paymentConfig ?? this.paymentConfig,
      priceData: priceData ?? this.priceData,
      passThroughInfo: passThroughInfo ?? this.passThroughInfo,
      isHoldAllowed: isHoldAllowed ?? this.isHoldAllowed,
      fopUpdatedSuccess: fopUpdatedSuccess ?? this.fopUpdatedSuccess,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (orderNumber != null) {
      result.addAll({'orderNumber': orderNumber});
    }
    if (userBookingContext != null) {
      result.addAll({'userBookingContext': userBookingContext});
    }
    if (paymentConfig != null) {
      result.addAll({'paymentConfig': paymentConfig!.toMap()});
    }
    if (priceData != null) {
      result.addAll({'priceData': priceData!.toMap()});
    }
    if (passThroughInfo != null) {
      result.addAll(
          {'passThroughInfo': passThroughInfo!.map((x) => x.toMap()).toList()});
    }
    result.addAll({'isHoldAllowed': isHoldAllowed});
    result.addAll({'fopUpdatedSuccess': fopUpdatedSuccess});

    return result;
  }

  factory UpdateOrderDetailResponse.fromMap(Map<String, dynamic> map) {
    return UpdateOrderDetailResponse(
      orderNumber: map['orderNumber'],
      userBookingContext: map['userBookingContext'],
      paymentConfig: map['paymentConfig'] != null
          ? PaymentMediumRequestRes.fromMap(map['paymentConfig'])
          : null,
      priceData: map['priceData'] != null
          ? CustomerPayment.fromMap(map['priceData'])
          : null,
      passThroughInfo: map['passThroughInfo'] != null
          ? List<BookingPassThroughData>.from(map['passThroughInfo']
              ?.map((x) => BookingPassThroughData.fromMap(x)))
          : null,
      isHoldAllowed: map['isHoldAllowed'] ?? false,
      fopUpdatedSuccess: map['fopUpdatedSuccess'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory UpdateOrderDetailResponse.fromJson(String source) =>
      UpdateOrderDetailResponse.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UpdateOrderDetailResponse(orderNumber: $orderNumber, userBookingContext: $userBookingContext, paymentConfig: $paymentConfig, priceData: $priceData, passThroughInfo: $passThroughInfo, isHoldAllowed: $isHoldAllowed, fopUpdatedSuccess: $fopUpdatedSuccess)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UpdateOrderDetailResponse &&
        other.orderNumber == orderNumber &&
        other.userBookingContext == userBookingContext &&
        other.paymentConfig == paymentConfig &&
        other.priceData == priceData &&
        listEquals(other.passThroughInfo, passThroughInfo) &&
        other.isHoldAllowed == isHoldAllowed &&
        other.fopUpdatedSuccess == fopUpdatedSuccess;
  }

  @override
  int get hashCode {
    return orderNumber.hashCode ^
        userBookingContext.hashCode ^
        paymentConfig.hashCode ^
        priceData.hashCode ^
        passThroughInfo.hashCode ^
        isHoldAllowed.hashCode ^
        fopUpdatedSuccess.hashCode;
  }
}

class BookingPassThroughData {
  String? segment;
  String? paymentMedium;
  String? updatedPaymentMedium;
  double totalAmount;
  double baseTaxFare;
  double seatCharges;
  double mealCharges;
  double specialSSRCharges;
  double baggageSSRCharges;
  BookingPassThroughData({
    this.segment,
    this.paymentMedium,
    this.updatedPaymentMedium,
    required this.totalAmount,
    required this.baseTaxFare,
    required this.seatCharges,
    required this.mealCharges,
    required this.specialSSRCharges,
    required this.baggageSSRCharges,
  });

  BookingPassThroughData copyWith({
    String? segment,
    String? paymentMedium,
    String? updatedPaymentMedium,
    double? totalAmount,
    double? baseTaxFare,
    double? seatCharges,
    double? mealCharges,
    double? specialSSRCharges,
    double? baggageSSRCharges,
  }) {
    return BookingPassThroughData(
      segment: segment ?? this.segment,
      paymentMedium: paymentMedium ?? this.paymentMedium,
      updatedPaymentMedium: updatedPaymentMedium ?? this.updatedPaymentMedium,
      totalAmount: totalAmount ?? this.totalAmount,
      baseTaxFare: baseTaxFare ?? this.baseTaxFare,
      seatCharges: seatCharges ?? this.seatCharges,
      mealCharges: mealCharges ?? this.mealCharges,
      specialSSRCharges: specialSSRCharges ?? this.specialSSRCharges,
      baggageSSRCharges: baggageSSRCharges ?? this.baggageSSRCharges,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (segment != null) {
      result.addAll({'segment': segment});
    }
    if (paymentMedium != null) {
      result.addAll({'paymentMedium': paymentMedium});
    }
    if (updatedPaymentMedium != null) {
      result.addAll({'updatedPaymentMedium': updatedPaymentMedium});
    }
    result.addAll({'totalAmount': totalAmount});
    result.addAll({'baseTaxFare': baseTaxFare});
    result.addAll({'seatCharges': seatCharges});
    result.addAll({'mealCharges': mealCharges});
    result.addAll({'specialSSRCharges': specialSSRCharges});
    result.addAll({'baggageSSRCharges': baggageSSRCharges});

    return result;
  }

  factory BookingPassThroughData.fromMap(Map<String, dynamic> map) {
    return BookingPassThroughData(
      segment: map['segment'],
      paymentMedium: map['paymentMedium'],
      updatedPaymentMedium: map['updatedPaymentMedium'],
      totalAmount: map['totalAmount']?.toDouble() ?? 0.0,
      baseTaxFare: map['baseTaxFare']?.toDouble() ?? 0.0,
      seatCharges: map['seatCharges']?.toDouble() ?? 0.0,
      mealCharges: map['mealCharges']?.toDouble() ?? 0.0,
      specialSSRCharges: map['specialSSRCharges']?.toDouble() ?? 0.0,
      baggageSSRCharges: map['baggageSSRCharges']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory BookingPassThroughData.fromJson(String source) =>
      BookingPassThroughData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BookingPassThroughData(segment: $segment, paymentMedium: $paymentMedium, updatedPaymentMedium: $updatedPaymentMedium, totalAmount: $totalAmount, baseTaxFare: $baseTaxFare, seatCharges: $seatCharges, mealCharges: $mealCharges, specialSSRCharges: $specialSSRCharges, baggageSSRCharges: $baggageSSRCharges)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BookingPassThroughData &&
        other.segment == segment &&
        other.paymentMedium == paymentMedium &&
        other.updatedPaymentMedium == updatedPaymentMedium &&
        other.totalAmount == totalAmount &&
        other.baseTaxFare == baseTaxFare &&
        other.seatCharges == seatCharges &&
        other.mealCharges == mealCharges &&
        other.specialSSRCharges == specialSSRCharges &&
        other.baggageSSRCharges == baggageSSRCharges;
  }

  @override
  int get hashCode {
    return segment.hashCode ^
        paymentMedium.hashCode ^
        updatedPaymentMedium.hashCode ^
        totalAmount.hashCode ^
        baseTaxFare.hashCode ^
        seatCharges.hashCode ^
        mealCharges.hashCode ^
        specialSSRCharges.hashCode ^
        baggageSSRCharges.hashCode;
  }
}

class PaxRescheduleCharges {
  final double otherCharges;
  final double supplierAmendment;
  final double serviceChargesFees;
  final double baseFareCharges;
  final double airlineTaxes;
  final double serviceChargesTax;
  final double rescheduledFees;
  final double refundAmt;
  PaxRescheduleCharges({
    required this.otherCharges,
    required this.supplierAmendment,
    required this.serviceChargesFees,
    required this.baseFareCharges,
    required this.airlineTaxes,
    required this.serviceChargesTax,
    required this.rescheduledFees,
    required this.refundAmt,
  });

  PaxRescheduleCharges copyWith({
    double? otherCharges,
    double? supplierAmendment,
    double? serviceChargesFees,
    double? baseFareCharges,
    double? airlineTaxes,
    double? serviceChargesTax,
    double? rescheduledFees,
    double? refundAmt,
  }) {
    return PaxRescheduleCharges(
      otherCharges: otherCharges ?? this.otherCharges,
      supplierAmendment: supplierAmendment ?? this.supplierAmendment,
      serviceChargesFees: serviceChargesFees ?? this.serviceChargesFees,
      baseFareCharges: baseFareCharges ?? this.baseFareCharges,
      airlineTaxes: airlineTaxes ?? this.airlineTaxes,
      serviceChargesTax: serviceChargesTax ?? this.serviceChargesTax,
      rescheduledFees: rescheduledFees ?? this.rescheduledFees,
      refundAmt: refundAmt ?? this.refundAmt,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'otherCharges': otherCharges});
    result.addAll({'supplierAmendment': supplierAmendment});
    result.addAll({'serviceChargesFees': serviceChargesFees});
    result.addAll({'baseFareCharges': baseFareCharges});
    result.addAll({'airlineTaxes': airlineTaxes});
    result.addAll({'serviceChargesTax': serviceChargesTax});
    result.addAll({'rescheduledFees': rescheduledFees});
    result.addAll({'refundAmt': refundAmt});

    return result;
  }

  factory PaxRescheduleCharges.fromMap(Map<String, dynamic> map) {
    return PaxRescheduleCharges(
      otherCharges: map['otherCharges']?.toDouble() ?? 0.0,
      supplierAmendment: map['supplierAmendment']?.toDouble() ?? 0.0,
      serviceChargesFees: map['serviceChargesFees']?.toDouble() ?? 0.0,
      baseFareCharges: map['baseFareCharges']?.toDouble() ?? 0.0,
      airlineTaxes: map['airlineTaxes']?.toDouble() ?? 0.0,
      serviceChargesTax: map['serviceChargesTax']?.toDouble() ?? 0.0,
      rescheduledFees: map['rescheduledFees']?.toDouble() ?? 0.0,
      refundAmt: map['refundAmt']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory PaxRescheduleCharges.fromJson(String source) =>
      PaxRescheduleCharges.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PaxRescheduleCharges(otherCharges: $otherCharges, supplierAmendment: $supplierAmendment, serviceChargesFees: $serviceChargesFees, baseFareCharges: $baseFareCharges, airlineTaxes: $airlineTaxes, serviceChargesTax: $serviceChargesTax, rescheduledFees: $rescheduledFees, refundAmt: $refundAmt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PaxRescheduleCharges &&
        other.otherCharges == otherCharges &&
        other.supplierAmendment == supplierAmendment &&
        other.serviceChargesFees == serviceChargesFees &&
        other.baseFareCharges == baseFareCharges &&
        other.airlineTaxes == airlineTaxes &&
        other.serviceChargesTax == serviceChargesTax &&
        other.rescheduledFees == rescheduledFees &&
        other.refundAmt == refundAmt;
  }

  @override
  int get hashCode {
    return otherCharges.hashCode ^
        supplierAmendment.hashCode ^
        serviceChargesFees.hashCode ^
        baseFareCharges.hashCode ^
        airlineTaxes.hashCode ^
        serviceChargesTax.hashCode ^
        rescheduledFees.hashCode ^
        refundAmt.hashCode;
  }
}
