import 'dart:convert';

class ExpediaHotelSearchRespMarketingFeeIncentive {
  final String? source;

  final String? start;

  final String? end;
  ExpediaHotelSearchRespMarketingFeeIncentive({
    this.source,
    this.start,
    this.end,
  });

  ExpediaHotelSearchRespMarketingFeeIncentive copyWith({
    String? source,
    String? start,
    String? end,
  }) {
    return ExpediaHotelSearchRespMarketingFeeIncentive(
      source: source ?? this.source,
      start: start ?? this.start,
      end: end ?? this.end,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (source != null) {
      result.addAll({'source': source});
    }
    if (start != null) {
      result.addAll({'start': start});
    }
    if (end != null) {
      result.addAll({'end': end});
    }

    return result;
  }

  factory ExpediaHotelSearchRespMarketingFeeIncentive.fromMap(
      Map<String, dynamic> map) {
    return ExpediaHotelSearchRespMarketingFeeIncentive(
      source: map['source'],
      start: map['start'],
      end: map['end'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ExpediaHotelSearchRespMarketingFeeIncentive.fromJson(String source) =>
      ExpediaHotelSearchRespMarketingFeeIncentive.fromMap(json.decode(source));

  @override
  String toString() =>
      'ExpediaHotelSearchRespMarketingFeeIncentive(source: $source, start: $start, end: $end)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ExpediaHotelSearchRespMarketingFeeIncentive &&
        other.source == source &&
        other.start == start &&
        other.end == end;
  }

  @override
  int get hashCode => source.hashCode ^ start.hashCode ^ end.hashCode;
}
