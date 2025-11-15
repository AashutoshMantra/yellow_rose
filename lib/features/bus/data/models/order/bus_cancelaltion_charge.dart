import 'dart:convert';

import 'package:yellow_rose/features/bus/data/models/order/bus_cancelaltion_charge_detail.dart';
import 'package:yellow_rose/features/bus/data/models/order/bus_cancelaltion_schedule.dart';

class BusCancelaltionCharge {
  final BusCancelaltionSchedule? schedule;
    final BusCancelaltionChargeDetail? charges;
  BusCancelaltionCharge({
    this.schedule,
    this.charges,
  });

  BusCancelaltionCharge copyWith({
    BusCancelaltionSchedule? schedule,
    BusCancelaltionChargeDetail? charges,
  }) {
    return BusCancelaltionCharge(
      schedule: schedule ?? this.schedule,
      charges: charges ?? this.charges,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(schedule != null){
      result.addAll({'schedule': schedule!.toMap()});
    }
    if(charges != null){
      result.addAll({'charges': charges!.toMap()});
    }
  
    return result;
  }

  factory BusCancelaltionCharge.fromMap(Map<String, dynamic> map) {
    return BusCancelaltionCharge(
      schedule: map['schedule'] != null ? BusCancelaltionSchedule.fromMap(map['schedule']) : null,
      charges: map['charges'] != null ? BusCancelaltionChargeDetail.fromMap(map['charges']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BusCancelaltionCharge.fromJson(String source) => BusCancelaltionCharge.fromMap(json.decode(source));

  @override
  String toString() => 'BusCancelaltionCharge(schedule: $schedule, charges: $charges)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is BusCancelaltionCharge &&
      other.schedule == schedule &&
      other.charges == charges;
  }

  @override
  int get hashCode => schedule.hashCode ^ charges.hashCode;
}
