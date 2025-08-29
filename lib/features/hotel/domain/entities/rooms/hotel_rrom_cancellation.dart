import 'dart:convert';

class HotelRoomPenalty {
  final String? startDate;
  final String? endDate;
  final String? value;
  HotelRoomPenalty({
    this.startDate,
    this.endDate,
    this.value,
  });

  HotelRoomPenalty copyWith({
    String? startDate,
    String? endDate,
    String? value,
  }) {
    return HotelRoomPenalty(
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      value: value ?? this.value,
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
    if(value != null){
      result.addAll({'value': value});
    }
  
    return result;
  }

  factory HotelRoomPenalty.fromMap(Map<String, dynamic> map) {
    return HotelRoomPenalty(
      startDate: map['startDate'],
      endDate: map['endDate'],
      value: map['value'],
    );
  }

  String toJson() => json.encode(toMap());

  factory HotelRoomPenalty.fromJson(String source) => HotelRoomPenalty.fromMap(json.decode(source));

  @override
  String toString() => 'HotelRromPenalty(startDate: $startDate, endDate: $endDate, value: $value)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is HotelRoomPenalty &&
      other.startDate == startDate &&
      other.endDate == endDate &&
      other.value == value;
  }

  @override
  int get hashCode => startDate.hashCode ^ endDate.hashCode ^ value.hashCode;
}
