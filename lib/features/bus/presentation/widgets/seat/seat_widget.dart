import 'package:flutter/material.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/features/bus/data/models/bus_details/bus_seats.dart';
import 'chair_seat_widget.dart';
import 'sleeper_seat_widget.dart';

typedef SeatTapCallback = void Function(String seatId);

class SeatWidget extends StatelessWidget {
  final BusSeats seat; // project BusSeats instance
  final double width;
  final double height;
  final bool selected;
  final SeatTapCallback? onTap;

  const SeatWidget({
    super.key,
    required this.seat,
    required this.width,
    required this.height,
    this.selected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final seatNumber = ((seat.name ?? seat.berth ?? '')).toString();
    final available = (seat.available ?? true);

    // Make the tappable visual a bit smaller than the full cell so the label
    // below has room and the map looks less cramped on small screens.
    final visualHeight = (height * 0.7).clamp(28.0, height);
    final visualWidth = (width * 0.7).clamp(28.0, width);

    return Semantics(
      label: 'Seat $seatNumber',
      selected: selected,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: visualWidth,
            height: visualHeight,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: available ? () => onTap?.call(seatNumber) : null,
              child: seat.isSeat
                  ? ChairSeatWidget(
                      seat: seat,
                      selected: selected,
                    )
                  : SleeperSeatWidget(
                      seat: seat,
                      selected: selected,
                    ),
            ),
          ),
          // compact label / price beneath the seat visual. Use FittedBox so it
          // scales down on narrow screens.
          SizedBox(
            width: width,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                available ? (seat.fare != null ? '₹${seat.fare}' : '') : 'Sold',
                overflow: TextOverflow.ellipsis,
                style: TextStyles.bodySmallSemiBoldStyle()
                    .copyWith(color: available ? Colors.black87 : Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
