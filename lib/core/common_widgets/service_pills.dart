import 'package:flutter/material.dart';
import 'package:yellow_rose/core/common_widgets/pill.dart';
import 'package:yellow_rose/core/constants/supported_service.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/extensions.dart';
import 'package:yellow_rose/core/utils/size_config.dart';

class ServicePills extends StatelessWidget {
  final List<SupportedService> services;
  final int selectedIndex;
  final Function(int index, SupportedService service) onServiceSelected;

  const ServicePills({
    super.key,
    required this.services,
    required this.selectedIndex,
    required this.onServiceSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: services
          .asMap()
          .entries
          .map((e) => Padding(
                padding: EdgeInsets.only(right: 12.w),
                child: _buildServicePill(e.value, e.key),
              ))
          .toList(),
    );
  }

  Widget _buildServicePill(SupportedService service, int index) {
    final isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () => onServiceSelected(index, service),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.h),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.transparent,
          ),
        ),
        child: Pill(
          backgroundColor: isSelected ? Colors.white : AppColors.primary,
          child: Text(
            service.name.toTitleCase(),
            style: TextStyles.bodyMediumSemiBoldStyle().copyWith(
              color: isSelected ? AppColors.primary : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
