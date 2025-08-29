import 'dart:convert';

import 'package:yellow_rose/features/hotel/data/models/details/expedia/response_link.dart';

class ExpediaHotelSearchResponsePaymentOptionLink {
  final ExpediaResponseLink? paymentOptions;
  ExpediaHotelSearchResponsePaymentOptionLink({
    this.paymentOptions,
  });

  ExpediaHotelSearchResponsePaymentOptionLink copyWith({
    ExpediaResponseLink? paymentOptions,
  }) {
    return ExpediaHotelSearchResponsePaymentOptionLink(
      paymentOptions: paymentOptions ?? this.paymentOptions,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (paymentOptions != null) {
      result.addAll({'paymentOptions': paymentOptions!.toMap()});
    }

    return result;
  }

  factory ExpediaHotelSearchResponsePaymentOptionLink.fromMap(
      Map<String, dynamic> map) {
    return ExpediaHotelSearchResponsePaymentOptionLink(
      paymentOptions: map['paymentOptions'] != null
          ? ExpediaResponseLink.fromMap(map['paymentOptions'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ExpediaHotelSearchResponsePaymentOptionLink.fromJson(String source) =>
      ExpediaHotelSearchResponsePaymentOptionLink.fromMap(json.decode(source));

  @override
  String toString() =>
      'ExpediaHotelSearchResponsePaymentOptionLink(paymentOptions: $paymentOptions)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ExpediaHotelSearchResponsePaymentOptionLink &&
        other.paymentOptions == paymentOptions;
  }

  @override
  int get hashCode => paymentOptions.hashCode;
}
