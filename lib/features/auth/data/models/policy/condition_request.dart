import 'dart:convert';

class ConditionRequest {
  final int? id;
  final String? attrType;
  final String? attName;
  final String? value;
  final String? operator;
  ConditionRequest({
    this.id,
    this.attrType,
    this.attName,
    this.value,
    this.operator,
  });

  ConditionRequest copyWith({
    int? id,
    String? attrType,
    String? attName,
    String? value,
    String? operator,
  }) {
    return ConditionRequest(
      id: id ?? this.id,
      attrType: attrType ?? this.attrType,
      attName: attName ?? this.attName,
      value: value ?? this.value,
      operator: operator ?? this.operator,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (attrType != null) {
      result.addAll({'attrType': attrType});
    }
    if (attName != null) {
      result.addAll({'attName': attName});
    }
    if (value != null) {
      result.addAll({'value': value});
    }
    if (operator != null) {
      result.addAll({'operator': operator});
    }

    return result;
  }

  factory ConditionRequest.fromMap(Map<String, dynamic> map) {
    return ConditionRequest(
      id: map['id']?.toInt(),
      attrType: map['attrType'],
      attName: map['attName'],
      value: map['value'],
      operator: map['operator'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ConditionRequest.fromJson(String source) =>
      ConditionRequest.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ConditionRequest(id: $id, attrType: $attrType, attName: $attName, value: $value, operator: $operator)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ConditionRequest &&
        other.id == id &&
        other.attrType == attrType &&
        other.attName == attName &&
        other.value == value &&
        other.operator == operator;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        attrType.hashCode ^
        attName.hashCode ^
        value.hashCode ^
        operator.hashCode;
  }
}
