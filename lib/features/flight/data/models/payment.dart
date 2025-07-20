import 'dart:convert';

class Payment {

    final double amount;
    final String? paymentConfig;
  Payment({
    required this.amount,
    this.paymentConfig,
  });

  Payment copyWith({
    double? amount,
    String? paymentConfig,
  }) {
    return Payment(
      amount: amount ?? this.amount,
      paymentConfig: paymentConfig ?? this.paymentConfig,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'amount': amount});
    if(paymentConfig != null){
      result.addAll({'paymentConfig': paymentConfig});
    }
  
    return result;
  }

  factory Payment.fromMap(Map<String, dynamic> map) {
    return Payment(
      amount: map['amount']?.toDouble() ?? 0.0,
      paymentConfig: map['paymentConfig'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Payment.fromJson(String source) => Payment.fromMap(json.decode(source));

  @override
  String toString() => 'Payment(amount: $amount, paymentConfig: $paymentConfig)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Payment &&
      other.amount == amount &&
      other.paymentConfig == paymentConfig;
  }

  @override
  int get hashCode => amount.hashCode ^ paymentConfig.hashCode;
}
