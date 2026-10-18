import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yellow_rose/core/common_widgets/bottom_sheet_title_widget.dart';
import 'package:yellow_rose/core/common_widgets/button.dart';
import 'package:yellow_rose/core/common_widgets/pill_button.dart';
import 'package:yellow_rose/core/utils/WidgetUtils.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/features/auth/domain/entities/manual_approver.dart';
import 'package:yellow_rose/features/auth/presentation/cubit/auth_cubit.dart';

class TripApproverSelectionSheet extends StatefulWidget {
  final List<ManualApprover> approvers;

  const TripApproverSelectionSheet({super.key, required this.approvers});

  // Returns approver ids; empty when the workflow has no manual approvers,
  // null when the user dismissed the sheet.
  static Future<List<String>?> select(BuildContext context) async {
    final approvers = context.read<AuthCubit>().manualApprovers;
    if (approvers.isEmpty) return [];

    final result = await WidgetUtil.showBottomSheet(
      context,
      TripApproverSelectionSheet(approvers: approvers),
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
  final List<String> _selectedIds = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const BottomSheetTitleWidget(title: 'Select Approvers'),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8.h),
              Wrap(
                spacing: 10.h,
                runSpacing: 16.h,
                children: widget.approvers.map((approver) {
                  final isSelected = _selectedIds.contains(approver.id);
                  return PillButton(
                    text: approver.name,
                    pillType:
                        isSelected ? PillType.primary : PillType.secondary,
                    onClick: () {
                      setState(() {
                        if (isSelected) {
                          _selectedIds.remove(approver.id);
                        } else {
                          _selectedIds.add(approver.id);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
              SizedBox(height: 24.h),
              CustomButton(
                text: 'Continue',
                onPressed: () {
                  if (_selectedIds.isEmpty) {
                    WidgetUtil.showSnackBar(
                        'Please select at least one approver', context);
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
