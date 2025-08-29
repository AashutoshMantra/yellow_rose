import 'dart:math';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:yellow_rose/core/common_widgets/custom_overlay_dropdownd.dart';
import 'package:yellow_rose/core/common_widgets/custom_text_form_field.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/features/hotel/domain/entities/special_request.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HotelSpecialRequestWidget extends StatefulWidget {
  final SpecialRequest? request; // nullable here
  final ValueChanged<SpecialRequest?> onChanged;

  const HotelSpecialRequestWidget({
    super.key,
    this.request,
    required this.onChanged,
  });

  @override
  State<HotelSpecialRequestWidget> createState() =>
      _HotelSpecialRequestWidgetState();
}

class _HotelSpecialRequestWidgetState extends State<HotelSpecialRequestWidget> {
  late SpecialRequest? _current;

  @override
  void initState() {
    super.initState();
    _current = widget.request;
  }

  void _toggleRequest(SpecialRequestEnum requestType) {
    final selected = _current?.selectedRequests.toList() ?? [];
    if (selected.contains(requestType)) {
      selected.remove(requestType);
    } else {
      selected.add(requestType);
    }

    final updated =
        (_current ?? SpecialRequest()).copyWith(selectedRequests: selected);
    _update(updated);
  }

  void _update(SpecialRequest? updated) {
    setState(() => _current = updated);
    widget.onChanged(updated);
  }

  Future<void> _pickDateTime(
    BuildContext context,
    SpecialRequestEnum type,
  ) async {
    final initial = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date != null) {
      final time = await showTimePicker(
        context: context,
        initialTime: const TimeOfDay(hour: 14, minute: 0),
      );
      if (time != null) {
        final dt = DateTime(
          date.year,
          date.month,
          date.day,
          time.hour,
          time.minute,
        );

        final updated = widget.request?.copyWith(
          earlyCheckinDateTime: type == SpecialRequestEnum.earlyCheckin
              ? dt
              : widget.request!.earlyCheckinDateTime,
          lateCheckoutDateTime: type == SpecialRequestEnum.lateCheckout
              ? dt
              : widget.request!.lateCheckoutDateTime,
        );
        _update(updated);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Show placeholder text when _current is null or no selection
    final selectedText =
        (_current == null || _current!.selectedRequests.isEmpty)
            ? "Select Special Requests"
            : _current!.selectedRequests.map((e) => e.displayName).join(", ");

    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DropdownButtonHideUnderline(
            child: DropdownButton2(
              isExpanded: true,
              customButton: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.primary),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(selectedText),
              ),
              items: SpecialRequestEnum.values
                  .map(
                    (item) => DropdownMenuItem<SpecialRequestEnum>(
                      value: item,
                      enabled: false,
                      child: StatefulBuilder(
                        builder: (context, menuSetState) {
                          final isChecked =
                              _current?.selectedRequests.contains(item) ??
                                  false;
                          return CheckboxListTile(
                            value: isChecked,
                            onChanged: (_) {
                              menuSetState(() {});
                              _toggleRequest(item);
                            },
                            title: Text(item.name),
                            controlAffinity: ListTileControlAffinity.leading,
                          );
                        },
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (_) {},
            ),
          ),
          SizedBox(height: 16.h),
          if (_current?.isSelected(SpecialRequestEnum.earlyCheckin) ?? false)
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.h),
                  border: Border.all(color: AppColors.primary)),
              child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    _pickDateTime(context, SpecialRequestEnum.earlyCheckin);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          _current?.earlyCheckinDateTime != null
                              ? DateFormat('dd/MM/yyyy mm:HH')
                                  .format(_current!.earlyCheckinDateTime!)
                              : 'dd/mm/yyyy',
                          style: TextStyles.bodySmallBoldStyle().copyWith(
                              color: _current?.earlyCheckinDateTime != null
                                  ? AppColors.primary
                                  : Colors.grey),
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.calendar_month,
                        )
                      ],
                    ),
                  )),
            ),
          if (_current?.isSelected(SpecialRequestEnum.lateCheckout) ?? false)
            Container(
              margin: EdgeInsets.symmetric(vertical: 16.h),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.h),
                  border: Border.all(color: AppColors.primary)),
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  _pickDateTime(context, SpecialRequestEnum.lateCheckout);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        _current?.lateCheckoutDateTime != null
                            ? DateFormat('dd/MM/yyyy mm:HH')
                                .format(_current!.lateCheckoutDateTime!)
                            : 'dd/mm/yyyy',
                        style: TextStyles.bodySmallBoldStyle().copyWith(
                            color: _current?.lateCheckoutDateTime != null
                                ? AppColors.primary
                                : Colors.grey),
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.calendar_month,
                      )
                    ],
                  ),
                ),
              ),
            ),
          if (_current?.isSelected(SpecialRequestEnum.others) ?? false)
            CustomTextFormField(
              text: widget.request?.otherRequest ?? "Select Other",
              onchange: (val) => _update(
                  (_current ?? SpecialRequest()).copyWith(otherRequest: val)),
            ),
        ],
      ),
    );
  }
}
