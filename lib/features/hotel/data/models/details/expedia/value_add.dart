import 'dart:convert';

class ExpediaHotelSearchRespValueAdds {
  final String? id;
  final String? description;
  final String? category;
  final String? offerType;
  final String? frequency;
  final int? personCount;
  ExpediaHotelSearchRespValueAdds({
    this.id,
    this.description,
    this.category,
    this.offerType,
    this.frequency,
    this.personCount,
  });

  ExpediaHotelSearchRespValueAdds copyWith({
    String? id,
    String? description,
    String? category,
    String? offerType,
    String? frequency,
    int? personCount,
  }) {
    return ExpediaHotelSearchRespValueAdds(
      id: id ?? this.id,
      description: description ?? this.description,
      category: category ?? this.category,
      offerType: offerType ?? this.offerType,
      frequency: frequency ?? this.frequency,
      personCount: personCount ?? this.personCount,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(id != null){
      result.addAll({'id': id});
    }
    if(description != null){
      result.addAll({'description': description});
    }
    if(category != null){
      result.addAll({'category': category});
    }
    if(offerType != null){
      result.addAll({'offerType': offerType});
    }
    if(frequency != null){
      result.addAll({'frequency': frequency});
    }
    if(personCount != null){
      result.addAll({'personCount': personCount});
    }
  
    return result;
  }

  factory ExpediaHotelSearchRespValueAdds.fromMap(Map<String, dynamic> map) {
    return ExpediaHotelSearchRespValueAdds(
      id: map['id'],
      description: map['description'],
      category: map['category'],
      offerType: map['offerType'],
      frequency: map['frequency'],
      personCount: map['personCount']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ExpediaHotelSearchRespValueAdds.fromJson(String source) => ExpediaHotelSearchRespValueAdds.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ExpediaHotelSearchRespValueAdds(id: $id, description: $description, category: $category, offerType: $offerType, frequency: $frequency, personCount: $personCount)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ExpediaHotelSearchRespValueAdds &&
      other.id == id &&
      other.description == description &&
      other.category == category &&
      other.offerType == offerType &&
      other.frequency == frequency &&
      other.personCount == personCount;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      description.hashCode ^
      category.hashCode ^
      offerType.hashCode ^
      frequency.hashCode ^
      personCount.hashCode;
  }
}
