import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/features/bus/data/models/bus_details/bus_seats.dart';

class MySeatColorMapper extends ColorMapper {
  const MySeatColorMapper({
    required this.fillColor,
    required this.strokeColor,
  });

  final Color fillColor;
  final Color strokeColor;

  @override
  Color substitute(
    String? id,
    String elementName,
    String attributeName,
    Color color,
  ) {
    if (attributeName == 'fill') {
      return fillColor;
    }
    if (attributeName == 'stroke') {
      return strokeColor;
    }
    return color;
  }
}

class ChairSeatWidget extends StatelessWidget {
  final BusSeats seat;
  final bool selected;

  const ChairSeatWidget({
    super.key,
    required this.seat,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    final seatNumber = ((seat.name ?? seat.berth ?? '')).toString();
    final available = (seat.available ?? true);
    final isFemale = (seat.ladiesSeat ?? false);
    final isMale = (seat.malesSeat ?? false);

    // decide colors according to new rules:
    // - If seat is available: stroke is always green (selected or not).
    // - Icon color reflects gender (male: primary blue, female: pink). If selected, icon becomes green.
    // - If unavailable: colors remain the same hues but are dimmed; fill becomes grey and seat shows overlay.
    Color strokeColor;
    Color fillColor;
    Color iconColor;

    const Color femaleColor = Color(0xFFD81B60);
    const Color maleColor = AppColors.primary;
    const Color green = AppColors.primaryGreen;

    strokeColor = green;
    if (isMale) {
      strokeColor = maleColor;
    } else if (isFemale) {
      strokeColor = femaleColor;
    }

    if (available) {
      if (selected) {
        // selected: green stroke and green icon + green translucent fill
        iconColor = green;
        fillColor = AppColors.primaryGreen.withOpacity(0.6);
      } else {
        // not selected: icon shows gender color if present, otherwise neutral
        iconColor =
            isFemale ? femaleColor : (isMale ? maleColor : Colors.black87);
        // no fill (transparent) when not selected
        fillColor = Colors.transparent;
      }
    } else {
      // unavailable: keep hues but dim them; fill with grey and show overlay
      strokeColor = green.withOpacity(0.45); // dimmed green stroke
      iconColor = isFemale
          ? femaleColor.withOpacity(0.5)
          : (isMale ? maleColor.withOpacity(0.5) : Colors.grey.shade600);
      fillColor = Colors.grey.shade300;
    }

    // No outer container decoration — SVG handles stroke/fill.
    return Padding(
      padding: EdgeInsets.all(4.h),
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            SvgPicture.asset(
              'assets/images/bus_seats/chair.svg',
              colorMapper: MySeatColorMapper(
                fillColor: fillColor,
                strokeColor: strokeColor,
              ),
            ),

            // Always show male/female icon if seat is gendered
            if (isFemale || isMale)
              Icon(
                isFemale ? Icons.woman : Icons.man,
                size: 20.h,
                color: iconColor,
              ),

            // unavailable overlay
            if (!available)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(6),
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
