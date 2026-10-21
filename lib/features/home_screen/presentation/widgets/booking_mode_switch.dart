import 'package:flutter/material.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/size_config.dart';

class BookingModeSwitch extends StatelessWidget {
  final bool isPersonal;
  final ValueChanged<bool> onChanged;

  const BookingModeSwitch({
    super.key,
    required this.isPersonal,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.primary,
      padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 12.h),
      child: Container(
        height: 44.h,
        padding: EdgeInsets.all(4.h),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(24.h),
        ),
        child: Stack(
          children: [
            AnimatedAlign(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              alignment:
                  isPersonal ? Alignment.centerRight : Alignment.centerLeft,
              child: FractionallySizedBox(
                widthFactor: 0.5,
                heightFactor: 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.h),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.12),
                        blurRadius: 8.w,
                        offset: Offset(0, 2.h),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              children: [
                _buildOption(
                  label: 'Business',
                  icon: Icons.business_center_outlined,
                  isSelected: !isPersonal,
                  onTap: () => onChanged(false),
                ),
                _buildOption(
                  label: 'Personal',
                  icon: Icons.person_outline_rounded,
                  isSelected: isPersonal,
                  onTap: () => onChanged(true),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOption({
    required String label,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Center(
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            style: TextStyles.bodyMediumSemiBoldStyle().copyWith(
              color: isSelected ? AppColors.primary : Colors.white,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  size: 18.h,
                  color: isSelected ? AppColors.primary : Colors.white,
                ),
                SizedBox(width: 8.w),
                Text(label),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
