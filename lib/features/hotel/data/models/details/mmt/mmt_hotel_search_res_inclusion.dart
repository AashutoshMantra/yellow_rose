import 'dart:convert';

class MMTHotelSearchResInclusion {
    final String? name;
    final String? desc;
    final String? category;
  MMTHotelSearchResInclusion({
    this.name,
    this.desc,
    this.category,
  });

  MMTHotelSearchResInclusion copyWith({
    String? name,
    String? desc,
    String? category,
  }) {
    return MMTHotelSearchResInclusion(
      name: name ?? this.name,
      desc: desc ?? this.desc,
      category: category ?? this.category,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(name != null){
      result.addAll({'name': name});
    }
    if(desc != null){
      result.addAll({'desc': desc});
    }
    if(category != null){
      result.addAll({'category': category});
    }
  
    return result;
  }

  factory MMTHotelSearchResInclusion.fromMap(Map<String, dynamic> map) {
    return MMTHotelSearchResInclusion(
      name: map['name'],
      desc: map['desc'],
      category: map['category'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MMTHotelSearchResInclusion.fromJson(String source) => MMTHotelSearchResInclusion.fromMap(json.decode(source));

  @override
  String toString() => 'MMTHotelSearchResInclusion(name: $name, desc: $desc, category: $category)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is MMTHotelSearchResInclusion &&
      other.name == name &&
      other.desc == desc &&
      other.category == category;
  }

  @override
  int get hashCode => name.hashCode ^ desc.hashCode ^ category.hashCode;
}
