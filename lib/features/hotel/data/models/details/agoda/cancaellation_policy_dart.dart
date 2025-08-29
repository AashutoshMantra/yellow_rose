import 'dart:convert';

class AgodaHotelSearchResCancellationPolicyDate {
  final String? before;
  final String? onward;
  final dynamic rate;
  AgodaHotelSearchResCancellationPolicyDate({
    this.before,
    this.onward,
    required this.rate,
  });

  AgodaHotelSearchResCancellationPolicyDate copyWith({
    String? before,
    String? onward,
    dynamic rate,
  }) {
    return AgodaHotelSearchResCancellationPolicyDate(
      before: before ?? this.before,
      onward: onward ?? this.onward,
      rate: rate ?? this.rate,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (before != null) {
      result.addAll({'before': before});
    }
    if (onward != null) {
      result.addAll({'onward': onward});
    }
    result.addAll({'rate': rate});

    return result;
  }

  factory AgodaHotelSearchResCancellationPolicyDate.fromMap(
      Map<String, dynamic> map) {
    return AgodaHotelSearchResCancellationPolicyDate(
      before: map['before'],
      onward: map['onward'],
      rate: map['rate'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AgodaHotelSearchResCancellationPolicyDate.fromJson(String source) =>
      AgodaHotelSearchResCancellationPolicyDate.fromMap(json.decode(source));

  @override
  String toString() =>
      'AgodaHotelSearchResCancellationPolicyDate(before: $before, onward: $onward, rate: $rate)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AgodaHotelSearchResCancellationPolicyDate &&
        other.before == before &&
        other.onward == onward &&
        other.rate == rate;
  }

  @override
  int get hashCode => before.hashCode ^ onward.hashCode ^ rate.hashCode;
}
