import 'dart:convert';

class BusOrderCancellationResponse {
  final String? cancellationCharge;
  final String? refundAmount;
  final String? refundServiceTax;
  final String? rtoReversalAmount;
  final String? serviceTaxOnCancellationCharge;
  final String? tin;
  final String? seatName;
  BusOrderCancellationResponse({
    this.cancellationCharge,
    this.refundAmount,
    this.refundServiceTax,
    this.rtoReversalAmount,
    this.serviceTaxOnCancellationCharge,
    this.tin,
    this.seatName,
  });

  BusOrderCancellationResponse copyWith({
    String? cancellationCharge,
    String? refundAmount,
    String? refundServiceTax,
    String? rtoReversalAmount,
    String? serviceTaxOnCancellationCharge,
    String? tin,
    String? seatName,
  }) {
    return BusOrderCancellationResponse(
      cancellationCharge: cancellationCharge ?? this.cancellationCharge,
      refundAmount: refundAmount ?? this.refundAmount,
      refundServiceTax: refundServiceTax ?? this.refundServiceTax,
      rtoReversalAmount: rtoReversalAmount ?? this.rtoReversalAmount,
      serviceTaxOnCancellationCharge: serviceTaxOnCancellationCharge ?? this.serviceTaxOnCancellationCharge,
      tin: tin ?? this.tin,
      seatName: seatName ?? this.seatName,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(cancellationCharge != null){
      result.addAll({'cancellationCharge': cancellationCharge});
    }
    if(refundAmount != null){
      result.addAll({'refundAmount': refundAmount});
    }
    if(refundServiceTax != null){
      result.addAll({'refundServiceTax': refundServiceTax});
    }
    if(rtoReversalAmount != null){
      result.addAll({'rtoReversalAmount': rtoReversalAmount});
    }
    if(serviceTaxOnCancellationCharge != null){
      result.addAll({'serviceTaxOnCancellationCharge': serviceTaxOnCancellationCharge});
    }
    if(tin != null){
      result.addAll({'tin': tin});
    }
    if(seatName != null){
      result.addAll({'seatName': seatName});
    }
  
    return result;
  }

  factory BusOrderCancellationResponse.fromMap(Map<String, dynamic> map) {
    return BusOrderCancellationResponse(
      cancellationCharge: map['cancellationCharge'],
      refundAmount: map['refundAmount'],
      refundServiceTax: map['refundServiceTax'],
      rtoReversalAmount: map['rtoReversalAmount'],
      serviceTaxOnCancellationCharge: map['serviceTaxOnCancellationCharge'],
      tin: map['tin'],
      seatName: map['seatName'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BusOrderCancellationResponse.fromJson(String source) => BusOrderCancellationResponse.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BusOrderCancellationResponse(cancellationCharge: $cancellationCharge, refundAmount: $refundAmount, refundServiceTax: $refundServiceTax, rtoReversalAmount: $rtoReversalAmount, serviceTaxOnCancellationCharge: $serviceTaxOnCancellationCharge, tin: $tin, seatName: $seatName)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is BusOrderCancellationResponse &&
      other.cancellationCharge == cancellationCharge &&
      other.refundAmount == refundAmount &&
      other.refundServiceTax == refundServiceTax &&
      other.rtoReversalAmount == rtoReversalAmount &&
      other.serviceTaxOnCancellationCharge == serviceTaxOnCancellationCharge &&
      other.tin == tin &&
      other.seatName == seatName;
  }

  @override
  int get hashCode {
    return cancellationCharge.hashCode ^
      refundAmount.hashCode ^
      refundServiceTax.hashCode ^
      rtoReversalAmount.hashCode ^
      serviceTaxOnCancellationCharge.hashCode ^
      tin.hashCode ^
      seatName.hashCode;
  }
}
