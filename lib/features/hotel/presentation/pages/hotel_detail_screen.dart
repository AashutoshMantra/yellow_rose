import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yellow_rose/core/common_widgets/base_appbar.dart';
import 'package:yellow_rose/core/common_widgets/loader.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/utils/WidgetUtils.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/features/flight/presentation/widgets/bottom_button.dart';
import 'package:yellow_rose/features/hotel/data/models/details/hotel_detail_resonse.dart';
import 'package:yellow_rose/features/hotel/data/models/search/hotel_search_response.dart';
import 'package:yellow_rose/features/hotel/domain/entities/hotel_search.dart';
import 'package:yellow_rose/features/hotel/presentation/cubit/hotel_detail_cubit/hotel_detail_cubit_cubit.dart';
import 'package:yellow_rose/features/hotel/presentation/pages/hotel_book_form_screen.dart';
import 'package:yellow_rose/features/hotel/presentation/widgets/detail/hotel_amenity_preview.dart';
import 'package:yellow_rose/features/hotel/presentation/widgets/detail/hotel_detail_image_widget.dart';
import 'package:yellow_rose/features/hotel/presentation/widgets/detail/hotel_detail_summary_widget.dart';
import 'package:yellow_rose/features/hotel/presentation/widgets/detail/hotel_high_list_section.dart';
import 'package:yellow_rose/features/hotel/presentation/widgets/detail/mmt_hotel_policy.dart';
import 'package:yellow_rose/features/hotel/presentation/widgets/detail/rooms/hotel_room_list_widget.dart';
import 'package:yellow_rose/features/hotel/presentation/widgets/detail/rooms/hotel_room_widget.dart';

double? getRoomPrice() {
  return null;
}

class HotelDetailScreen extends StatelessWidget {
  static const String routeName = "/hotelDetailScreen";
  final HotelSearchResponse hotelSearchResponse;
  final HotelSearch hotelSearch;
  const HotelDetailScreen({
    super.key,
    required this.hotelSearchResponse,
    required this.hotelSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: hotelSearchResponse.name ?? "Hotel Details",
        subTitle: "",
        shouldHaveRadius: false,
        height: 75.h,
      ),
      body: BlocListener<HotelDetailCubitCubit, HotelDetailCubitState>(
        listener: (context, state) {
          if (state is HotelDetailCubitError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage)),
            );
            Navigator.of(context).pop();
          }
        },
        child: BlocBuilder<HotelDetailCubitCubit, HotelDetailCubitState>(
            builder: (context, state) {
          if (state is HotelDetailCubitLoaded) {
            return Stack(
              children: [
                Column(
                  children: [
                    Container(
                      height: 160.h,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
                SingleChildScrollView(
                  child: SizedBox(
                    width: double.infinity,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          HotelDetailImageWidget(
                            hotelSearchResponse: hotelSearchResponse,
                          ),
                          SizedBox(height: 16.h),
                          HotelDetailSummaryWidget(
                            hotelSearch: hotelSearch,
                            hotelDetailResponse: state.hotelDetailResponse,
                            hotelSearchResponse: hotelSearchResponse,
                          ),
                          SizedBox(height: 16.h),
                          if ((state.hotelDetailResponse.hotel?.mmtAmenities
                                      ?.length ??
                                  0) >
                              0)
                            HotelAmenitySection(
                              amenities: state.hotelDetailResponse.hotel
                                      ?.mmtAmenities ??
                                  [],
                              groupByName: true,
                            ),
                          if ((state.hotelDetailResponse.hotel?.expediaAmenities
                                      ?.length ??
                                  0) >
                              0)
                            HotelAmenitySection(
                              amenities: state.hotelDetailResponse.hotel
                                      ?.expediaAmenities ??
                                  [],
                              groupByName: false,
                            ),
                          if (state.hotelDetailResponse.hotel
                                  ?.checkInInstruction !=
                              null)
                            Container(
                              margin: EdgeInsets.only(top: 16.h),
                              child: PropertyHighlightsSection(
                                  title: "Check In Instruction",
                                  htmlContent: state.hotelDetailResponse.hotel!
                                      .checkInInstruction!),
                            ),
                          if (state.hotelDetailResponse.hotel?.description !=
                              null)
                            Container(
                              margin: EdgeInsets.only(top: 16.h),
                              child: PropertyHighlightsSection(
                                  title: "Property Highlights",
                                  htmlContent: state
                                      .hotelDetailResponse.hotel!.description!),
                            ),
                          if (state.hotelDetailResponse.hotel?.expediaPolicies
                                  ?.knowBeforeYouGo !=
                              null)
                            Container(
                              margin: EdgeInsets.only(top: 16.h),
                              child: PropertyHighlightsSection(
                                  title: "Policy",
                                  htmlContent: state.hotelDetailResponse.hotel!
                                      .expediaPolicies!.knowBeforeYouGo!),
                            ),
                          if (state.hotelDetailResponse.hotel?.mmtPolicies
                                  ?.isNotEmpty ==
                              true)
                            Container(
                              margin: EdgeInsets.only(top: 16.h),
                              child: MmtHotelPolicy(
                                  policies: state
                                      .hotelDetailResponse.hotel!.mmtPolicies!),
                            ),
                          SizedBox(height: 120.h),
                        ],
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: double.infinity,
                    height: 95.h,
                    child: BottomButton(
                        title:
                            "₹ ${state.rooms.first.hotelRooms.first.totalcost}",
                        onClick: () {
                          WidgetUtil.showBottomSheet(
                              context,
                              HotelRoomListWidget(
                                hotelRooms: state.rooms,
                                onRoomSelect: (hotelRoom) {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pushNamed(
                                      HotelBookFormScreen.routeName,
                                      arguments: {
                                        "hotelSearch": hotelSearch,
                                        "hotelDetail":
                                            state.hotelDetailResponse,
                                        "selectedRoom": hotelRoom
                                      });
                                },
                              ));
                        },
                        buttonText: "Select Room"),
                  ),
                )
              ],
            );
          }
          return const Loader();
        }),
      ),
    );
  }
}
