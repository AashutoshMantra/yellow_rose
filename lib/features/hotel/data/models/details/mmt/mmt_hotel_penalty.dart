import 'dart:convert';

class MMTHotelSearchResPenalty {
  final String? startDate;
  final String? endDate;
  final String? penaltyValue;
  final String? penaltyType;
  MMTHotelSearchResPenalty({
    this.startDate,
    this.endDate,
    this.penaltyValue,
    this.penaltyType,
  });

  MMTHotelSearchResPenalty copyWith({
    String? startDate,
    String? endDate,
    String? penaltyValue,
    String? penaltyType,
  }) {
    return MMTHotelSearchResPenalty(
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      penaltyValue: penaltyValue ?? this.penaltyValue,
      penaltyType: penaltyType ?? this.penaltyType,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(startDate != null){
      result.addAll({'startDate': startDate});
    }
    if(endDate != null){
      result.addAll({'endDate': endDate});
    }
    if(penaltyValue != null){
      result.addAll({'penaltyValue': penaltyValue});
    }
    if(penaltyType != null){
      result.addAll({'penaltyType': penaltyType});
    }
  
    return result;
  }

  factory MMTHotelSearchResPenalty.fromMap(Map<String, dynamic> map) {
    return MMTHotelSearchResPenalty(
      startDate: map['startDate'],
      endDate: map['endDate'],
      penaltyValue: map['penaltyValue'],
      penaltyType: map['penaltyType'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MMTHotelSearchResPenalty.fromJson(String source) => MMTHotelSearchResPenalty.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MMTHotelSearchResPenalty(startDate: $startDate, endDate: $endDate, penaltyValue: $penaltyValue, penaltyType: $penaltyType)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is MMTHotelSearchResPenalty &&
      other.startDate == startDate &&
      other.endDate == endDate &&
      other.penaltyValue == penaltyValue &&
      other.penaltyType == penaltyType;
  }

  @override
  int get hashCode {
    return startDate.hashCode ^
      endDate.hashCode ^
      penaltyValue.hashCode ^
      penaltyType.hashCode;
  }
}
