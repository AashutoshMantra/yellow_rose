import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yellow_rose/core/common_widgets/bottom_sheet_title_widget.dart';
import 'package:yellow_rose/core/common_widgets/button.dart';
import 'package:yellow_rose/core/common_widgets/pill_button.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/WidgetUtils.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/features/auth/domain/entities/manual_approver.dart';
import 'package:yellow_rose/features/auth/presentation/cubit/auth_cubit.dart';

class TripApproverSelectionSheet extends StatefulWidget {
  final List<List<ManualApprover>> approverGroups;

  const TripApproverSelectionSheet({super.key, required this.approverGroups});

  // Returns the selected approver ids; empty when the workflow has no manual
  // approvers, null when the user dismissed the sheet.
  static Future<List<String>?> select(BuildContext context) async {
    final approverGroups = context.read<AuthCubit>().manualApproverGroups;
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
                if (widget.approverGroups.length > 1) ...[
                  Text('Approver ${i + 1} *',
                      style: TextStyles.bodyMediumSemiBoldStyle()),
                  SizedBox(height: 8.h),
                ],
                Wrap(
                  spacing: 10.h,
                  runSpacing: 16.h,
                  children: widget.approverGroups[i].map((approver) {
                    final isSelected = _selectedIds[i] == approver.id;
                    return PillButton(
                      text: approver.name,
                      pillType:
                          isSelected ? PillType.primary : PillType.secondary,
                      onClick: () {
                        setState(() {
                          _selectedIds[i] = approver.id;
                        });
                      },
                    );
                  }).toList(),
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
