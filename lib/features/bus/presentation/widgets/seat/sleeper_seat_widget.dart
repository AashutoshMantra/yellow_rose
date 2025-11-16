import 'package:flutter/material.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/features/bus/data/models/bus_details/bus_seats.dart';

class SleeperSeatWidget extends StatelessWidget {
  final BusSeats seat;
  final bool selected;

  const SleeperSeatWidget({
    super.key,
    required this.seat,
    required this.selected,
  });

  bool get isVertical {
    final w = seat.width ?? 0;
    final h = seat.length ?? 0;
    return h > w;
  }

  @override
  Widget build(BuildContext context) {
    final available = seat.available ?? true;
    final isFemale = seat.ladiesSeat ?? false;
    final isMale = seat.malesSeat ?? false;

    const femaleColor = Color(0xFFD81B60);
    const maleColor = AppColors.primary;
    const green = AppColors.primaryGreen;

    // -------------------------------------------------------
    // COLOR LOGIC
    // -------------------------------------------------------
    Color borderColor;
    Color containerFillColor;
    Color pillowColor;
    Color iconColor;
    borderColor = green;
    if (isMale) {
      borderColor = maleColor;
    } else if (isFemale) {
      borderColor = femaleColor;
    }

    if (available) {
      if (selected) {
        containerFillColor = green.withOpacity(0.35);
        pillowColor = green.withOpacity(0.55); // slightly bolder for pillow
        iconColor = green;
      } else {
        containerFillColor = Colors.transparent;
        pillowColor = Colors.white.withOpacity(0.85);
        iconColor =
            isFemale ? femaleColor : (isMale ? maleColor : Colors.black87);
      }
    } else {
      borderColor = green.withOpacity(0.4);
      containerFillColor = Colors.grey.shade300;
      pillowColor = Colors.grey.shade200.withOpacity(0.7);
      iconColor = isFemale
          ? femaleColor.withOpacity(0.5)
          : (isMale ? maleColor.withOpacity(0.5) : Colors.grey.shade600);
    }

    // -------------------------------------------------------
    // PILLOW WIDGET
    // -------------------------------------------------------
    Widget pillow = Container(
      width: isVertical ? double.infinity : 12.w,
      height: isVertical ? 12.h : double.infinity,
      margin: EdgeInsets.all(6.h),
      decoration: BoxDecoration(
        color: pillowColor,
        borderRadius: BorderRadius.circular(6.h),
        border: Border.all(
          color: borderColor,
          width: 1.2,
        ),
      ),
    );

    // -------------------------------------------------------
    // INTERNAL LAYOUT (WITHOUT STACK)
    // -------------------------------------------------------
    Widget content = isVertical
        ? Column(
            children: [
              pillow,
              const Expanded(child: SizedBox()),
            ],
          )
        : Row(
            children: [
              pillow,
              const Expanded(child: SizedBox()),
            ],
          );

    // -------------------------------------------------------
    // MAIN COMPONENT
    // -------------------------------------------------------
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 6.h),
      child: SizedBox(
        width: isVertical ? 52.w : 95.w,
        height: isVertical ? 95.h : 40.h,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Outer container BECOMES the background color
            Container(
              decoration: BoxDecoration(
                color: containerFillColor, // NOW whole box changes color
                borderRadius: BorderRadius.circular(8.h),
                border: Border.all(
                  color: borderColor,
                  width: 2,
                ),
              ),
              child: content,
            ),

            // Gender icon
            if (isFemale || isMale)
              Icon(
                isFemale ? Icons.woman : Icons.man,
                size: 22.h,
                color: iconColor,
              ),

            // Unavailable overlay
            if (!available)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.65),
                    borderRadius: BorderRadius.circular(8.h),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.block,
                      size: 18.h,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
