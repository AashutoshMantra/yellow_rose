import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:yellow_rose/app_routes.dart';
import 'package:yellow_rose/core/common_widgets/popup.dart';
import 'package:yellow_rose/features/auth/domain/entities/trip_type.dart';
import 'package:yellow_rose/features/flight/presentation/pages/order_status_screen.dart';
import 'package:yellow_rose/features/home_screen/presentation/pages/dashboard.dart';
import 'package:yellow_rose/features/home_screen/presentation/widgets/show_update_available_body.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/features/trip/presentation/cubit/trip_cubit.dart';
import 'package:yellow_rose/features/trip/presentation/pages/trip_detail_screen.dart';

class WidgetUtil {
  static Future<T?> showDialog<T>(
    BuildContext context,
    Widget body, {
    double width = double.maxFinite,
    double? height,
    bool barrierDismissible = true,
    Color barrierColor = const Color(0x80000000),
  }) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierLabel: '',
      barrierColor: barrierColor,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (context, animation1, animation2) {
        // pageBuilder must return a widget but the actual dialog is built in transitionBuilder
        return const SizedBox.shrink();
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final curved = Curves.easeInOut.transform(animation.value);
        return Transform.scale(
          scale: curved,
          child: Opacity(
            opacity: animation.value,
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
        );
      },
      useRootNavigator: false,
    );
  }

  static void showUpdateBottomSheet(BuildContext context,
      {bool shouldForceUpdate = false, String? description}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: !shouldForceUpdate,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10.0))),
      builder: (context) {
        return ShowUpdateAvailableBody(
          forceUpdate: shouldForceUpdate,
          description: description,
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

    return WidgetUtil.showDialog<T>(
      context,
      popup,
      width: width,
      height: height,
    );
  }

  static void returnToHomeScreen(
      BuildContext context, OrderStatusEnum orderStatus, TripType tripType) {
    final targetRoute = tripType != TripType.NoTrip
        ? formatScreenName((TripDetailScreen).toString())
        : formatScreenName((Dashboard).toString());
    context.read<TripCubit>().refereshSelectedTrip();

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (ctx) => OrderStatusScreen(
          orderStatus: orderStatus,
          tripType: tripType,
        ),
      ),
      (route) {
        final shouldKeep = route.settings.name == targetRoute;
        return shouldKeep;
      },
    );
  }
}
