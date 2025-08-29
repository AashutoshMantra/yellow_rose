import 'dart:convert';

class ExpediaHotelSearchResponseStartEnd {
  final String? start;
  final String? end;
  ExpediaHotelSearchResponseStartEnd({
    this.start,
    this.end,
  });

  ExpediaHotelSearchResponseStartEnd copyWith({
    String? start,
    String? end,
  }) {
    return ExpediaHotelSearchResponseStartEnd(
      start: start ?? this.start,
      end: end ?? this.end,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (start != null) {
      result.addAll({'start': start});
    }
    if (end != null) {
      result.addAll({'end': end});
    }

    return result;
  }

  factory ExpediaHotelSearchResponseStartEnd.fromMap(Map<String, dynamic> map) {
    return ExpediaHotelSearchResponseStartEnd(
      start: map['start'],
      end: map['end'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ExpediaHotelSearchResponseStartEnd.fromJson(String source) =>
      ExpediaHotelSearchResponseStartEnd.fromMap(json.decode(source));

  @override
  String toString() =>
      'ExpediaHotelSearchResponseStartEnd(start: $start, end: $end)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ExpediaHotelSearchResponseStartEnd &&
        other.start == start &&
        other.end == end;
  }

  @override
  int get hashCode => start.hashCode ^ end.hashCode;
}
