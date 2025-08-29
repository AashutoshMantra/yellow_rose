import 'package:flutter/material.dart';
import 'package:yellow_rose/core/common_widgets/custom_list_tile.dart';
import 'package:yellow_rose/core/common_widgets/increment_box.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';

class IncrementBoxPaxWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final Function(int) onChange;
  final int initialValue;
  final int? maxValue;
  final int minValue;

  const IncrementBoxPaxWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onChange,
    this.initialValue = 0,
    this.maxValue,
    this.minValue = 0,
  });

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      title: Text(
        title,
        style: TextStyles.bodyLargeSemiBoldStyle(),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyles.bodySmallStyle()
            .copyWith(color: AppColors.primaryTextSwatch[500]),
      ),
      trailing: IncrementBoxWidget(
          onValueChange: onChange,
          initialValue: initialValue,
          minValue: minValue,
          maxValue: maxValue),
    );
  }
}
