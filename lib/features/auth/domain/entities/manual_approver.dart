import 'package:yellow_rose/features/auth/data/models/policy/approval_workflow_request.dart';
import 'package:yellow_rose/features/auth/data/models/policy/approval_workflow_rule.dart';
import 'package:yellow_rose/features/auth/data/models/policy/approval_workflow_rule_response.dart';
import 'package:yellow_rose/features/auth/data/models/policy/condition_request.dart';

class ManualApprover {
  final String id;
  final String name;

  const ManualApprover({required this.id, required this.name});
}

extension GetManualApprovers on ApprovalWorkflow {
  List<List<ManualApprover>> manualApproverGroupsFor(String product) {
    final details = workflowRule?['ALL'] ?? workflowRule?[product];
    if (details != null && details.isNotEmpty) {
      final approvers = <ManualApprover>[];
      for (final detail in details) {
        final id = detail.approverId?.trim() ?? '';
        if (id.isEmpty) continue;
        final name = (detail.approverName ?? '').replaceAll('_', ' ').trim();
        approvers.add(ManualApprover(
          id: id,
          name: name.isEmpty || name == 'unknown' ? id : name,
        ));
      }
      if (approvers.isNotEmpty) return [approvers];
    }

    final firstLevel = workflow?.firstOrNull;
    final groups = <List<ManualApprover>>[];
    for (final keyValue in firstLevel?.keyValue ?? []) {
      if (keyValue.key != 'manually' || keyValue.value == null) continue;
      final approvers = <ManualApprover>[];
      for (final entry in keyValue.value!.split(',')) {
        final parts = entry.split('##');
        final id = parts.first.trim();
        if (id.isEmpty) continue;
        approvers.add(ManualApprover(
          id: id,
          name: parts.length > 1 ? parts[1].trim() : id,
        ));
      }
      if (approvers.isNotEmpty) groups.add(approvers);
    }
    return groups;
  }
}

extension GetManualApproversFromRule on ApprovalWorkflowRuleResponse {
  List<List<ManualApprover>> manualApproverGroupsFor(
    String product, {
    String? ptcNptcType,
  }) {
    final rules = (approvalWorkflowRequest ?? [])
        .where((rule) => rule.status == null || rule.status == 'A')
        .toList();
    final productRules = rules.any((rule) => rule.product == 'ALL')
        ? rules.where((rule) => rule.product == 'ALL')
        : rules.where((rule) => rule.product == product);

    final groups = <List<ManualApprover>>[];
    for (final rule in productRules) {
      if (!_appliesToTripType(rule, ptcNptcType)) continue;
      final firstLevel = rule.workFlow?.firstOrNull;
      for (final keyValue in firstLevel?.keyValue ?? []) {
        if (keyValue.key != 'manually' || keyValue.value == null) continue;
        final approvers = <ManualApprover>[];
        for (final entry in keyValue.value!.split(',')) {
          final parts = entry.split('##');
          final id = parts.first.trim();
          if (id.isEmpty) continue;
          approvers.add(ManualApprover(
            id: id,
            name: parts.length > 1 ? parts[1].trim() : id,
          ));
        }
        if (approvers.isNotEmpty) groups.add(approvers);
      }
    }
    return groups;
  }

  bool _appliesToTripType(ApprovalWorkflowRule rule, String? ptcNptcType) {
    if (ptcNptcType == null || ptcNptcType.isEmpty) return true;
    final conditions = <ConditionRequest>[
      ...?rule.matchAllConditions,
      ...?rule.matchAnyConditions,
    ].where((c) => c.attName?.toUpperCase() == 'TRIP_APPROVAL_TYPE');
    if (conditions.isEmpty) return true;
    return conditions.any((c) {
      final isEqual =
          (c.value ?? '').toUpperCase() == ptcNptcType.toUpperCase();
      return c.operator == '!=' ? !isEqual : isEqual;
    });
  }
}
