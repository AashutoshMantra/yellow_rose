import 'package:flutter/material.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/features/bus/data/models/bus_details/bus_seats.dart';
import 'chair_seat_widget.dart';
import 'sleeper_seat_widget.dart';

class LegendsWidget extends StatelessWidget {
  const LegendsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data for each legend type
    final mockSeats = {
      'Available': BusSeats(
        name: '1',
        row: 0,
        column: 0,
        length: 1,
        width: 1,
        fare: 500,
        available: true,
        ladiesSeat: false,
        malesSeat: false,
      ),
      'Selected': BusSeats(
        name: '2',
        row: 0,
        column: 0,
        length: 1,
        width: 1,
        fare: 500,
        available: true,
        ladiesSeat: false,
        malesSeat: false,
      ),
      'Male Only': BusSeats(
        name: '3',
        row: 0,
        column: 0,
        length: 1,
        width: 1,
        fare: 500,
        available: true,
        ladiesSeat: false,
        malesSeat: true,
      ),
      'Female Only': BusSeats(
        name: '4',
        row: 0,
        column: 0,
        length: 1,
        width: 1,
        fare: 500,
        available: true,
        ladiesSeat: true,
        malesSeat: false,
      ),
      'Not Available': BusSeats(
        name: '5',
        row: 0,
        column: 0,
        length: 1,
        width: 1,
        fare: 500,
        available: false,
        ladiesSeat: false,
        malesSeat: false,
      ),
    };

    final mockSleepers = {
      'Available': BusSeats(
        name: 'A1',
        row: 0,
        column: 0,
        length: 2,
        width: 1,
        fare: 800,
        available: true,
        ladiesSeat: false,
        malesSeat: false,
      ),
      'Selected': BusSeats(
        name: 'A2',
        row: 0,
        column: 0,
        length: 2,
        width: 1,
        fare: 800,
        available: true,
        ladiesSeat: false,
        malesSeat: false,
      ),
      'Male Only': BusSeats(
        name: 'A3',
        row: 0,
        column: 0,
        length: 2,
        width: 1,
        fare: 800,
        available: true,
        ladiesSeat: false,
        malesSeat: true,
      ),
      'Female Only': BusSeats(
        name: 'A4',
        row: 0,
        column: 0,
        length: 2,
        width: 1,
        fare: 800,
        available: true,
        ladiesSeat: true,
        malesSeat: false,
      ),
      'Not Available': BusSeats(
        name: 'A5',
        row: 0,
        column: 0,
        length: 2,
        width: 1,
        fare: 800,
        available: false,
        ladiesSeat: false,
        malesSeat: false,
      ),
    };

    return Padding(
      padding: EdgeInsets.all(16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Know Your Seat Types',
            style: TextStyles.h6Style(),
          ),
          SizedBox(height: 8.h),
          Table(
            border: TableBorder.all(color: Colors.grey.shade300),
            columnWidths: const {
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(1),
              2: FlexColumnWidth(1),
            },
            children: [
              // Header
              TableRow(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.h),
                    child: Text(
                      'Type',
                      style: TextStyles.bodyMediumBoldStyle(),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.h),
                    child: Text(
                      'Seat',
                      style: TextStyles.bodyMediumBoldStyle(),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.h),
                    child: Text(
                      'Sleeper',
                      style: TextStyles.bodyMediumBoldStyle(),
                    ),
                  ),
                ],
              ),
              // Rows
              for (final type in [
                'Available',
                'Selected',
                'Male Only',
                'Female Only',
                'Not Available'
              ])
                TableRow(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.h),
                      child: Text(type),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.h),
                      child: SizedBox(
                        width: 60.w,
                        height: 60.h,
                        child: ChairSeatWidget(
                          seat: mockSeats[type]!,
                          selected: type == 'Selected',
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.h),
                      child: SizedBox(
                        width: 60.w,
                        height: 100.h,
                        child: SleeperSeatWidget(
                          seat: mockSleepers[type]!,
                          selected: type == 'Selected',
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }
}
