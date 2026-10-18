import 'package:yellow_rose/features/auth/data/models/policy/approval_workflow_request.dart';

class ManualApprover {
  final String id;
  final String name;

  const ManualApprover({required this.id, required this.name});
}

extension GetManualApprovers on ApprovalWorkflow {
  List<ManualApprover> get manualApprovers {
    final approvers = <ManualApprover>[];
    for (final level in workflow ?? []) {
      for (final keyValue in level.keyValue ?? []) {
        if (keyValue.key != 'manually' || keyValue.value == null) continue;
        for (final entry in keyValue.value!.split(',')) {
          final parts = entry.split('##');
          final id = parts.first.trim();
          if (id.isEmpty || approvers.any((a) => a.id == id)) continue;
          approvers.add(ManualApprover(
            id: id,
            name: parts.length > 1 ? parts[1].trim() : id,
          ));
        }
      }
    }
    return approvers;
  }
}
