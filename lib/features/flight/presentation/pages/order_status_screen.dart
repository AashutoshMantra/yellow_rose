import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:yellow_rose/core/common_widgets/button.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/size_config.dart';

enum OrderStatusEnum { success, error, warning }

class OrderStatusScreen extends StatelessWidget {
  final OrderStatusEnum orderStatus;
  const OrderStatusScreen({super.key, required this.orderStatus});

  @override
  Widget build(BuildContext context) {
    var (message, subtitle) = switch (orderStatus) {
      OrderStatusEnum.error => (
          "Failed to process order",
          "Back to homepage –  clicking the button below."
        ),
      OrderStatusEnum.success => (
          "Your Order Has Been Completed!",
          "You can check your e-Ticket by clicking the button below."
        ),
      OrderStatusEnum.warning => (
          "Partial Order completed",
          "You can check your e-Ticket by clicking the button below."
        ),
    };
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/order_${orderStatus.name}.png",
                        height: 200.h,
                      ),
                      SizedBox(
                        height: 56.h,
                      ),
                      Text(
                        message,
                        style: TextStyles.bodyXLargeBoldStyle(),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Text(
                        subtitle,
                        textAlign: TextAlign.center,
                        style: TextStyles.bodyXLargeBoldStyle()
                            .copyWith(color: AppColors.primaryTextSwatch[500]),
                      ),
                    ],
                  ),
                ),
              ),
              if (orderStatus != OrderStatusEnum.error)
                CustomButton(
                  text: "Check E-Ticket",
                  onPressed: () {},
                ),
              SizedBox(
                height: 16.h,
              ),
              CustomButton(
                  text: "Back to home",
                  buttonType: ButtonType.secondary,
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
              SizedBox(
                height: 72.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
