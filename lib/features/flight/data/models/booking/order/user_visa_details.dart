import 'dart:convert';

class UserVisaDetails {
  final int? id;

  final String? name;

  final String? visaNumber;

  final String? issuingCountry;

  final String? type;

  final DateTime? issueDate;

  final DateTime? expiryDate;
  UserVisaDetails({
    this.id,
    this.name,
    this.visaNumber,
    this.issuingCountry,
    this.type,
    this.issueDate,
    this.expiryDate,
  });

  UserVisaDetails copyWith({
    int? id,
    String? name,
    String? visaNumber,
    String? issuingCountry,
    String? type,
    DateTime? issueDate,
    DateTime? expiryDate,
  }) {
    return UserVisaDetails(
      id: id ?? this.id,
      name: name ?? this.name,
      visaNumber: visaNumber ?? this.visaNumber,
      issuingCountry: issuingCountry ?? this.issuingCountry,
      type: type ?? this.type,
      issueDate: issueDate ?? this.issueDate,
      expiryDate: expiryDate ?? this.expiryDate,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (name != null) {
      result.addAll({'name': name});
    }
    if (visaNumber != null) {
      result.addAll({'visaNumber': visaNumber});
    }
    if (issuingCountry != null) {
      result.addAll({'issuingCountry': issuingCountry});
    }
    if (type != null) {
      result.addAll({'type': type});
    }
    if (issueDate != null) {
      result.addAll({'issueDate': issueDate!.millisecondsSinceEpoch});
    }
    if (expiryDate != null) {
      result.addAll({'expiryDate': expiryDate!.millisecondsSinceEpoch});
    }

    return result;
  }

  factory UserVisaDetails.fromMap(Map<String, dynamic> map) {
    return UserVisaDetails(
      id: map['id']?.toInt(),
      name: map['name'],
      visaNumber: map['visaNumber'],
      issuingCountry: map['issuingCountry'],
      type: map['type'],
      issueDate: map['issueDate'] != null
          ? DateTime.tryParse(map['issueDate'])
          : null,
      expiryDate: map['expiryDate'] != null
          ? DateTime.tryParse(map['expiryDate'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserVisaDetails.fromJson(String source) =>
      UserVisaDetails.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserVisaDetails(id: $id, name: $name, visaNumber: $visaNumber, issuingCountry: $issuingCountry, type: $type, issueDate: $issueDate, expiryDate: $expiryDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserVisaDetails &&
        other.id == id &&
        other.name == name &&
        other.visaNumber == visaNumber &&
        other.issuingCountry == issuingCountry &&
        other.type == type &&
        other.issueDate == issueDate &&
        other.expiryDate == expiryDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        visaNumber.hashCode ^
        issuingCountry.hashCode ^
        type.hashCode ^
        issueDate.hashCode ^
        expiryDate.hashCode;
  }
}
