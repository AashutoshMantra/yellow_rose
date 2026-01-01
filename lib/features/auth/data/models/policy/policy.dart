import 'dart:convert';

class Policy {
  final String? code;
  final String? description;
  final Object? value;
  Policy({
    this.code,
    this.description,
    this.value,
  });

  Policy copyWith({
    String? code,
    String? description,
    Object? value,
  }) {
    return Policy(
      code: code ?? this.code,
      description: description ?? this.description,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (code != null) {
      result.addAll({'code': code});
    }
    if (description != null) {
      result.addAll({'description': description});
    }
    if (value != null) {
      result.addAll({'value': value!});
    }

    return result;
  }

  factory Policy.fromMap(Map<String, dynamic> map) {
    return Policy(
      code: map['code'],
      description: map['description'],
      value: map['value'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Policy.fromJson(String source) => Policy.fromMap(json.decode(source));

  @override
  String toString() =>
      'Policy(code: $code, description: $description, value: $value)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Policy &&
        other.code == code &&
        other.description == description &&
        other.value == value;
  }

  @override
  int get hashCode => code.hashCode ^ description.hashCode ^ value.hashCode;
}
