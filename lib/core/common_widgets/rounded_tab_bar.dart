import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/size_config.dart';

enum RoundedTabBarType { primary, secondary }

class RoundedTabBars extends StatelessWidget {
  final Function(int) onTap;
  final List<Widget>? children;
  final List<Widget>? tabChildrens;
  final double? borderRadius;
  final bool isScrollable;
  final double? tabBarHeight;
  final TabController? tabController;
  final RoundedTabBarType type;
  final TextStyle? textStyle;
  const RoundedTabBars(
      {super.key,
      required this.onTap,
      this.children,
      this.isScrollable = false,
      this.tabBarHeight,
      this.tabController,
      this.tabChildrens,
      this.borderRadius,
      this.type = RoundedTabBarType.primary,
      this.textStyle});

  @override
  Widget build(BuildContext context) {
    return TabBar(
        isScrollable: isScrollable,
        controller: tabController,
        onTap: (index) {
          onTap(index);
        },
        unselectedLabelColor:
            type == RoundedTabBarType.primary ? Colors.white : null,
        indicatorSize: TabBarIndicatorSize.tab,
        tabAlignment: isScrollable ? TabAlignment.start : null,
        labelPadding: EdgeInsets.zero,
        labelStyle: textStyle ?? TextStyles.bodySmallStyle().copyWith(),
        labelColor:
            type == RoundedTabBarType.primary ? AppColors.primary : null,
        indicatorPadding: EdgeInsets.symmetric(horizontal: 5.w),
        dividerColor: Colors.transparent,
        indicator: BoxDecoration(
            border: Border.all(
                color: type == RoundedTabBarType.primary
                    ? Colors.white
                    : Colors.transparent),
            borderRadius: BorderRadius.circular(borderRadius ?? 32.h),
            color: type == RoundedTabBarType.primary
                ? Colors.white
                : AppColors.primarySwatch[200]),
        tabs: tabChildrens ??
            [
              ...children!.mapIndexed((idx, child) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  height: tabBarHeight,
                  child: Tab(
                    child: Container(
                        // height: double.infinity,
                        width: isScrollable ? null : double.infinity,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(borderRadius ?? 32.h),
                            border: Border.all(
                                color: type == RoundedTabBarType.primary
                                    ? Colors.white
                                    : AppColors.primarySwatch[300]!,
                                width: 1)),
                        child: child),
                  ),
                );
              }),
            ]);
  }
}
