import 'package:flutter/material.dart';
import 'package:yellow_rose/core/common_widgets/ImageIcon.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/size_config.dart';

class ImageIconButton extends StatelessWidget {
  final ImageProvider<Object> image;
  final double size;
  final double radius;
  final Color? color;
  final String title;
  final Color? backgroundColor;
  final Function()? onClick;

  const ImageIconButton(
      {super.key,
      required this.image,
      required this.title,
      this.onClick,
      this.size = 20,
      this.radius = 25,
      this.color,
      this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    final isEnabled = onClick != null;

    return GestureDetector(
      onTap: onClick,
      child: Container(
        child: Opacity(
          opacity: isEnabled ? 1.0 : 0.5,
          child: Column(children: [
            CustomImageIcon(
              image: image,
              radius: radius,
              size: size,
              color: color,
              backgroundColor: backgroundColor,
            ),
            SizedBox(
              height: 4.h,
            ),
            Text(title, style: TextStyles.bodySmallStyle())
          ]),
        ),
      ),
    );
  }
}
