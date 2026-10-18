import 'dart:convert';

class TripRmTag {
  final String? tagName;
  final String? tagDisplayName;
  final String? tagFixedValue;
  final String? checkValue;
  final String? fieldType;
  final String? required;
  final String? value;

  TripRmTag({
    this.tagName,
    this.tagDisplayName,
    this.tagFixedValue,
    this.checkValue,
    this.fieldType,
    this.required,
    this.value,
  });

  bool get isMandatory => required == 'C';

  List<String> get options =>
      (checkValue ?? '').split('|').where((e) => e.isNotEmpty).toList();

  TripRmTag copyWith({
    String? tagName,
    String? tagDisplayName,
    String? tagFixedValue,
    String? checkValue,
    String? fieldType,
    String? required,
    String? value,
  }) {
    return TripRmTag(
      tagName: tagName ?? this.tagName,
      tagDisplayName: tagDisplayName ?? this.tagDisplayName,
      tagFixedValue: tagFixedValue ?? this.tagFixedValue,
      checkValue: checkValue ?? this.checkValue,
      fieldType: fieldType ?? this.fieldType,
      required: required ?? this.required,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (tagName != null) {
      result.addAll({'tagName': tagName});
    }
    if (tagDisplayName != null) {
      result.addAll({'tagDisplayName': tagDisplayName});
    }
    if (tagFixedValue != null) {
      result.addAll({'tagFixedValue': tagFixedValue});
    }
    if (checkValue != null) {
      result.addAll({'checkValue': checkValue});
    }
    if (fieldType != null) {
      result.addAll({'fieldType': fieldType});
    }
    if (required != null) {
      result.addAll({'required': required});
    }
    if (value != null) {
      result.addAll({'value': value});
    }

    return result;
  }

  Map<String, dynamic> toRequestMap() {
    return {
      'displayName': (tagDisplayName ?? '').isNotEmpty ? tagDisplayName : tagName,
      'name': tagName,
      'value': value ?? '',
      'invoiceable': false,
      'required': required,
      'checkValue': checkValue ?? '',
      'tagFixedValue': tagFixedValue ?? '',
      'fieldType': fieldType,
    };
  }

  factory TripRmTag.fromMap(Map<String, dynamic> map) {
    final tagValue = map['tagValue'];
    return TripRmTag(
      tagName: map['tagName'],
      tagDisplayName: map['tagDisplayName'],
      tagFixedValue: map['tagFixedValue'],
      checkValue: map['checkValue'] ??
          (tagValue is Map ? tagValue['checkValue'] : null),
      fieldType: map['fieldType'] ??
          (tagValue is Map ? tagValue['fieldType'] : null),
      required: map['required'],
      value: map['value'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TripRmTag.fromJson(String source) =>
      TripRmTag.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TripRmTag(tagName: $tagName, tagDisplayName: $tagDisplayName, tagFixedValue: $tagFixedValue, checkValue: $checkValue, fieldType: $fieldType, required: $required, value: $value)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TripRmTag &&
        other.tagName == tagName &&
        other.tagDisplayName == tagDisplayName &&
        other.tagFixedValue == tagFixedValue &&
        other.checkValue == checkValue &&
        other.fieldType == fieldType &&
        other.required == required &&
        other.value == value;
  }

  @override
  int get hashCode {
    return tagName.hashCode ^
        tagDisplayName.hashCode ^
        tagFixedValue.hashCode ^
        checkValue.hashCode ^
        fieldType.hashCode ^
        required.hashCode ^
        value.hashCode;
  }
}
