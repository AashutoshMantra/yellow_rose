import 'dart:convert';

import 'package:yellow_rose/core/utils/extensions.dart';
import 'package:yellow_rose/features/flight/data/models/booking/card.dart';
import 'package:yellow_rose/features/flight/data/models/erro_code_handler.dart';
import 'package:yellow_rose/features/flight/data/models/form_of_payment_enum.dart';

class FormOfPayment {
  final FormOfPaymentEnum? formOfPayment;
  final Card? card;
  final ErrorCodeHandler? errorDetails;
  FormOfPayment({
    this.formOfPayment,
    this.card,
    this.errorDetails,
  });

  FormOfPayment copyWith({
    FormOfPaymentEnum? formOfPayment,
    Card? card,
    ErrorCodeHandler? errorDetails,
  }) {
    return FormOfPayment(
      formOfPayment: formOfPayment ?? this.formOfPayment,
      card: card ?? this.card,
      errorDetails: errorDetails ?? this.errorDetails,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (formOfPayment != null) {
      result.addAll({'formOfPayment': formOfPayment!.name});
    }
    if (card != null) {
      result.addAll({'card': card!.toMap()});
    }
    if (errorDetails != null) {
      result.addAll({'errorDetails': errorDetails!.toMap()});
    }

    return result;
  }

  factory FormOfPayment.fromMap(Map<String, dynamic> map) {
    return FormOfPayment(
      formOfPayment: (map['formOfPayment'] as String?)?.toEnum(FormOfPaymentEnum.values),
      card: map['card'] != null ? Card.fromMap(map['card']) : null,
      errorDetails: map['errorDetails'] != null
          ? ErrorCodeHandler.fromMap(map['errorDetails'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FormOfPayment.fromJson(String source) =>
      FormOfPayment.fromMap(json.decode(source));

  @override
  String toString() =>
      'FormOfPayment(formOfPayment: $formOfPayment, card: $card, errorDetails: $errorDetails)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FormOfPayment &&
        other.formOfPayment == formOfPayment &&
        other.card == card &&
        other.errorDetails == errorDetails;
  }

  @override
  int get hashCode =>
      formOfPayment.hashCode ^ card.hashCode ^ errorDetails.hashCode;
}
