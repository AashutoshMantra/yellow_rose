import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:yellow_rose/features/auth/data/models/policy/approvers.dart';
import 'package:yellow_rose/features/auth/data/models/policy/condition_request.dart';

class ApprovalWorkflowRule {
  final String? workFlowId;
  final String? workFlowName;
  final String? status;
  final String? product;
  final String? policyRuleApplied;
  final int? priority;
  final bool? approvalAdmin;
  final List<Approvers>? workFlow;
  final List<ConditionRequest>? matchAllConditions;
  final List<ConditionRequest>? matchAnyConditions;

  ApprovalWorkflowRule({
    this.workFlowId,
    this.workFlowName,
    this.status,
    this.product,
    this.policyRuleApplied,
    this.priority,
    this.approvalAdmin,
    this.workFlow,
    this.matchAllConditions,
    this.matchAnyConditions,
  });

  ApprovalWorkflowRule copyWith({
    String? workFlowId,
    String? workFlowName,
    String? status,
    String? product,
    String? policyRuleApplied,
    int? priority,
    bool? approvalAdmin,
    List<Approvers>? workFlow,
    List<ConditionRequest>? matchAllConditions,
    List<ConditionRequest>? matchAnyConditions,
  }) {
    return ApprovalWorkflowRule(
      workFlowId: workFlowId ?? this.workFlowId,
      workFlowName: workFlowName ?? this.workFlowName,
      status: status ?? this.status,
      product: product ?? this.product,
      policyRuleApplied: policyRuleApplied ?? this.policyRuleApplied,
      priority: priority ?? this.priority,
      approvalAdmin: approvalAdmin ?? this.approvalAdmin,
      workFlow: workFlow ?? this.workFlow,
      matchAllConditions: matchAllConditions ?? this.matchAllConditions,
      matchAnyConditions: matchAnyConditions ?? this.matchAnyConditions,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (workFlowId != null) {
      result.addAll({'workFlowId': workFlowId});
    }
    if (workFlowName != null) {
      result.addAll({'workFlowName': workFlowName});
    }
    if (status != null) {
      result.addAll({'status': status});
    }
    if (product != null) {
      result.addAll({'product': product});
    }
    if (policyRuleApplied != null) {
      result.addAll({'policyRuleApplied': policyRuleApplied});
    }
    if (priority != null) {
      result.addAll({'priority': priority});
    }
    if (approvalAdmin != null) {
      result.addAll({'approvalAdmin': approvalAdmin});
    }
    if (workFlow != null) {
      result.addAll({'workFlow': workFlow!.map((x) => x.toMap()).toList()});
    }
    if (matchAllConditions != null) {
      result.addAll({
        'matchAllConditions': matchAllConditions!.map((x) => x.toMap()).toList()
      });
    }
    if (matchAnyConditions != null) {
      result.addAll({
        'matchAnyConditions': matchAnyConditions!.map((x) => x.toMap()).toList()
      });
    }

    return result;
  }

  factory ApprovalWorkflowRule.fromMap(Map<String, dynamic> map) {
    return ApprovalWorkflowRule(
      workFlowId: map['workFlowId'],
      workFlowName: map['workFlowName'],
      status: map['status'],
      product: map['product'],
      policyRuleApplied: map['policyRuleApplied'],
      priority: map['priority']?.toInt(),
      approvalAdmin: map['approvalAdmin'],
      workFlow: map['workFlow'] != null
          ? List<Approvers>.from(
              map['workFlow']?.map((x) => Approvers.fromMap(x)))
          : null,
      matchAllConditions: map['matchAllConditions'] != null
          ? List<ConditionRequest>.from(map['matchAllConditions']
              ?.map((x) => ConditionRequest.fromMap(x)))
          : null,
      matchAnyConditions: map['matchAnyConditions'] != null
          ? List<ConditionRequest>.from(map['matchAnyConditions']
              ?.map((x) => ConditionRequest.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ApprovalWorkflowRule.fromJson(String source) =>
      ApprovalWorkflowRule.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ApprovalWorkflowRule(workFlowId: $workFlowId, workFlowName: $workFlowName, status: $status, product: $product, policyRuleApplied: $policyRuleApplied, priority: $priority, approvalAdmin: $approvalAdmin, workFlow: $workFlow, matchAllConditions: $matchAllConditions, matchAnyConditions: $matchAnyConditions)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ApprovalWorkflowRule &&
        other.workFlowId == workFlowId &&
        other.workFlowName == workFlowName &&
        other.status == status &&
        other.product == product &&
        other.policyRuleApplied == policyRuleApplied &&
        other.priority == priority &&
        other.approvalAdmin == approvalAdmin &&
        listEquals(other.workFlow, workFlow) &&
        listEquals(other.matchAllConditions, matchAllConditions) &&
        listEquals(other.matchAnyConditions, matchAnyConditions);
  }

  @override
  int get hashCode {
    return workFlowId.hashCode ^
        workFlowName.hashCode ^
        status.hashCode ^
        product.hashCode ^
        policyRuleApplied.hashCode ^
        priority.hashCode ^
        approvalAdmin.hashCode ^
        workFlow.hashCode ^
        matchAllConditions.hashCode ^
        matchAnyConditions.hashCode;
  }
}
