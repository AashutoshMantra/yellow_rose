import 'dart:convert';

class HotelTravellerDetailCount {
  final int adult;
  final int child;
  final int infantCount;
  HotelTravellerDetailCount({
    required this.adult,
    required this.child,
    required this.infantCount,
  });

  HotelTravellerDetailCount copyWith({
    int? adult,
    int? child,
    int? infantCount,
  }) {
    return HotelTravellerDetailCount(
      adult: adult ?? this.adult,
      child: child ?? this.child,
      infantCount: infantCount ?? this.infantCount,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'adult': adult});
    result.addAll({'child': child});
    result.addAll({'infantCount': infantCount});
  
    return result;
  }

  factory HotelTravellerDetailCount.fromMap(Map<String, dynamic> map) {
    return HotelTravellerDetailCount(
      adult: map['adult']?.toInt() ?? 0,
      child: map['child']?.toInt() ?? 0,
      infantCount: map['infantCount']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory HotelTravellerDetailCount.fromJson(String source) => HotelTravellerDetailCount.fromMap(json.decode(source));

  @override
  String toString() => 'HotelTravellerDetailCount(adult: $adult, child: $child, infantCount: $infantCount)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is HotelTravellerDetailCount &&
      other.adult == adult &&
      other.child == child &&
      other.infantCount == infantCount;
  }

  @override
  int get hashCode => adult.hashCode ^ child.hashCode ^ infantCount.hashCode;
}
