import 'dart:convert';

class CreateOrderResponse {
//   "orderNumber": "STG280425125143774",
// "paymentConfig": null,
// "priceData": null,
// "passThroughInfo": null,
// "holdAllowed": false
  final String orderNumber;
  final bool holdAllowed;

  CreateOrderResponse({
    required this.orderNumber,
    required this.holdAllowed,
  });

  Map<String, dynamic> toMap() {
    return {
      'orderNumber': orderNumber,
      'holdAllowed': holdAllowed,
    };
  }

  factory CreateOrderResponse.fromMap(Map<String, dynamic> map) {
    return CreateOrderResponse(
      orderNumber: map['orderNumber'] ?? '',
      holdAllowed: map['holdAllowed'] ?? false,
    );
  }
  String toJson() => json.encode(toMap());
  factory CreateOrderResponse.fromJson(String source) =>
      CreateOrderResponse.fromMap(json.decode(source));
  @override
  String toString() =>
      'CreateOrderResponse(orderNumber: $orderNumber, holdAllowed: $holdAllowed)';
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CreateOrderResponse &&
        other.orderNumber == orderNumber &&
        other.holdAllowed == holdAllowed;
  }

  @override
  int get hashCode => orderNumber.hashCode ^ holdAllowed.hashCode;
}
