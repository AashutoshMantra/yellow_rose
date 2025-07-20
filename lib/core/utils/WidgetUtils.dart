import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:yellow_rose/core/common_widgets/date_picker.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/utils/size_config.dart';

class WidgetUtil {
  static Future<dynamic> showDialog(BuildContext context, Widget body,
      {double width = double.maxFinite, double? height}) {
    return showGeneralDialog(
      transitionDuration: const Duration(milliseconds: 200),
      barrierDismissible: true,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, animation1, animation2) {
        return Container();
      },
      useRootNavigator: false,
      transitionBuilder: (context, a1, a2, widget) {
        final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: Container(
              child: AlertDialog(
                insetPadding: const EdgeInsets.all(10),
                contentPadding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0.h),
                ),
                content: SizedBox(
                  height: height,
                  width: width,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [body],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static Future showBottomSheet(BuildContext context, Widget body,
      {bool isDismissible = true, double radius = 24}) async {
    return await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: isDismissible,
      backgroundColor: Colors.white,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(radius),
        ),
      ),
      builder: (context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Wrap(
            children: [
              body,
            ],
          ),
        );
      },
    );
  }

  static showSnackBar(String message, BuildContext context,
      {Color col = AppColors.error,
      int milliseconds = 2000,
      bool persist = false}) {
    showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.info(
          message: message,
          icon: Container(),
          backgroundColor: col,
        ),
        persistent: persist,
        displayDuration: Duration(milliseconds: milliseconds));
  }
}
