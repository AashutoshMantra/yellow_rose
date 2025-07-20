import 'dart:convert';

class UpdatePaymentRequest {
  String paymentMedium;
  UpdatePaymentRequest({
    required this.paymentMedium,
  });

  UpdatePaymentRequest copyWith({
    String? paymentMedium,
  }) {
    return UpdatePaymentRequest(
      paymentMedium: paymentMedium ?? this.paymentMedium,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'paymentMedium': paymentMedium});

    return result;
  }

  factory UpdatePaymentRequest.fromMap(Map<String, dynamic> map) {
    return UpdatePaymentRequest(
      paymentMedium: map['paymentMedium'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UpdatePaymentRequest.fromJson(String source) =>
      UpdatePaymentRequest.fromMap(json.decode(source));

  @override
  String toString() => 'UpdatePayment(paymentMedium: $paymentMedium)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UpdatePaymentRequest &&
        other.paymentMedium == paymentMedium;
  }

  @override
  int get hashCode => paymentMedium.hashCode;
}
