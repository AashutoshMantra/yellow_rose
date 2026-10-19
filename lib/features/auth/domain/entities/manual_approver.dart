import 'package:yellow_rose/features/auth/data/models/policy/approval_workflow_request.dart';

class ManualApprover {
  final String id;
  final String name;

  const ManualApprover({required this.id, required this.name});
}

extension GetManualApprovers on ApprovalWorkflow {
  List<List<ManualApprover>> get manualApproverGroups {
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
