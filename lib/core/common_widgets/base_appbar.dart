import 'package:flutter/material.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/size_config.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? subTitle;
  List<Widget>? actionsCustom;
  PreferredSizeWidget? bottom;
  final double? height;
  final TextStyle? titleStyle;
  final bool shouldHaveRadius;
  final Function()? onAppBarClick;
  BaseAppBar(
      {super.key,
      required this.title,
      this.subTitle,
      this.actionsCustom,
      this.bottom,
      this.height,
      this.titleStyle,  this.shouldHaveRadius=true, this.onAppBarClick});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius:   BorderRadius.only(
        bottomLeft:Radius.circular(shouldHaveRadius?12:0),
        bottomRight: Radius.circular(shouldHaveRadius?12:0),
      ),
      child: AppBar(
          toolbarHeight: (height ?? 80.h),
          title: GestureDetector(
            behavior:HitTestBehavior.opaque ,
            onTap: onAppBarClick,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    title,
                    style: titleStyle,
                  ),
                  if (subTitle != null)
                    SizedBox(
                      height: 4.h,
                    ),
                  if (subTitle != null)
                    Text(
                      subTitle!,
                      maxLines: 3,
                      style: TextStyles.bodyMediumStyle()
                          .copyWith(color: Colors.white),
                    ),
                ],
              ),
            ),
          ),
          leading: Builder(
            builder: (BuildContext context) {
              final ModalRoute<Object?>? parentRoute = ModalRoute.of(context);
              final bool canPop = parentRoute?.canPop ?? false;

              if (canPop) {
                return const BackButton();
              } else {
                return const SizedBox();
              }
            },
          ),
          leadingWidth: ModalRoute.of(context)?.canPop ==true ?null:0,
          bottom: bottom,
          elevation: 0,
          actions: actionsCustom),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height ?? 100.h);
}
