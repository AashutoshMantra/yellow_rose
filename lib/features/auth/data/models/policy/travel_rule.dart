import 'dart:convert';

import 'package:yellow_rose/features/auth/data/models/policy/rule.dart';

class TravelRulesDTO {
  final String? ruleId;
  final String? ruleName;
  final bool? defaultRule;
  final Rules? rules;
  final String? productType;
  final String? createdBy;
  final int? priority;
  final String? corporateUserUid;
  TravelRulesDTO({
    this.ruleId,
    this.ruleName,
    this.defaultRule,
    this.rules,
    this.productType,
    this.createdBy,
    this.priority,
    this.corporateUserUid,
  });

  TravelRulesDTO copyWith({
    String? ruleId,
    String? ruleName,
    bool? defaultRule,
    Rules? rules,
    String? productType,
    String? createdBy,
    int? priority,
    String? corporateUserUid,
  }) {
    return TravelRulesDTO(
      ruleId: ruleId ?? this.ruleId,
      ruleName: ruleName ?? this.ruleName,
      defaultRule: defaultRule ?? this.defaultRule,
      rules: rules ?? this.rules,
      productType: productType ?? this.productType,
      createdBy: createdBy ?? this.createdBy,
      priority: priority ?? this.priority,
      corporateUserUid: corporateUserUid ?? this.corporateUserUid,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (ruleId != null) {
      result.addAll({'ruleId': ruleId});
    }
    if (ruleName != null) {
      result.addAll({'ruleName': ruleName});
    }
    if (defaultRule != null) {
      result.addAll({'defaultRule': defaultRule});
    }
    if (rules != null) {
      result.addAll({'rules': rules!.toMap()});
    }
    if (productType != null) {
      result.addAll({'productType': productType});
    }
    if (createdBy != null) {
      result.addAll({'createdBy': createdBy});
    }
    if (priority != null) {
      result.addAll({'priority': priority});
    }
    if (corporateUserUid != null) {
      result.addAll({'corporateUserUid': corporateUserUid});
    }

    return result;
  }

  factory TravelRulesDTO.fromMap(Map<String, dynamic> map) {
    return TravelRulesDTO(
      ruleId: map['ruleId'],
      ruleName: map['ruleName'],
      defaultRule: map['defaultRule'],
      rules: map['rules'] != null ? Rules.fromMap(map['rules']) : null,
      productType: map['productType'],
      createdBy: map['createdBy'],
      priority: map['priority']?.toInt(),
      corporateUserUid: map['corporateUserUid'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TravelRulesDTO.fromJson(String source) =>
      TravelRulesDTO.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TravelRulesDTO(ruleId: $ruleId, ruleName: $ruleName, defaultRule: $defaultRule, rules: $rules, productType: $productType, createdBy: $createdBy, priority: $priority, corporateUserUid: $corporateUserUid)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TravelRulesDTO &&
        other.ruleId == ruleId &&
        other.ruleName == ruleName &&
        other.defaultRule == defaultRule &&
        other.rules == rules &&
        other.productType == productType &&
        other.createdBy == createdBy &&
        other.priority == priority &&
        other.corporateUserUid == corporateUserUid;
  }

  @override
  int get hashCode {
    return ruleId.hashCode ^
        ruleName.hashCode ^
        defaultRule.hashCode ^
        rules.hashCode ^
        productType.hashCode ^
        createdBy.hashCode ^
        priority.hashCode ^
        corporateUserUid.hashCode;
  }
}
