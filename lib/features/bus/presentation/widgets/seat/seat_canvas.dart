import 'package:flutter/material.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/features/bus/data/models/bus_details/bus_seats.dart';
import 'seat_layout_engine.dart';
import 'seat_widget.dart';

class SeatCanvas extends StatelessWidget {
  final List<BusSeats> seats; // list of project BusSeats
  final double minCellSize;
  final double maxCellSize;

  /// If true, render the seat map using a transposed (vertical) layout by
  /// swapping rows and columns coming from the data.
  final bool vertical;
  final Set<String> selectedSeats;
  final void Function(String seatId) onToggleSeat;
  final bool isLowerDeck; // true for lower deck, false for upper

  const SeatCanvas({
    super.key,
    required this.seats,
    this.minCellSize = 20,
    this.maxCellSize = 55,
    this.vertical = true,
    required this.selectedSeats,
    required this.onToggleSeat,
    required this.isLowerDeck,
  });

  @override
  Widget build(BuildContext context) {
    final layout = SeatLayoutEngine.computeLayout(seats, transpose: vertical);

    return LayoutBuilder(builder: (context, constraints) {
      final cols = layout.cols > 0 ? layout.cols : 1;
      final rows = layout.rows > 0 ? layout.rows : 1;
      // compute cellSize based on columns in the final layout
      final cellSize =
          (constraints.maxWidth / cols).clamp(minCellSize, maxCellSize);
      final canvasW = (cols * cellSize).clamp(100.w, double.infinity);
      final canvasH = rows * cellSize;

      // Deck header
      final deckHeader = Container(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
        width: canvasW,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              isLowerDeck ? 'Lower Deck' : 'Upper Deck',
              style: TextStyles.bodyMediumBoldStyle(),
            ),
            if (isLowerDeck) ...[
              ImageIcon(
                const AssetImage("assets/images/bus_seats/wheel.png"),
                color: Colors.blueGrey,
                size: 25.h,
              ),
            ],
          ],
        ),
      );

      return Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.02),
          borderRadius: BorderRadius.circular(8.h),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            deckHeader,
            Container(
              // boundary box for the seat map

              padding: EdgeInsets.all(4.h),
              child: SizedBox(
                width: canvasW,
                height: canvasH,
                child: Stack(
                  children: [
                    // placements
                    for (final p in layout.placements)
                      Positioned(
                        left: p.col * cellSize,
                        top: p.row * cellSize,
                        width: p.spanCols * cellSize,
                        height: p.spanRows * cellSize,
                        child: SeatWidget(
                          seat: p.seat,
                          width: p.spanCols * cellSize,
                          height: p.spanRows * cellSize,
                          selected: selectedSeats.contains(
                              ((p.seat.name ?? p.seat.berth ?? '')).toString()),
                          onTap: onToggleSeat,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
