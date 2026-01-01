import 'package:flutter/material.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';

enum ButtonType { primary, secondary }

extension SelfReset on RoundedLoadingButtonController {
  void successReset() {
    success();
    Future.delayed(const Duration(milliseconds: 500), () {
      reset();
    });
  }

  void errorReset() {
    error();
    Future.delayed(const Duration(milliseconds: 500), () {
      reset();
    });
  }
}

class CustomButton extends StatelessWidget {
  final RoundedLoadingButtonController? buttonController;
  final ButtonType buttonType;
  final Function()? onPressed;
  final String text;
  const CustomButton(
      {super.key,
      this.buttonController,
      this.onPressed,
      required this.text,
      this.buttonType = ButtonType.primary});

  @override
  Widget build(BuildContext context) {
    return RoundedLoadingButton(
      controller: buttonController ?? RoundedLoadingButtonController(),
      animateOnTap: buttonController != null,
      onPressed: onPressed,
      color: buttonType == ButtonType.primary
          ? AppColors.primary
          : AppColors.primaryTextSwatch[100],
      successColor: AppColors.primaryGreen,
      errorColor: AppColors.error,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyles.bodyMediumBoldStyle().copyWith(
          color: buttonType == ButtonType.primary
              ? Colors.white
              : AppColors.primaryText,
        ),
      ),
    );
  }
}
