import 'dart:convert';

class ReviewDetail {
     double rating;
     int totalRatingCount;
  ReviewDetail({
    required this.rating,
    required this.totalRatingCount,
  });

  ReviewDetail copyWith({
    double? rating,
    int? totalRatingCount,
  }) {
    return ReviewDetail(
      rating: rating ?? this.rating,
      totalRatingCount: totalRatingCount ?? this.totalRatingCount,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'rating': rating});
    result.addAll({'totalRatingCount': totalRatingCount});
  
    return result;
  }

  factory ReviewDetail.fromMap(Map<String, dynamic> map) {
    return ReviewDetail(
      rating: map['rating']?.toDouble() ?? 0.0,
      totalRatingCount: map['totalRatingCount']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ReviewDetail.fromJson(String source) => ReviewDetail.fromMap(json.decode(source));

  @override
  String toString() => 'ReviewDetail(rating: $rating, totalRatingCount: $totalRatingCount)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ReviewDetail &&
      other.rating == rating &&
      other.totalRatingCount == totalRatingCount;
  }

  @override
  int get hashCode => rating.hashCode ^ totalRatingCount.hashCode;
}
