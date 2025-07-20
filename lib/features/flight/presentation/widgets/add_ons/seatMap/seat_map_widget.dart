import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/features/flight/data/models/seat_map/air_seat.dart';
import 'package:yellow_rose/features/flight/data/models/seat_map/seat_occupancy.dart';
import 'package:yellow_rose/features/flight/data/models/seat_map/seat_row.dart';
import 'package:yellow_rose/features/flight/domain/entities/seat_map/selected_seat.dart';

class SeatMapWidget extends StatefulWidget {
  final List<SeatRow> seatRows;
  final List<SelectedSeat> selectedSeat;
  final Function(SelectedSeat) onSeatSelect;

  const SeatMapWidget(
      {super.key,
      required this.seatRows,
      required this.selectedSeat,
      required this.onSeatSelect});

  @override
  State<SeatMapWidget> createState() => _SeatMapWidgetState();
}

class _SeatMapWidgetState extends State<SeatMapWidget> {
  List<List<dynamic>> getGridLayoutUi() {
    late List<List<dynamic>> layout;
    Set<String> columnSet = {};
    for (var row in widget.seatRows) {
      for (var seat in row.airSeats) {
        columnSet.add(seat.column);
      }
    }
    List<String> sortedColumns = columnSet.toList()..sort();
    Set<String> aisleColumns = {};
    for (var row in widget.seatRows) {
      for (var seat in row.airSeats) {
        if (seat.seatCharacteristics
                ?.contains(SeatCharacteristics.AISLE_SEAT) ==
            true) {
          aisleColumns.add(seat.column);
        }
      }
    }

    var rowsLength = widget.seatRows.length + 1;
    int columnLength = sortedColumns.length +
        (aisleColumns.length * 1.0 / 2.0).ceil().toInt() +
        1;
    layout = List<List>.generate(
        rowsLength,
        (i) => List<dynamic>.generate(columnLength, (index) => null,
            growable: false),
        growable: false);
    layout[0][0] = "";
    for (int i = 1; i < layout.length; i++) {
      layout[i][0] = "$i";
    }
    for (int i = 1, k = 0; i < layout[0].length; i++) {
      layout[0][i] = sortedColumns[k];
      if (aisleColumns.contains(sortedColumns[k]) &&
          (k + 1 < sortedColumns.length &&
              aisleColumns.contains(sortedColumns[k + 1]))) {
        i++;
      }
      k++;
    }
    for (int i = 1; i < layout.length; i++) {
      String rowNumber = widget.seatRows[i - 1].row;
      for (int j = 1; j < layout[0].length; j++) {
        String? column = layout[0][j];
        if (column != null) {
          var seat = widget.seatRows[i - 1].airSeats.firstWhere(
              (seat) => seat.column == column,
              orElse: () => AirSeat(
                  baseFare: 0,
                  finalTax: 0,
                  column: column,
                  seatOccupancy: SeatOccupancy.Blocked));
          layout[i][j] = SelectedSeat(row: rowNumber, seat: seat);
        }
      }
    }
    // log(jsonEncode(layout));
    return layout;
  }

  late List<List<dynamic>> seatLayout;
  @override
  void initState() {
    super.initState();
    seatLayout = getGridLayoutUi();
  }

  bool isSeatSelected(String row, AirSeat seat) {
    return widget.selectedSeat.firstWhereOrNull((selectedSeat) =>
            selectedSeat.row == row &&
            seat.column == selectedSeat.seat.column) !=
        null;
  }

  Color getSeatColor(String row, AirSeat seat) {
    if (seat.isRestricted) {
      return AppColors.primaryTextSwatch[300]!;
    }
    if (isSeatSelected(row, seat)) {
      return AppColors.primary;
    }

    if (seat.seatCharacteristics
            ?.contains(SeatCharacteristics.CHARGEABLE_SEAT) ==
        true) {
      return AppColors.primarySuccessSwatch[400]!;
    }
    if (seat.seatCharacteristics?.isNotEmpty == true) {
      return AppColors.primaryGreen;
    }

    return AppColors.primaryTextSwatch[300]!;
  }

  @override
  Widget build(BuildContext context) {
    var columnCount = seatLayout[0].length;

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: seatLayout[0].length,
        childAspectRatio: 1, //
      ),
      itemCount: seatLayout.length * columnCount,
      itemBuilder: (context, index) {
        int row = index ~/ columnCount;
        int col = index % columnCount;

        dynamic seat = seatLayout[row][col];

        if (seat == null) {
          return Container();
        }
        if (col == 0 || row == 0) {
          return Container(
            margin: const EdgeInsets.all(2),
            child: Center(
              child: Text(
                (seat as String),
                style: TextStyles.bodyMediumMediumStyle().copyWith(
                  color: AppColors.primaryTextSwatch[500],
                ),
              ),
            ),
          ); // Aisle space
        }

        return Tooltip(
          message:
              "₹ ${(seat as SelectedSeat).seat.totalCost.toStringAsFixed(1)}",
          triggerMode: TooltipTriggerMode.tap,
          verticalOffset: -57.h,
          onTriggered: () {
            if (!(seat).isRestricted) {
              widget.onSeatSelect(seat);
            }
          },
          textStyle: const TextStyle(color: Colors.white),
          child: Container(
            margin: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: getSeatColor(seat.row, seat.seat),
              borderRadius: BorderRadius.circular(5),
            ),
            alignment: Alignment.center,
            child: isSeatSelected(seat.row, seat.seat)
                ? const Icon(
                    Icons.check,
                    color: Colors.white,
                  )
                : null,
          ),
        );
      },
    );
  }
}
