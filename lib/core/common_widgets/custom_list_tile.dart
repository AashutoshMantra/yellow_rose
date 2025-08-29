import 'package:flutter/material.dart';
import 'package:yellow_rose/core/utils/size_config.dart';

class CustomListTile extends StatelessWidget {
  final Widget title;
  final Widget? subtitle;
  final Widget? trailing;
  const CustomListTile({
    super.key,
    required this.title,
    this.subtitle,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [title, if (subtitle != null) subtitle!],
          ),
        ),
        const Spacer(),
        SizedBox(
          width: 40.h,
        ),
        if (trailing != null) Flexible(child: trailing!)
      ],
    );
  }
}
