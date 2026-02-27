import 'package:yellow_rose/features/auth/data/models/policy/approval_workflow_request.dart';
import 'package:yellow_rose/features/trip/data/models/trip_create_request.dart';

extension GetAllowedRequesterTypes on ApprovalWorkflow {
  List<TripFor> get allowedRequesterTypes {
    if (travelRules == null || travelRules!.isEmpty) return [];

    final Set<TripFor> types = {};

    for (final rule in travelRules!) {
      final policies = rule.rules?.policies;
      if (policies == null) continue;

      for (final policy in policies) {
        if (policy.code == 'REQUESTER_TYPE' && policy.value is List) {
          for (final code in (policy.value as List)) {
            final tripFor = TripFor.fromRequesterTypeCode(code.toString());
            if (tripFor != null) types.add(tripFor);
          }
        }
      }
    }

    final sorted = types.toList()..sort((a, b) => a.index.compareTo(b.index));
    return sorted;
  }
}
