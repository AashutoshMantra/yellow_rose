import 'dart:convert';

class OrderTravellerDetails {
  //  "child": 0,
  //   "adult": 1,
  //   "infantCount": 0
  final int child;
  final int adult;
  final int infantCount;
  OrderTravellerDetails({
    required this.child,
    required this.adult,
    required this.infantCount,
  });

  OrderTravellerDetails copyWith({
    int? child,
    int? adult,
    int? infantCount,
  }) {
    return OrderTravellerDetails(
      child: child ?? this.child,
      adult: adult ?? this.adult,
      infantCount: infantCount ?? this.infantCount,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'child': child});
    result.addAll({'adult': adult});
    result.addAll({'infantCount': infantCount});

    return result;
  }

  factory OrderTravellerDetails.fromMap(Map<String, dynamic> map) {
    return OrderTravellerDetails(
      child: map['child']?.toInt() ?? 0,
      adult: map['adult']?.toInt() ?? 0,
      infantCount: map['infantCount']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderTravellerDetails.fromJson(String source) =>
      OrderTravellerDetails.fromMap(json.decode(source));

  @override
  String toString() =>
      'OrderTravellerDetails(child: $child, adult: $adult, infantCount: $infantCount)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrderTravellerDetails &&
        other.child == child &&
        other.adult == adult &&
        other.infantCount == infantCount;
  }

  @override
  int get hashCode => child.hashCode ^ adult.hashCode ^ infantCount.hashCode;
}
