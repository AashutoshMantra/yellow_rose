import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:yellow_rose/core/common_widgets/button.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/date_utils.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/core/common_widgets/labeled_info_widget.dart';

class DatePicker extends StatefulWidget {
  final bool isRangePicker;
  final DateTime? startDate;
  final DateTime? endDate;
  final DateTime? minDate;
  final bool requireBothStartAndEndDates; // ✅ New prop

  const DatePicker({
    super.key,
    this.isRangePicker = false,
    this.startDate,
    this.endDate,
    this.minDate,
    this.requireBothStartAndEndDates = false, // ✅ Default false
  });

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime? _startDate;
  DateTime? _endDate;
  late List<DateTime> _initialSelectedDates;

  @override
  void initState() {
    super.initState();
    _startDate = widget.startDate;
    _endDate = widget.endDate;
    _initialSelectedDates = [];
    if (_startDate != null) {
      _initialSelectedDates.add(_startDate!);
      if (_endDate != null) {
        _initialSelectedDates.add(_endDate!);
      }
    }
  }

  void saveAndReturn() {
    // ✅ Block save if both dates are required but one is missing
    if (widget.requireBothStartAndEndDates &&
        widget.isRangePicker &&
        (_startDate == null || _endDate == null)) {
      return;
    }

    List<DateTime> selectedDates = [];
    if (_startDate != null) {
      selectedDates.add(_startDate!);
      if (_endDate != null) {
        selectedDates.add(_endDate!);
      }
    }
    Navigator.of(context).pop(selectedDates);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.h),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Calendar",
                style: TextStyles.bodyLargeBoldStyle(),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop(_initialSelectedDates);
                },
                child: const Icon(
                  Icons.close,
                  color: AppColors.primaryText,
                ),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 16.h),
            child: Divider(
              color: AppColors.primaryTextSwatch[200],
            ),
          ),
          SfDateRangePicker(
            backgroundColor: Colors.white,
            initialSelectedDate: _startDate,
            initialSelectedRange: PickerDateRange(_startDate, _endDate),
            headerStyle: const DateRangePickerHeaderStyle(
              backgroundColor: Colors.white,
            ),
            onSelectionChanged: (args) {
              if (args.value is PickerDateRange) {
                _startDate = args.value.startDate;
                _endDate = args.value.endDate;
              } else if (args.value is DateTime) {
                _startDate = args.value;
                _endDate = null;
              }
              setState(() {});
            },
            minDate: widget.minDate ?? DateTime.now(),
            selectionMode: widget.isRangePicker
                ? DateRangePickerSelectionMode.range
                : DateRangePickerSelectionMode.single,
          ),

          // Show from-to info if range picker is enabled
          if (widget.isRangePicker)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: LabeledInfoWidget(
                    title: "From",
                    content: _startDate != null
                        ? CustomDateUtils.dayMonthYearFormat(_startDate!)
                        : "N/A",
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: LabeledInfoWidget(
                    title: "To",
                    content: _endDate != null
                        ? CustomDateUtils.dayMonthYearFormat(_endDate!)
                        : "N/A",
                  ),
                ),
              ],
            ),

          SizedBox(height: 24.h),

          // ✅ Disable Save if both dates required but not selected
          CustomButton(
            text: "Save",
            onPressed: (widget.requireBothStartAndEndDates &&
                    widget.isRangePicker &&
                    (_startDate == null || _endDate == null))
                ? null
                : saveAndReturn,
          ),
        ],
      ),
    );
  }
}
