import 'dart:convert';

class ApproverKeyValue {
  final String? key;
  final String? value;
  final int? approverCounter;
  ApproverKeyValue({
    this.key,
    this.value,
    this.approverCounter,
  });

  ApproverKeyValue copyWith({
    String? key,
    String? value,
    int? approverCounter,
  }) {
    return ApproverKeyValue(
      key: key ?? this.key,
      value: value ?? this.value,
      approverCounter: approverCounter ?? this.approverCounter,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (key != null) {
      result.addAll({'key': key});
    }
    if (value != null) {
      result.addAll({'value': value});
    }
    if (approverCounter != null) {
      result.addAll({'approverCounter': approverCounter});
    }

    return result;
  }

  factory ApproverKeyValue.fromMap(Map<String, dynamic> map) {
    return ApproverKeyValue(
      key: map['key'],
      value: map['value'],
      approverCounter: map['approverCounter']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ApproverKeyValue.fromJson(String source) =>
      ApproverKeyValue.fromMap(json.decode(source));

  @override
  String toString() =>
      'ApproverKeyValue(key: $key, value: $value, approverCounter: $approverCounter)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ApproverKeyValue &&
        other.key == key &&
        other.value == value &&
        other.approverCounter == approverCounter;
  }

  @override
  int get hashCode => key.hashCode ^ value.hashCode ^ approverCounter.hashCode;
}
