import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:yellow_rose/features/auth/data/models/policy/approval_workflow_rule.dart';

class ApprovalWorkflowRuleResponse {
  final String? policyCode;
  final String? rule;
  final List<ApprovalWorkflowRule>? approvalWorkflowRequest;

  ApprovalWorkflowRuleResponse({
    this.policyCode,
    this.rule,
    this.approvalWorkflowRequest,
  });

  ApprovalWorkflowRuleResponse copyWith({
    String? policyCode,
    String? rule,
    List<ApprovalWorkflowRule>? approvalWorkflowRequest,
  }) {
    return ApprovalWorkflowRuleResponse(
      policyCode: policyCode ?? this.policyCode,
      rule: rule ?? this.rule,
      approvalWorkflowRequest:
          approvalWorkflowRequest ?? this.approvalWorkflowRequest,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (policyCode != null) {
      result.addAll({'policyCode': policyCode});
    }
    if (rule != null) {
      result.addAll({'rule': rule});
    }
    if (approvalWorkflowRequest != null) {
      result.addAll({
        'approvalWorkflowRequest':
            approvalWorkflowRequest!.map((x) => x.toMap()).toList()
      });
    }

    return result;
  }

  factory ApprovalWorkflowRuleResponse.fromMap(Map<String, dynamic> map) {
    return ApprovalWorkflowRuleResponse(
      policyCode: map['policyCode'],
      rule: map['rule'],
      approvalWorkflowRequest: map['approvalWorkflowRequest'] != null
          ? List<ApprovalWorkflowRule>.from(map['approvalWorkflowRequest']
              ?.map((x) => ApprovalWorkflowRule.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ApprovalWorkflowRuleResponse.fromJson(String source) =>
      ApprovalWorkflowRuleResponse.fromMap(json.decode(source));

  @override
  String toString() =>
      'ApprovalWorkflowRuleResponse(policyCode: $policyCode, rule: $rule, approvalWorkflowRequest: $approvalWorkflowRequest)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ApprovalWorkflowRuleResponse &&
        other.policyCode == policyCode &&
        other.rule == rule &&
        listEquals(other.approvalWorkflowRequest, approvalWorkflowRequest);
  }

  @override
  int get hashCode =>
      policyCode.hashCode ^ rule.hashCode ^ approvalWorkflowRequest.hashCode;
}
