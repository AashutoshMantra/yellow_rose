import 'package:flutter/material.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';

class CustomImageIcon extends StatelessWidget {
  final ImageProvider<Object> image;
  final double size;
  final double radius;
  final Color? color;
  final Color? backgroundColor;
  const CustomImageIcon(
      {super.key,
      required this.image,
      this.size = 20,
      this.backgroundColor,
      this.radius = 20,
      this.color});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor:backgroundColor?? AppColors.primarySwatch[50],
      child: Image(
        image: image,
        color: color,
        width: size,
        height: size,
        fit: BoxFit.scaleDown,
        alignment: Alignment.center,
      ),
    );
  }
}
