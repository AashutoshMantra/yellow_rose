import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/size_config.dart';

class BottomSheetTitleWidget extends StatelessWidget {
  final String title;
  final Function? onCloseClick;
  const BottomSheetTitleWidget(
      {super.key, required this.title, this.onCloseClick});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.h),
      child: Stack(
        children: [
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyles.bodyXLargeMediumStyle(),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8.h,
              ),
              Divider(
                height: 0,
                color: AppColors.primaryTextSwatch[200],
              )
            ],
          ),
          Positioned(
            right: 0,
            top: -10,
            child: IconButton(
                onPressed: () {
                  if (onCloseClick != null) {
                    onCloseClick!();
                  } else {
                    Navigator.of(context).pop();
                  }
                },
                icon: const Icon(Icons.close)),
          ),
        ],
      ),
    );
  }
}
