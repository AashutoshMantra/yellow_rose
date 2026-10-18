import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yellow_rose/core/common_widgets/key_value_row.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/features/trip/data/models/trip_approver.dart';
import 'package:yellow_rose/features/trip/data/models/trip_response.dart';
import 'package:yellow_rose/features/trip/domain/entities/trip_approval_response_status.dart';
import 'package:yellow_rose/features/trip/presentation/cubit/trip_cubit.dart';

class TripApprovalChain extends StatefulWidget {
  final TripResponse trip;

  const TripApprovalChain({super.key, required this.trip});

  @override
  State<TripApprovalChain> createState() => _TripApprovalChainState();
}

class _TripApprovalChainState extends State<TripApprovalChain> {
  List<TripApprover> _approvers = [];

  @override
  void initState() {
    super.initState();
    _loadApprovers();
  }

  @override
  void didUpdateWidget(covariant TripApprovalChain oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.trip.status != widget.trip.status ||
        oldWidget.trip.tripUid != widget.trip.tripUid) {
      _loadApprovers();
    }
  }

  Future<void> _loadApprovers() async {
    final tripUid = widget.trip.tripUid;
    if (tripUid == null) return;

    final tripCubit = context.read<TripCubit>();
    try {
      final approvers = await tripCubit.getTripApprovers(tripUid);
      if (mounted) {
        setState(() => _approvers = approvers);
      }
    } catch (e, s) {
      log("$e $s");
    }
  }

  List<MapEntry<String, String>> _approverRows() {
    if (_approvers.isNotEmpty) {
      final sorted = [..._approvers]..sort(
          (a, b) => (a.approvalLevel ?? 0).compareTo(b.approvalLevel ?? 0));
      return sorted.map((approver) {
        final name = (approver.approverName ?? '').isNotEmpty
            ? approver.approverName!
            : approver.approverEmail ?? '';
        final status = _statusText(approver.status);
        return MapEntry(
          'Level ${approver.approvalLevel ?? ''}',
          status.isEmpty ? name : '$name ($status)',
        );
      }).toList();
    }

    final trip = widget.trip;
    final levels = [
      (trip.approvalLevel1Email, trip.approvalLevel1),
      (trip.approvalLevel2Email, trip.approvalLevel2),
      (trip.approvalLevel3Email, trip.approvalLevel3),
      (trip.approvalLevel4Email, trip.approvalLevel4),
    ];
    final rows = <MapEntry<String, String>>[];
    for (var i = 0; i < levels.length; i++) {
      final (email, uid) = levels[i];
      final value = (email ?? '').isNotEmpty ? email! : (uid ?? '');
      if (value.isNotEmpty) {
        rows.add(MapEntry('Level ${i + 1}', value));
      }
    }
    return rows;
  }

  String _statusText(String? status) {
    switch (TripApprovalResponseStatus.fromString(status)) {
      case TripApprovalResponseStatus.REVIEW:
        return 'Pending';
      case TripApprovalResponseStatus.APPROVED:
        return 'Approved';
      case TripApprovalResponseStatus.REJECTED:
        return 'Rejected';
      case null:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final rows = _approverRows();

    if (rows.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 24.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.h),
        border: Border.all(color: AppColors.primaryTextSwatch[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Approvers', style: TextStyles.bodyLargeBoldStyle()),
          SizedBox(height: 8.h),
          ...rows.map(
            (row) => KeyValueRow(label: row.key, value: row.value),
          ),
        ],
      ),
    );
  }
}
