import 'dart:convert';

class BusCancelaltionSchedule {
  final String? measure;
  final String? from;
  final String? to;
  BusCancelaltionSchedule({
    this.measure,
    this.from,
    this.to,
  });

  BusCancelaltionSchedule copyWith({
    String? measure,
    String? from,
    String? to,
  }) {
    return BusCancelaltionSchedule(
      measure: measure ?? this.measure,
      from: from ?? this.from,
      to: to ?? this.to,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (measure != null) {
      result.addAll({'measure': measure});
    }
    if (from != null) {
      result.addAll({'from': from});
    }
    if (to != null) {
      result.addAll({'to': to});
    }

    return result;
  }

  factory BusCancelaltionSchedule.fromMap(Map<String, dynamic> map) {
    return BusCancelaltionSchedule(
      measure: map['measure'],
      from: map['from'],
      to: map['to'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BusCancelaltionSchedule.fromJson(String source) =>
      BusCancelaltionSchedule.fromMap(json.decode(source));

  @override
  String toString() =>
      'BusCancelaltionSchedule(measure: $measure, from: $from, to: $to)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BusCancelaltionSchedule &&
        other.measure == measure &&
        other.from == from &&
        other.to == to;
  }

  @override
  int get hashCode => measure.hashCode ^ from.hashCode ^ to.hashCode;
}
