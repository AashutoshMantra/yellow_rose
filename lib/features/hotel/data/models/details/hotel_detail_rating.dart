import 'dart:convert';

class HotelDetailRating {
  final String? source;
  final int? reviewTotalRatingCount;
  final double? reviewRating;
  final double? starRating;
  final double? popularityScore;
  HotelDetailRating({
    this.source,
    this.reviewTotalRatingCount,
    this.reviewRating,
    this.starRating,
    this.popularityScore,
  });

  HotelDetailRating copyWith({
    String? source,
    int? reviewTotalRatingCount,
    double? reviewRating,
    double? starRating,
    double? popularityScore,
  }) {
    return HotelDetailRating(
      source: source ?? this.source,
      reviewTotalRatingCount: reviewTotalRatingCount ?? this.reviewTotalRatingCount,
      reviewRating: reviewRating ?? this.reviewRating,
      starRating: starRating ?? this.starRating,
      popularityScore: popularityScore ?? this.popularityScore,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(source != null){
      result.addAll({'source': source});
    }
    if(reviewTotalRatingCount != null){
      result.addAll({'reviewTotalRatingCount': reviewTotalRatingCount});
    }
    if(reviewRating != null){
      result.addAll({'reviewRating': reviewRating});
    }
    if(starRating != null){
      result.addAll({'starRating': starRating});
    }
    if(popularityScore != null){
      result.addAll({'popularityScore': popularityScore});
    }
  
    return result;
  }

  factory HotelDetailRating.fromMap(Map<String, dynamic> map) {
    return HotelDetailRating(
      source: map['source'],
      reviewTotalRatingCount: map['reviewTotalRatingCount']?.toInt(),
      reviewRating: map['reviewRating']?.toDouble(),
      starRating: map['starRating']?.toDouble(),
      popularityScore: map['popularityScore']?.toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory HotelDetailRating.fromJson(String source) => HotelDetailRating.fromMap(json.decode(source));

  @override
  String toString() {
    return 'HotelDetailRating(source: $source, reviewTotalRatingCount: $reviewTotalRatingCount, reviewRating: $reviewRating, starRating: $starRating, popularityScore: $popularityScore)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is HotelDetailRating &&
      other.source == source &&
      other.reviewTotalRatingCount == reviewTotalRatingCount &&
      other.reviewRating == reviewRating &&
      other.starRating == starRating &&
      other.popularityScore == popularityScore;
  }

  @override
  int get hashCode {
    return source.hashCode ^
      reviewTotalRatingCount.hashCode ^
      reviewRating.hashCode ^
      starRating.hashCode ^
      popularityScore.hashCode;
  }
}
