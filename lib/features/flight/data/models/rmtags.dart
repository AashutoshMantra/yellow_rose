import 'dart:convert';

class RmTags {
    String? name;
    String? displayName;
    String? value;
    String? fieldType;
    bool? invoiceable;
  RmTags({
    this.name,
    this.displayName,
    this.value,
    this.fieldType,
    this.invoiceable,
  });


  RmTags copyWith({
    String? name,
    String? displayName,
    String? value,
    String? fieldType,
    bool? invoiceable,
  }) {
    return RmTags(
      name: name ?? this.name,
      displayName: displayName ?? this.displayName,
      value: value ?? this.value,
      fieldType: fieldType ?? this.fieldType,
      invoiceable: invoiceable ?? this.invoiceable,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(name != null){
      result.addAll({'name': name});
    }
    if(displayName != null){
      result.addAll({'displayName': displayName});
    }
    if(value != null){
      result.addAll({'value': value});
    }
    if(fieldType != null){
      result.addAll({'fieldType': fieldType});
    }
    if(invoiceable != null){
      result.addAll({'invoiceable': invoiceable});
    }
  
    return result;
  }

  factory RmTags.fromMap(Map<String, dynamic> map) {
    return RmTags(
      name: map['name'],
      displayName: map['displayName'],
      value: map['value'],
      fieldType: map['fieldType'],
      invoiceable: map['invoiceable'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RmTags.fromJson(String source) => RmTags.fromMap(json.decode(source));

  @override
  String toString() {
    return 'RmTags(name: $name, displayName: $displayName, value: $value, fieldType: $fieldType, invoiceable: $invoiceable)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is RmTags &&
      other.name == name &&
      other.displayName == displayName &&
      other.value == value &&
      other.fieldType == fieldType &&
      other.invoiceable == invoiceable;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      displayName.hashCode ^
      value.hashCode ^
      fieldType.hashCode ^
      invoiceable.hashCode;
  }
}
