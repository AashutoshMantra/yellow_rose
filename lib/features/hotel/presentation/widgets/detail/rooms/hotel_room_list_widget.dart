import 'package:flutter/material.dart';

import 'package:yellow_rose/core/common_widgets/bottom_sheet_title_widget.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/features/hotel/domain/entities/rooms/hotel_room.dart';
import 'package:yellow_rose/features/hotel/presentation/widgets/detail/rooms/hotel_room_widget.dart';

class HotelRoomListWidget extends StatelessWidget {
  final List<HotelRoom> hotelRooms;
  final Function(HotelRoom room) onRoomSelect;
  const HotelRoomListWidget({
    super.key,
    required this.hotelRooms,
    required this.onRoomSelect,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.85,
      child: Column(
        children: [
          const BottomSheetTitleWidget(
            title: "Suggested Room",
          ),
          Expanded(
            child: ListView.builder(
              itemCount: hotelRooms.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                    child: HotelRoomWidget(
                        room: hotelRooms[index], onRoomSelect: onRoomSelect));
              },
            ),
          )
        ],
      ),
    );
  }
}
