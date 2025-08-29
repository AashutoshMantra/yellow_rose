import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:yellow_rose/features/hotel/data/models/details/mmt/mmt_hotel_penalty.dart';

class MMTHotelSearchResCancellationPolicy {
    final String? cancelPaneltyDesc;
    final List<MMTHotelSearchResPenalty>? penalties;
  MMTHotelSearchResCancellationPolicy({
    this.cancelPaneltyDesc,
    this.penalties,
  });

  MMTHotelSearchResCancellationPolicy copyWith({
    String? cancelPaneltyDesc,
    List<MMTHotelSearchResPenalty>? penalties,
  }) {
    return MMTHotelSearchResCancellationPolicy(
      cancelPaneltyDesc: cancelPaneltyDesc ?? this.cancelPaneltyDesc,
      penalties: penalties ?? this.penalties,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(cancelPaneltyDesc != null){
      result.addAll({'cancelPaneltyDesc': cancelPaneltyDesc});
    }
    if(penalties != null){
      result.addAll({'penalties': penalties!.map((x) => x?.toMap()).toList()});
    }
  
    return result;
  }

  factory MMTHotelSearchResCancellationPolicy.fromMap(Map<String, dynamic> map) {
    return MMTHotelSearchResCancellationPolicy(
      cancelPaneltyDesc: map['cancelPaneltyDesc'],
      penalties: map['penalties'] != null ? List<MMTHotelSearchResPenalty>.from(map['penalties']?.map((x) => MMTHotelSearchResPenalty.fromMap(x))) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory MMTHotelSearchResCancellationPolicy.fromJson(String source) => MMTHotelSearchResCancellationPolicy.fromMap(json.decode(source));

  @override
  String toString() => 'MMTHotelSearchResCancellationPolicy(cancelPaneltyDesc: $cancelPaneltyDesc, penalties: $penalties)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is MMTHotelSearchResCancellationPolicy &&
      other.cancelPaneltyDesc == cancelPaneltyDesc &&
      listEquals(other.penalties, penalties);
  }

  @override
  int get hashCode => cancelPaneltyDesc.hashCode ^ penalties.hashCode;
}
