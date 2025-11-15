import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:yellow_rose/features/bus/data/models/order/bus_payment_medium_status.dart';

class BusPaymentMediumRequestRes {
  String? userUid;
  String? product;
  String? userBookingContext;
  List<BusPaymentMediumStatus>? status;
  BusPaymentMediumRequestRes({
    this.userUid,
    this.product,
    this.userBookingContext,
    this.status,
  });

  BusPaymentMediumRequestRes copyWith({
    String? userUid,
    String? product,
    String? userBookingContext,
    List<BusPaymentMediumStatus>? status,
  }) {
    return BusPaymentMediumRequestRes(
      userUid: userUid ?? this.userUid,
      product: product ?? this.product,
      userBookingContext: userBookingContext ?? this.userBookingContext,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(userUid != null){
      result.addAll({'userUid': userUid});
    }
    if(product != null){
      result.addAll({'product': product});
    }
    if(userBookingContext != null){
      result.addAll({'userBookingContext': userBookingContext});
    }
    if(status != null){
      result.addAll({'status': status!.map((x) => x?.toMap()).toList()});
    }
  
    return result;
  }

  factory BusPaymentMediumRequestRes.fromMap(Map<String, dynamic> map) {
    return BusPaymentMediumRequestRes(
      userUid: map['userUid'],
      product: map['product'],
      userBookingContext: map['userBookingContext'],
      status: map['status'] != null ? List<BusPaymentMediumStatus>.from(map['status']?.map((x) => BusPaymentMediumStatus.fromMap(x))) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BusPaymentMediumRequestRes.fromJson(String source) => BusPaymentMediumRequestRes.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BusPaymentMediumRequestRes(userUid: $userUid, product: $product, userBookingContext: $userBookingContext, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is BusPaymentMediumRequestRes &&
      other.userUid == userUid &&
      other.product == product &&
      other.userBookingContext == userBookingContext &&
      listEquals(other.status, status);
  }

  @override
  int get hashCode {
    return userUid.hashCode ^
      product.hashCode ^
      userBookingContext.hashCode ^
      status.hashCode;
  }
}
