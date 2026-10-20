import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yellow_rose/core/common_widgets/bottom_sheet_title_widget.dart';
import 'package:yellow_rose/core/common_widgets/button.dart';
import 'package:yellow_rose/core/common_widgets/labelled_drop_dowdn.dart';
import 'package:yellow_rose/core/utils/WidgetUtils.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/features/auth/domain/entities/manual_approver.dart';
import 'package:yellow_rose/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:yellow_rose/features/trip/presentation/cubit/trip_cubit.dart';

class TripApproverSelectionSheet extends StatefulWidget {
  final List<List<ManualApprover>> approverGroups;

  const TripApproverSelectionSheet({super.key, required this.approverGroups});

  // Returns the selected approver ids; empty when the workflow has no manual
  // approvers, null when the user dismissed the sheet.
  static Future<List<String>?> select(BuildContext context,
      {required String product}) async {
    final authCubit = context.read<AuthCubit>();
    final ptcNptcType =
        context.read<TripCubit>().selectedTrip?.tripDetails?.ptcNptcType;
    final groups = await authCubit.getManualApproverGroups(product,
        ptcNptcType: ptcNptcType);
    if (!context.mounted) return null;

    final approverGroups = groups
        .map((group) => group
            .map((approver) => ManualApprover(
                  id: approver.id,
                  name: approver.name == approver.id
                      ? authCubit.approverNameById(approver.id) ?? approver.id
                      : approver.name,
                ))
            .toList())
        .toList();
    if (approverGroups.isEmpty) return [];

    final result = await WidgetUtil.showBottomSheet(
      context,
      TripApproverSelectionSheet(approverGroups: approverGroups),
    );
    if (result is List<String>) return result;
    return null;
  }

  @override
  State<TripApproverSelectionSheet> createState() =>
      _TripApproverSelectionSheetState();
}

class _TripApproverSelectionSheetState
    extends State<TripApproverSelectionSheet> {
  late final List<String?> _selectedIds =
      List.filled(widget.approverGroups.length, null);

  String _label(List<ManualApprover> group, ManualApprover approver) {
    final hasDuplicateName =
        group.where((other) => other.name == approver.name).length > 1;
    return hasDuplicateName
        ? '${approver.name} (${approver.id})'
        : approver.name;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const BottomSheetTitleWidget(title: 'Select Approver'),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8.h),
              for (var i = 0; i < widget.approverGroups.length; i++) ...[
                LabeledDropDownField(
                  label: widget.approverGroups.length > 1
                      ? 'Approver ${i + 1} *'
                      : 'Approver *',
                  items: widget.approverGroups[i]
                      .map((approver) =>
                          _label(widget.approverGroups[i], approver))
                      .toList(),
                  selectedValue: _selectedIds[i] == null
                      ? null
                      : _label(
                          widget.approverGroups[i],
                          widget.approverGroups[i]
                              .firstWhere((a) => a.id == _selectedIds[i])),
                  onChanged: (value) {
                    final group = widget.approverGroups[i];
                    final selected = group
                        .where((approver) => _label(group, approver) == value)
                        .firstOrNull;
                    setState(() {
                      _selectedIds[i] = selected?.id;
                    });
                  },
                ),
                SizedBox(height: 16.h),
              ],
              SizedBox(height: 8.h),
              CustomButton(
                text: 'Continue',
                onPressed: () {
                  if (_selectedIds.any((id) => id == null)) {
                    WidgetUtil.showSnackBar('Please select approver', context);
                    return;
                  }
                  Navigator.of(context).pop(List<String>.from(_selectedIds));
                },
              ),
              SizedBox(height: 50.h),
            ],
          ),
        ),
      ],
    );
  }
}
