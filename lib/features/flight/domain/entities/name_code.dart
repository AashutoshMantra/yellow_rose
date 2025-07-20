import 'dart:convert';

class NameCode {
  final String name;
  final String code;
  NameCode({
    required this.name,
    required this.code,
  });
  

  NameCode copyWith({
    String? name,
    String? code,
  }) {
    return NameCode(
      name: name ?? this.name,
      code: code ?? this.code,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'name': name});
    result.addAll({'code': code});
  
    return result;
  }

  factory NameCode.fromMap(Map<String, dynamic> map) {
    return NameCode(
      name: map['name'] ?? '',
      code: map['code'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory NameCode.fromJson(String source) => NameCode.fromMap(json.decode(source));

  @override
  String toString() => 'NameCode(name: $name, code: $code)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is NameCode &&
      other.name == name &&
      other.code == code;
  }

  @override
  int get hashCode => name.hashCode ^ code.hashCode;
}
