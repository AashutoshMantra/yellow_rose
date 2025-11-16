import 'package:flutter/material.dart';
import 'package:yellow_rose/core/utils/extensions.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/features/bus/data/models/bus_details/bus_seats.dart';
import 'seat_canvas.dart';
import 'legends_widget.dart';
import 'seat_layout_engine.dart';

class SeatSelectionWidget extends StatefulWidget {
  final List<BusSeats> allSeats;
  final Set<String> selectedSeats;
  final Function(String) onToggleSeat;

  const SeatSelectionWidget({
    super.key,
    required this.allSeats,
    required this.selectedSeats,
    required this.onToggleSeat,
  });

  @override
  State<SeatSelectionWidget> createState() => _SeatSelectionWidgetState();
}

class _SeatSelectionWidgetState extends State<SeatSelectionWidget> {
  // Filter seats for upper and lower decks
  // Assuming lower deck has row < 5, upper >=5, or adjust as needed
  List<BusSeats> get lowerDeckSeats => widget.allSeats
      .where((s) => s.berth?.equalsIgnoreCase("lower") ?? false)
      .toList();
  List<BusSeats> get upperDeckSeats => widget.allSeats
      .where((s) => s.berth?.equalsIgnoreCase("upper") ?? false)
      .toList();

  // Calculate the maximum height needed for consistent deck heights
  double _calculateMaxDeckHeight() {
    double maxHeight = 0;

    if (lowerDeckSeats.isNotEmpty) {
      final lowerLayout =
          SeatLayoutEngine.computeLayout(lowerDeckSeats, transpose: true);
      final lowerRows = lowerLayout.rows > 0 ? lowerLayout.rows : 1;
      final lowerHeight =
          lowerRows * 60.h + 80.h; // seat height + header/padding
      maxHeight = maxHeight > lowerHeight ? maxHeight : lowerHeight;
    }

    if (upperDeckSeats.isNotEmpty) {
      final upperLayout =
          SeatLayoutEngine.computeLayout(upperDeckSeats, transpose: true);
      final upperRows = upperLayout.rows > 0 ? upperLayout.rows : 1;
      final upperHeight =
          upperRows * 60.h + 80.h; // seat height + header/padding
      maxHeight = maxHeight > upperHeight ? maxHeight : upperHeight;
    }

    return maxHeight > 300.h ? maxHeight : 300.h; // minimum height
  }

  @override
  Widget build(BuildContext context) {
    final maxDeckHeight = _calculateMaxDeckHeight();

    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            // Horizontally scrollable row for upper and lower decks
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Lower Deck
                  if (lowerDeckSeats.isNotEmpty)
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 12.w, vertical: 20.h),
                      child: SizedBox(
                        height: maxDeckHeight,
                        child: SeatCanvas(
                          maxCellSize: 60.h,
                          minCellSize: 30.h,
                          seats: lowerDeckSeats,
                          selectedSeats: widget.selectedSeats,
                          onToggleSeat: widget.onToggleSeat,
                          isLowerDeck: true,
                        ),
                      ),
                    ),
                  if (upperDeckSeats.isNotEmpty)
                    // Upper Deck
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 12.w, vertical: 20.h),
                      child: SizedBox(
                        height: maxDeckHeight,
                        child: SeatCanvas(
                          maxCellSize: 60.h,
                          minCellSize: 30.h,
                          seats: upperDeckSeats,
                          selectedSeats: widget.selectedSeats,
                          onToggleSeat: widget.onToggleSeat,
                          isLowerDeck: false,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            // Legends below
            const LegendsWidget(),
          ],
        ),
      ),
    );
  }
}
