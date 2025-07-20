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

  const DatePicker(
      {super.key,
      this.isRangePicker = false,
      this.startDate,
      this.endDate,
      this.minDate});

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
              }
              setState(() {});
            },
            minDate: widget.minDate ?? DateTime.now(),
            selectionMode: widget.isRangePicker
                ? DateRangePickerSelectionMode.range
                : DateRangePickerSelectionMode.single,
          ),
         
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
                SizedBox(
                  width: 12.w,
                ),
                Expanded(
                  child: LabeledInfoWidget(
                    title: "To",
                    content: _endDate != null
                        ? CustomDateUtils.dayMonthYearFormat(_endDate!)
                        : "N/A",
                  ),
                )
              ],
            ),
             SizedBox(
            height: 24.h,
          ),
          CustomButton(
            text: "Save",
            onPressed: saveAndReturn,
          ),
        ],
      ),
    );
  }
}
