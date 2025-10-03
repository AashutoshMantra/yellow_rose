import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_upgrade_version/flutter_upgrade_version.dart';
import 'package:yellow_rose/core/common_widgets/button.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/core/utils/WidgetUtils.dart';
import 'package:yellow_rose/features/home_screen/presentation/cubit/app_update/app_update_cubit.dart';

class ShowUpdateAvailableBody extends StatefulWidget {
  final bool forceUpdate;
  final String? description;
  const ShowUpdateAvailableBody(
      {super.key, required this.forceUpdate, this.description});

  @override
  State<ShowUpdateAvailableBody> createState() =>
      _ShowUpdateAvailableBodyState();
}

class _ShowUpdateAvailableBodyState extends State<ShowUpdateAvailableBody> {
  bool _processing = false;

  Future<void> _onUpdateNow() async {
    // Capture a navigator reference synchronously
    final navigator = Navigator.of(context);
    // Close sheet first
    navigator.pop();

    setState(() {
      _processing = true;
    });

    try {
      final appUpdateState = context.read<AppUpdateCubit>().state;

      if (Platform.isAndroid && appUpdateState is AppUpdateAvailable) {
        final manager = appUpdateState.manager ?? InAppUpdateManager();
        final check = await manager.checkForUpdate();
        if (check?.immediateAllowed == true) {
          await manager.startAnUpdate(type: AppUpdateType.immediate);
        } else if (check?.flexibleAllowed == true) {
          await manager.startAnUpdate(type: AppUpdateType.flexible);
        } else {
          if (!mounted) return;
          WidgetUtil.showSnackBar('Please update from Play Store.', context);
        }
      } else {
        if (!mounted) return;
        WidgetUtil.showSnackBar(
            'Please update the app from the store.', context);
      }
    } catch (e) {
      if (mounted) {
        WidgetUtil.showSnackBar('Failed to start update.', context);
      }
    } finally {
      if (mounted) {
        setState(() {
          _processing = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.h),
      decoration: const BoxDecoration(color: AppColors.primary),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Update Available',
            style: TextStyle(
                color: Colors.white,
                fontSize: 18.h,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 8.h),
          Text(
            widget.forceUpdate
                ? 'To continue using this app you need to download the latest version.'
                : "There's a new update available. Update to access the latest features and fixes.",
            style: TextStyle(color: Colors.white70, fontSize: 14.h),
          ),
          if (widget.forceUpdate && widget.description?.isNotEmpty == true) ...[
            SizedBox(height: 12.h),
            Text('What’s new',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.h,
                    fontWeight: FontWeight.w600)),
            SizedBox(height: 8.h),
            Text(widget.description ?? '',
                style: TextStyle(color: Colors.white70, fontSize: 14.h)),
          ],
          SizedBox(height: 16.h),
          Row(
            children: [
              if (!widget.forceUpdate)
                Expanded(
                  child: CustomButton(
                    text: 'Update Later',
                    buttonType: ButtonType.secondary,
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
              if (!widget.forceUpdate) SizedBox(width: 12.w),
              Expanded(
                child: CustomButton(
                  text: _processing ? 'Please wait...' : 'Update Now',
                  onPressed: _processing ? null : _onUpdateNow,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
