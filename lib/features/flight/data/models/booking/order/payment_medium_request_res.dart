import 'dart:convert';

import 'package:flutter/foundation.dart';

class PaymentMediumStatus {
  String? mediumName;
  bool? isBusinessEnabled;
  bool? isPersonalEnabled;
  PaymentMediumStatus({
    this.mediumName,
    this.isBusinessEnabled,
    this.isPersonalEnabled,
  });

  PaymentMediumStatus copyWith({
    String? mediumName,
    bool? isBusinessEnabled,
    bool? isPersonalEnabled,
  }) {
    return PaymentMediumStatus(
      mediumName: mediumName ?? this.mediumName,
      isBusinessEnabled: isBusinessEnabled ?? this.isBusinessEnabled,
      isPersonalEnabled: isPersonalEnabled ?? this.isPersonalEnabled,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (mediumName != null) {
      result.addAll({'mediumName': mediumName});
    }
    if (isBusinessEnabled != null) {
      result.addAll({'isBusinessEnabled': isBusinessEnabled});
    }
    if (isPersonalEnabled != null) {
      result.addAll({'isPersonalEnabled': isPersonalEnabled});
    }

    return result;
  }

  factory PaymentMediumStatus.fromMap(Map<String, dynamic> map) {
    return PaymentMediumStatus(
      mediumName: map['mediumName'],
      isBusinessEnabled: map['isBusinessEnabled'],
      isPersonalEnabled: map['isPersonalEnabled'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentMediumStatus.fromJson(String source) =>
      PaymentMediumStatus.fromMap(json.decode(source));

  @override
  String toString() =>
      'PaymentMediumStatus(mediumName: $mediumName, isBusinessEnabled: $isBusinessEnabled, isPersonalEnabled: $isPersonalEnabled)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PaymentMediumStatus &&
        other.mediumName == mediumName &&
        other.isBusinessEnabled == isBusinessEnabled &&
        other.isPersonalEnabled == isPersonalEnabled;
  }

  @override
  int get hashCode =>
      mediumName.hashCode ^
      isBusinessEnabled.hashCode ^
      isPersonalEnabled.hashCode;
}

class PaymentMediumRequestRes {
  String? userUid;
  String? product;
  String? userBookingContext;
  List<PaymentMediumStatus>? status;
  PaymentMediumRequestRes({
    this.userUid,
    this.product,
    this.userBookingContext,
    this.status,
  });

  PaymentMediumRequestRes copyWith({
    String? userUid,
    String? product,
    String? userBookingContext,
    List<PaymentMediumStatus>? status,
  }) {
    return PaymentMediumRequestRes(
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

  factory PaymentMediumRequestRes.fromMap(Map<String, dynamic> map) {
    return PaymentMediumRequestRes(
      userUid: map['userUid'],
      product: map['product'],
      userBookingContext: map['userBookingContext'],
      status: map['status'] != null ? List<PaymentMediumStatus>.from(map['status']?.map((x) => PaymentMediumStatus.fromMap(x))) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentMediumRequestRes.fromJson(String source) => PaymentMediumRequestRes.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PaymentMediumRequestRes(userUid: $userUid, product: $product, userBookingContext: $userBookingContext, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is PaymentMediumRequestRes &&
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
