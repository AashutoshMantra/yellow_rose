import 'package:flutter/material.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/features/hotel/domain/entities/rooms/hotel_rrom_cancellation.dart';

class HotelPenaltyTable extends StatelessWidget {
  final List<HotelRoomPenalty> penalties;

  const HotelPenaltyTable({super.key, required this.penalties});

  @override
  Widget build(BuildContext context) {
    if (penalties.isEmpty) {
      return const Text("No cancellation policy available.");
    }

    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      child: Table(
        border: TableBorder.symmetric(
          inside: BorderSide(color: Colors.grey.shade300, width: 0.5),
        ),
        columnWidths: const {
          0: FlexColumnWidth(1.5),
          1: FlexColumnWidth(2),
          2: FlexColumnWidth(2),
          3: FlexColumnWidth(2),
        },
        children: [
          // Header row with distinct background
          TableRow(
            decoration: BoxDecoration(color: AppColors.primarySwatch[100]),
            children: [
              _headerCell("Begin"),
              _headerCell("Cancellation On/Before"),
              _headerCell("Cancellation After"),
              _headerCell("Charges/Comment"),
            ],
          ),

          // Data rows
          ...List.generate(penalties.length, (index) {
            final p = penalties[index];
            return TableRow(
              decoration: BoxDecoration(
                color: index.isEven ? Colors.white : Colors.grey.shade50,
              ),
              children: [
                _dataCell(p.startDate ?? "-"),
                _dataCell(p.startDate ?? "-"),
                _dataCell(p.endDate ?? "-"),
                _dataCell(p.value ?? "-"),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _headerCell(String text) {
    // header cells rely on the TableRow decoration for background color
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
      child: Text(
        text,
        style: TextStyles.bodySmallSemiBoldStyle(),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _dataCell(String text) {
    // data cells rely on the TableRow decoration for background color
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyles.bodySmallStyle(),
      ),
    );
  }
}
