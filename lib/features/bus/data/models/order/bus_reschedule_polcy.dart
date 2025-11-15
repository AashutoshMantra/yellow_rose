import 'dart:convert';

class BusReschedulingPolicy {
  final String? reschedulingCharge;
  final String? windowTime;
  BusReschedulingPolicy({
    this.reschedulingCharge,
    this.windowTime,
  });

  BusReschedulingPolicy copyWith({
    String? reschedulingCharge,
    String? windowTime,
  }) {
    return BusReschedulingPolicy(
      reschedulingCharge: reschedulingCharge ?? this.reschedulingCharge,
      windowTime: windowTime ?? this.windowTime,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(reschedulingCharge != null){
      result.addAll({'reschedulingCharge': reschedulingCharge});
    }
    if(windowTime != null){
      result.addAll({'windowTime': windowTime});
    }
  
    return result;
  }

  factory BusReschedulingPolicy.fromMap(Map<String, dynamic> map) {
    return BusReschedulingPolicy(
      reschedulingCharge: map['reschedulingCharge'],
      windowTime: map['windowTime'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BusReschedulingPolicy.fromJson(String source) => BusReschedulingPolicy.fromMap(json.decode(source));

  @override
  String toString() => 'BusReschedulingPolicy(reschedulingCharge: $reschedulingCharge, windowTime: $windowTime)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is BusReschedulingPolicy &&
      other.reschedulingCharge == reschedulingCharge &&
      other.windowTime == windowTime;
  }

  @override
  int get hashCode => reschedulingCharge.hashCode ^ windowTime.hashCode;
}
