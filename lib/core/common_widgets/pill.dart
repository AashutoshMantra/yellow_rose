import 'package:flutter/material.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/utils/size_config.dart';

class Pill extends StatelessWidget {
  final Color? backgroundColor;
  final Widget child;
  const Pill({super.key, required this.child, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.primaryTextSwatch[50],
          borderRadius: BorderRadius.circular(24.h)),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4.0.h, horizontal: 8.w),
        child: child,
      ),
    );
  }
}
