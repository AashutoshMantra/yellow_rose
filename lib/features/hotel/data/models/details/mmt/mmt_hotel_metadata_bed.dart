import 'dart:convert';

class MMTHotelMetadataBed {
   
    final String? type;
    final int? count;
  MMTHotelMetadataBed({
    this.type,
    this.count,
  });

  MMTHotelMetadataBed copyWith({
    String? type,
    int? count,
  }) {
    return MMTHotelMetadataBed(
      type: type ?? this.type,
      count: count ?? this.count,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(type != null){
      result.addAll({'type': type});
    }
    if(count != null){
      result.addAll({'count': count});
    }
  
    return result;
  }

  factory MMTHotelMetadataBed.fromMap(Map<String, dynamic> map) {
    return MMTHotelMetadataBed(
      type: map['type'],
      count: map['count']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory MMTHotelMetadataBed.fromJson(String source) => MMTHotelMetadataBed.fromMap(json.decode(source));

  @override
  String toString() => 'MMTHotelMetadataBed(type: $type, count: $count)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is MMTHotelMetadataBed &&
      other.type == type &&
      other.count == count;
  }

  @override
  int get hashCode => type.hashCode ^ count.hashCode;
}
