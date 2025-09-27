import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/core/common_widgets/pill.dart';
import 'package:yellow_rose/core/common_widgets/bottom_sheet_title_widget.dart';
import 'package:yellow_rose/features/flight/domain/entities/name_code.dart';
import 'package:yellow_rose/features/flight/presentation/widgets/airline_pill.dart';

class AirlineSelectionSheet extends StatefulWidget {
  final NameCode? initial;
  final List<NameCode> carriers;
  const AirlineSelectionSheet(
      {super.key, this.initial, required this.carriers});

  @override
  State<AirlineSelectionSheet> createState() => _AirlineSelectionSheetState();
}

class _AirlineSelectionSheetState extends State<AirlineSelectionSheet> {
  late TextEditingController _searchCtrl;
  NameCode? _selected;
  List<NameCode> _filtered = [];

  @override
  void initState() {
    super.initState();
    _searchCtrl = TextEditingController();
    _selected = widget.initial;
    _filtered = widget.carriers;
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  void _onSearch(String q) {
    setState(() {
      if (q.isEmpty) {
        _filtered = widget.carriers;
      } else {
        _filtered = widget.carriers
            .where((c) => c.name.toLowerCase().contains(q.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const BottomSheetTitleWidget(title: "Airline"),
          SizedBox(height: 8.h),
          // Choose carriers label
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Choose carriers',
              style: TextStyles.bodyMediumSemiBoldStyle()
                  .copyWith(color: AppColors.primaryTextSwatch[600]),
            ),
          ),
          SizedBox(height: 8.h),
          // Search bar container
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: AppColors.primarySwatch[50],
              borderRadius: BorderRadius.circular(8.h),
            ),
            child: Row(
              children: [
                Icon(Icons.search,
                    size: 20.h, color: AppColors.primaryTextSwatch[400]),
                SizedBox(width: 8.w),
                Expanded(
                  child: TextField(
                    controller: _searchCtrl,
                    onChanged: _onSearch,
                    decoration: const InputDecoration(
                      hintText: 'Search airlines',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                if (_selected != null)
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _selected = null;
                        _searchCtrl.clear();
                        _onSearch('');
                      });
                    },
                    icon: Icon(Icons.clear, size: 20.h),
                  )
              ],
            ),
          ),
          SizedBox(height: 12.h),
          // List
          ConstrainedBox(
            constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.6),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Any Airline option at top
                  InkWell(
                    onTap: () {
                      setState(() => _selected = null);
                      Navigator.of(context).pop(null);
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
                      child: Row(
                        children: [
                          // Use Pill styling similar to AirlinePill
                          Expanded(
                            child: Pill(
                              child: Text(
                                'Any Airline',
                                style: TextStyles.bodyMediumSemiBoldStyle()
                                    .copyWith(
                                        color:
                                            AppColors.primaryTextSwatch[700]),
                              ),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          if (_selected == null)
                            Icon(Icons.check_circle,
                                color: AppColors.primary, size: 20.h)
                        ],
                      ),
                    ),
                  ),
                  ..._filtered.mapIndexed((idx, carrier) {
                    final isSelected = _selected?.code == carrier.code;
                    return InkWell(
                      onTap: () {
                        setState(() => _selected = carrier);
                        Navigator.of(context).pop(_selected);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.h, horizontal: 8.w),
                        child: Row(
                          children: [
                            AirlinePill(
                                airline: carrier.name,
                                airlineCode: carrier.code),
                            const Spacer(),
                            if (isSelected)
                              Icon(Icons.check_circle,
                                  color: AppColors.primary, size: 20.h)
                          ],
                        ),
                      ),
                    );
                  })
                ],
              ),
            ),
          ),
          SizedBox(height: 12.h),
        ],
      ),
    );
  }
}
