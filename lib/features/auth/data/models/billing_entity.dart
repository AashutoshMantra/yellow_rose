import 'dart:convert';

class BillingEntity {
  String? createdDate;
  String? lastModifiedDate;
  String? createdBy;
  String? lastModifiedBy;
  int? entityId;
  String? entityRefId;
  String? accountCode;
  String? state;
  String? city;
  String? postalCode;
  String? address;
  String? phone;
  String? email;
  String? gstType;
  String? entityGST;
  String? entityName;
  String? gstAccountCode;
  String? gstName;
  bool? isEnabled;
  BillingEntity({
    this.createdDate,
    this.lastModifiedDate,
    this.createdBy,
    this.lastModifiedBy,
    this.entityId,
    this.entityRefId,
    this.accountCode,
    this.state,
    this.city,
    this.postalCode,
    this.address,
    this.phone,
    this.email,
    this.gstType,
    this.entityGST,
    this.entityName,
    this.gstAccountCode,
    this.gstName,
    this.isEnabled,
  });

  BillingEntity copyWith({
    String? createdDate,
    String? lastModifiedDate,
    String? createdBy,
    String? lastModifiedBy,
    int? entityId,
    String? entityRefId,
    String? accountCode,
    String? state,
    String? city,
    String? postalCode,
    String? address,
    String? phone,
    String? email,
    String? gstType,
    String? entityGST,
    String? entityName,
    String? gstAccountCode,
    String? gstName,
    bool? isEnabled,
  }) {
    return BillingEntity(
      createdDate: createdDate ?? this.createdDate,
      lastModifiedDate: lastModifiedDate ?? this.lastModifiedDate,
      createdBy: createdBy ?? this.createdBy,
      lastModifiedBy: lastModifiedBy ?? this.lastModifiedBy,
      entityId: entityId ?? this.entityId,
      entityRefId: entityRefId ?? this.entityRefId,
      accountCode: accountCode ?? this.accountCode,
      state: state ?? this.state,
      city: city ?? this.city,
      postalCode: postalCode ?? this.postalCode,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      gstType: gstType ?? this.gstType,
      entityGST: entityGST ?? this.entityGST,
      entityName: entityName ?? this.entityName,
      gstAccountCode: gstAccountCode ?? this.gstAccountCode,
      gstName: gstName ?? this.gstName,
      isEnabled: isEnabled ?? this.isEnabled,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (createdDate != null) {
      result.addAll({'createdDate': createdDate});
    }
    if (lastModifiedDate != null) {
      result.addAll({'lastModifiedDate': lastModifiedDate});
    }
    if (createdBy != null) {
      result.addAll({'createdBy': createdBy});
    }
    if (lastModifiedBy != null) {
      result.addAll({'lastModifiedBy': lastModifiedBy});
    }
    if (entityId != null) {
      result.addAll({'entityId': entityId});
    }
    if (entityRefId != null) {
      result.addAll({'entityRefId': entityRefId});
    }
    if (accountCode != null) {
      result.addAll({'accountCode': accountCode});
    }
    if (state != null) {
      result.addAll({'state': state});
    }
    if (city != null) {
      result.addAll({'city': city});
    }
    if (postalCode != null) {
      result.addAll({'postalCode': postalCode});
    }
    if (address != null) {
      result.addAll({'address': address});
    }
    if (phone != null) {
      result.addAll({'phone': phone});
    }
    if (email != null) {
      result.addAll({'email': email});
    }
    if (gstType != null) {
      result.addAll({'gstType': gstType});
    }
    if (entityGST != null) {
      result.addAll({'entityGST': entityGST});
    }
    if (entityName != null) {
      result.addAll({'entityName': entityName});
    }
    if (gstAccountCode != null) {
      result.addAll({'gstAccountCode': gstAccountCode});
    }
    if (gstName != null) {
      result.addAll({'gstName': gstName});
    }
    if (isEnabled != null) {
      result.addAll({'isEnabled': isEnabled});
    }

    return result;
  }

  factory BillingEntity.fromMap(Map<String, dynamic> map) {
    return BillingEntity(
      createdDate: map['createdDate'],
      lastModifiedDate: map['lastModifiedDate'],
      createdBy: map['createdBy'],
      lastModifiedBy: map['lastModifiedBy'],
      entityId: map['entityId']?.toInt(),
      entityRefId: map['entityRefId'],
      accountCode: map['accountCode'],
      state: map['state'],
      city: map['city'],
      postalCode: map['postalCode'],
      address: map['address'],
      phone: map['phone'],
      email: map['email'],
      gstType: map['gstType'],
      entityGST: map['entityGST'],
      entityName: map['entityName'],
      gstAccountCode: map['gstAccountCode'],
      gstName: map['gstName'],
      isEnabled: map['isEnabled'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BillingEntity.fromJson(String source) =>
      BillingEntity.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BillingEntity(createdDate: $createdDate, lastModifiedDate: $lastModifiedDate, createdBy: $createdBy, lastModifiedBy: $lastModifiedBy, entityId: $entityId, entityRefId: $entityRefId, accountCode: $accountCode, state: $state, city: $city, postalCode: $postalCode, address: $address, phone: $phone, email: $email, gstType: $gstType, entityGST: $entityGST, entityName: $entityName, gstAccountCode: $gstAccountCode, gstName: $gstName, isEnabled: $isEnabled)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BillingEntity &&
        other.createdDate == createdDate &&
        other.lastModifiedDate == lastModifiedDate &&
        other.createdBy == createdBy &&
        other.lastModifiedBy == lastModifiedBy &&
        other.entityId == entityId &&
        other.entityRefId == entityRefId &&
        other.accountCode == accountCode &&
        other.state == state &&
        other.city == city &&
        other.postalCode == postalCode &&
        other.address == address &&
        other.phone == phone &&
        other.email == email &&
        other.gstType == gstType &&
        other.entityGST == entityGST &&
        other.entityName == entityName &&
        other.gstAccountCode == gstAccountCode &&
        other.gstName == gstName &&
        other.isEnabled == isEnabled;
  }

  @override
  int get hashCode {
    return createdDate.hashCode ^
        lastModifiedDate.hashCode ^
        createdBy.hashCode ^
        lastModifiedBy.hashCode ^
        entityId.hashCode ^
        entityRefId.hashCode ^
        accountCode.hashCode ^
        state.hashCode ^
        city.hashCode ^
        postalCode.hashCode ^
        address.hashCode ^
        phone.hashCode ^
        email.hashCode ^
        gstType.hashCode ^
        entityGST.hashCode ^
        entityName.hashCode ^
        gstAccountCode.hashCode ^
        gstName.hashCode ^
        isEnabled.hashCode;
  }
}
