import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:yellow_rose/core/utils/extensions.dart';

import 'package:yellow_rose/features/auth/data/models/policy/approval_workflow_request.dart';
import 'package:yellow_rose/features/auth/data/models/policy/policy_rule_vlaue_type.dart';
import 'package:yellow_rose/features/auth/data/models/policy/policy_type.dart';
import 'package:yellow_rose/features/auth/data/models/policy/travel_rule.dart';
import 'package:yellow_rose/features/auth/data/models/user_type.dart';
import 'package:yellow_rose/features/flight/data/models/product_type.dart';

class PolicyRule {
  String? ruleId;
  final String? policyCode;
  final ProductTypeEnum? product;
  final String? name;
  final PolicyTypeEnum? policyType;
  final UserTypeEnum? userType;
  PolicyRuleValueTypeEnum? ruleValueType;
  final String? rule;
  final String? userUid;
  final ApprovalWorkflow? approvalWorkflowRequest;
  final List<TravelRulesDTO>? travelRules;
  PolicyRule({
    this.ruleId,
    this.policyCode,
    this.product,
    this.name,
    this.policyType,
    this.userType,
    this.rule,
    this.userUid,
    this.approvalWorkflowRequest,
    this.travelRules,
  });

  PolicyRule copyWith({
    String? ruleId,
    String? policyCode,
    ProductTypeEnum? product,
    String? name,
    PolicyTypeEnum? policyType,
    UserTypeEnum? userType,
    String? rule,
    String? userUid,
    ApprovalWorkflow? approvalWorkflowRequest,
    List<TravelRulesDTO>? travelRules,
  }) {
    return PolicyRule(
      ruleId: ruleId ?? this.ruleId,
      policyCode: policyCode ?? this.policyCode,
      product: product ?? this.product,
      name: name ?? this.name,
      policyType: policyType ?? this.policyType,
      userType: userType ?? this.userType,
      rule: rule ?? this.rule,
      userUid: userUid ?? this.userUid,
      approvalWorkflowRequest:
          approvalWorkflowRequest ?? this.approvalWorkflowRequest,
      travelRules: travelRules ?? this.travelRules,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (ruleId != null) {
      result.addAll({'ruleId': ruleId});
    }
    if (policyCode != null) {
      result.addAll({'policyCode': policyCode});
    }
    if (product != null) {
      result.addAll({'product': product!.name});
    }
    if (name != null) {
      result.addAll({'name': name});
    }
    if (policyType != null) {
      result.addAll({'policyType': policyType!.name});
    }
    if (userType != null) {
      result.addAll({'userType': userType!.name});
    }
    if (rule != null) {
      result.addAll({'rule': rule});
    }
    if (userUid != null) {
      result.addAll({'userUid': userUid});
    }
    if (approvalWorkflowRequest != null) {
      result.addAll(
          {'approvalWorkflowRequest': approvalWorkflowRequest!.toMap()});
    }
    if (travelRules != null) {
      result
          .addAll({'travelRules': travelRules!.map((x) => x.toMap()).toList()});
    }

    return result;
  }

  factory PolicyRule.fromMap(Map<String, dynamic> map) {
    return PolicyRule(
      ruleId: map['ruleId'],
      policyCode: map['policyCode'],
      product: (map['product'] as String?)?.toEnum(ProductTypeEnum.values),
      name: map['name'],
      policyType: (map['policyType'] as String?)?.toEnum(PolicyTypeEnum.values),
      userType: (map['userType'] as String?)?.toEnum(UserTypeEnum.values),
      rule: map['rule'],
      userUid: map['userUid'],
      approvalWorkflowRequest: map['approvalWorkflowRequest'] != null
          ? ApprovalWorkflow.fromMap(map['approvalWorkflowRequest'])
          : null,
      travelRules: map['travelRules'] != null
          ? List<TravelRulesDTO>.from(
              map['travelRules']?.map((x) => TravelRulesDTO.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PolicyRule.fromJson(String source) =>
      PolicyRule.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PolicyRule(ruleId: $ruleId, policyCode: $policyCode, product: $product, name: $name, policyType: $policyType, userType: $userType, rule: $rule, userUid: $userUid, approvalWorkflowRequest: $approvalWorkflowRequest, travelRules: $travelRules)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PolicyRule &&
        other.ruleId == ruleId &&
        other.policyCode == policyCode &&
        other.product == product &&
        other.name == name &&
        other.policyType == policyType &&
        other.userType == userType &&
        other.rule == rule &&
        other.userUid == userUid &&
        other.approvalWorkflowRequest == approvalWorkflowRequest &&
        listEquals(other.travelRules, travelRules);
  }

  @override
  int get hashCode {
    return ruleId.hashCode ^
        policyCode.hashCode ^
        product.hashCode ^
        name.hashCode ^
        policyType.hashCode ^
        userType.hashCode ^
        rule.hashCode ^
        userUid.hashCode ^
        approvalWorkflowRequest.hashCode ^
        travelRules.hashCode;
  }
}
