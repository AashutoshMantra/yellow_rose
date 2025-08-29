import 'dart:convert';

class MMTHotelSearchResMealPlan {
    final String? code;
    final String? value;
  MMTHotelSearchResMealPlan({
    this.code,
    this.value,
  });

  MMTHotelSearchResMealPlan copyWith({
    String? code,
    String? value,
  }) {
    return MMTHotelSearchResMealPlan(
      code: code ?? this.code,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(code != null){
      result.addAll({'code': code});
    }
    if(value != null){
      result.addAll({'value': value});
    }
  
    return result;
  }

  factory MMTHotelSearchResMealPlan.fromMap(Map<String, dynamic> map) {
    return MMTHotelSearchResMealPlan(
      code: map['code'],
      value: map['value'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MMTHotelSearchResMealPlan.fromJson(String source) => MMTHotelSearchResMealPlan.fromMap(json.decode(source));

  @override
  String toString() => 'MMTHotelSearchResMealPlan(code: $code, value: $value)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is MMTHotelSearchResMealPlan &&
      other.code == code &&
      other.value == value;
  }

  @override
  int get hashCode => code.hashCode ^ value.hashCode;
}
