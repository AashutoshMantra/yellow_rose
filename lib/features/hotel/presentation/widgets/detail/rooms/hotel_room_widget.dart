import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:yellow_rose/core/common_widgets/image_carousel.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/extensions.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/features/hotel/domain/entities/rooms/hotel_room.dart';
import 'package:yellow_rose/features/hotel/domain/entities/rooms/hotel_room_type.dart';
import 'package:yellow_rose/features/hotel/domain/usecases/hotel_mapper_utiity.dart';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HotelRoomWidget extends StatefulWidget {
  final HotelRoom room;
  final Function(HotelRoom room) onRoomSelect;

  const HotelRoomWidget(
      {super.key, required this.room, required this.onRoomSelect});

  @override
  State<HotelRoomWidget> createState() => _HotelRoomWidgetState();
}

class _HotelRoomWidgetState extends State<HotelRoomWidget>
    with SingleTickerProviderStateMixin {
  bool expanded = false;

  void onSelectRoom(HotelRoomType hotelRoomType) {
    var filteredRoom = widget.room.hotelRooms
        .firstWhere((room) => room.id.equalsIgnoreCase(hotelRoomType.id));
    var hotelRoom = widget.room.copyWith(hotelRooms: [filteredRoom]);
    widget.onRoomSelect(hotelRoom);
  }

  @override
  Widget build(BuildContext context) {
    final hotelRoom = widget.room;

    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.h),
          border: Border.all(color: AppColors.primaryTextSwatch[400]!),
          color: AppColors.primaryTextSwatch[50]),
      child: Padding(
        padding: EdgeInsets.all(12.0.h),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0.h),
                  child:
                      Text(hotelRoom.name ?? '', style: TextStyles.h6Style()),
                ),

                // Image + Bed Info Row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CachedNetworkImage(
                            imageUrl: hotelRoom.images!.firstOrNull ?? '',
                            height: 120.h,
                            width: 180.w,
                            fit: BoxFit.cover,
                            placeholder: (_, __) => Container(
                              height: 120.h,
                              width: 120.w,
                              color: Colors.white.withAlpha(1),
                            ),
                            errorWidget: (_, __, ___) => SizedBox(
                              height: 120.h,
                              width: 120.w,
                            ),
                          ),
                        ),
                        if ((hotelRoom.images?.length ?? 0) > 1)
                          Positioned(
                            bottom: 4.h,
                            right: 4.w,
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(12.h),
                                  bottomRight: Radius.circular(12.h),
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    FullScreenImageCarousel.show(
                                      context,
                                      imageUrls: hotelRoom.images!
                                          .map(HotelMapperUtiity.getImageUrl)
                                          .nonNulls
                                          .toList(),
                                      initialIndex: 0,
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(1.5.h),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10.h),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10.h),
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          SizedBox(
                                            width: 45.h,
                                            height: 45.h,
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  HotelMapperUtiity.getImageUrl(
                                                        hotelRoom.images
                                                            ?.elementAtOrNull(
                                                                1),
                                                      ) ??
                                                      "",
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) =>
                                                  const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const SizedBox(),
                                            ),
                                          ),
                                          BackdropFilter(
                                            filter: ImageFilter.blur(
                                                sigmaX: 1, sigmaY: 1),
                                            child: SizedBox(
                                              width: 45.h,
                                              height: 45.h,
                                            ),
                                          ),
                                          Text(
                                            "+ ${hotelRoom.images?.length ?? 0 - 1}",
                                            style: TextStyles
                                                    .bodyLargeMediumStyle()
                                                .copyWith(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                      ],
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(Icons.bed),
                              SizedBox(
                                width: 5.w,
                              ),
                              Flexible(child: Text(hotelRoom.bedType ?? "N/A")),
                            ],
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(Icons.square_foot_outlined),
                              SizedBox(
                                width: 5.w,
                              ),
                              Text(" ${hotelRoom.bedSize ?? "N/A"} sq.ft"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Room Types
                ..._buildRoomTypeWidgets(),
              ],
            ),
            Positioned(
              bottom: -30.h,
              left: 0,
              right: 0,
              child: InkWell(
                onTap: () {
                  setState(() => expanded = !expanded);
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    color: Colors.white,
                    expanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    size: 28,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildRoomTypeWidgets() {
    final allRoomTypes = widget.room.hotelRooms;
    final visibleRoomTypes = expanded ? allRoomTypes : [allRoomTypes.first];

    return [
      AnimatedSize(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        child: Column(
          children: List.generate(
            visibleRoomTypes.length,
            (index) => _buildSingleRoomType(visibleRoomTypes[index]),
          ),
        ),
      ),
    ];
  }

  Widget _buildSingleRoomType(HotelRoomType roomType) {
    final amenities = roomType.hotelRoomAmenities ?? [];

    final List<Widget> amenityWidgets = amenities
        .take(3)
        .map((e) => Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("• "),
                Expanded(
                    child: Text(
                  e.name,
                  style: TextStyles.bodyMediumStyle(),
                )),
              ],
            ))
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(
          height: 24,
          color: AppColors.primaryTextSwatch[400],
        ),
        Text(roomType.name ?? "Room", style: TextStyles.h6Style()),
        const SizedBox(height: 6),
        ...amenityWidgets,
        if (amenities.length > 3 ||
            ((roomType.hotelRoomPenalty?.length ?? 0) > 0))
          TextButton(
            onPressed: () {
              // Optional: Show more amenities in dialog
            },
            child: const Text("More Detail"),
          ),
        SizedBox(height: 8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "₹${roomType.totalcost.toStringAsFixed(2)}",
              style: TextStyles.bodyXLargeBoldStyle(),
            ),
            ElevatedButton(
              onPressed: () => {onSelectRoom(roomType)},
              child: Text(
                "Select Room",
                style: TextStyles.bodySmallBoldStyle()
                    .copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
