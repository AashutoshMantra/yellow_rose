import 'package:flutter/widgets.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';

class FormTitle extends StatelessWidget {
  final String title;
  const FormTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(title,
        style: TextStyles.bodyMediumMediumStyle().copyWith(
          color: AppColors.primaryTextSwatch[600],
        ));
  }
}
