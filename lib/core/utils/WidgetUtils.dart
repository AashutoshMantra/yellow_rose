import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:yellow_rose/core/common_widgets/date_picker.dart';
import 'package:yellow_rose/core/common_widgets/popup.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/utils/size_config.dart';

class WidgetUtil {
  static Future<T?> showDialog<T>(BuildContext context, Widget body,
      {double width = double.maxFinite, double? height,
    bool barrierDismissible = true,
    Color barrierColor = const Color(0x80000000),
  }) {
    return showGeneralDialog(
      transitionDuration: const Duration(milliseconds: 200),
      barrierDismissible: barrierDismissible,
      barrierLabel: '',
      barrierColor: barrierColor,
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
      {bool isDismissible = true,
      double radius = 24,
      double? maxHeight}) async {
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
          child: Container(
            constraints:
                maxHeight != null ? BoxConstraints(maxHeight: maxHeight) : null,
            child: Wrap(
              children: [
                body,
              ],
            ),
          ),
        );
      },
    );
  }

  static Future<T?> showWrapContentBottomSheet<T>({
    required BuildContext context,
    required Widget child,
    double maxHeightFraction = 0.8,
    bool isDismissible = true,
    double borderRadius = 24,
    Color backgroundColor = Colors.white,
  }) {
    final maxHeight = MediaQuery.of(context).size.height * maxHeightFraction;

    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      isDismissible: isDismissible,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return ConstrainedBox(
                constraints: BoxConstraints(maxHeight: maxHeight),
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(borderRadius)),
                  child: Material(
                    color: backgroundColor,
                    child: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      child: child,
                    ),
                  ),
                ),
              );
            },
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

  static Future<T?> showPopup<T>(
    BuildContext context, {
    Widget? icon,
    String? title,
    String? message,
    Widget? content,
    List<PopupButton>? buttons,
    bool barrierDismissible = true,
    double width = double.maxFinite,
    double? height,
    double borderRadius = 15.0,
    Color backgroundColor = Colors.white,
    TextStyle? titleTextStyle,
    TextStyle? messageTextStyle,
    bool showCloseIcon = true,
  }) {
    final popup = PopupDialog(
      leading: icon,
      title: title,
      message: message,
      content: content,
      buttons: buttons ?? const [],
      showCloseIcon: showCloseIcon,
      borderRadius: borderRadius,
      backgroundColor: backgroundColor,
      titleTextStyle: titleTextStyle,
      messageTextStyle: messageTextStyle,
    );

    return showDialog<T>(
      context,
      popup,
      width: width,
      height: height,
    );
  }
}
