import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yellow_rose/core/common_widgets/base_appbar.dart';
import 'package:yellow_rose/core/common_widgets/loader.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/WidgetUtils.dart';
import 'package:yellow_rose/core/utils/date_utils.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/features/hotel/domain/entities/hotel_search.dart';
import 'package:yellow_rose/features/hotel/presentation/cubit/hotel_search_listing_cubit/hotel_search_listing_cubit.dart';
import 'package:yellow_rose/features/hotel/presentation/pages/hotel_detail_screen.dart';
import 'package:yellow_rose/features/hotel/presentation/widgets/search/hotel_search_detail_widget.dart';
import 'package:yellow_rose/features/hotel/presentation/widgets/search/hotel_search_widget.dart';

String getTravellerDetailsAndDate(HotelSearch hotelSearch) {
  String checkInDate =
      CustomDateUtils.givenFormat(hotelSearch.checkInDate!, "d MMM");
  if (hotelSearch.checkOutDate != null) {
    checkInDate =
        "$checkInDate - ${CustomDateUtils.givenFormat(hotelSearch.checkOutDate!, "dMMM")}";
  }
  checkInDate += " | ${hotelSearch.roomCount} Rooms";
  checkInDate += " | ${hotelSearch.adultCount} Adult";
  if (hotelSearch.childAges != null && hotelSearch.childAges!.isNotEmpty) {
    checkInDate += " | ${hotelSearch.childAges!.length} Child";
  }
  return checkInDate;
}

class HotelSearchListScreen extends StatelessWidget {
  static const String routeName = "/hotelSearchListScreen";

  const HotelSearchListScreen({super.key});
  void onAppBarClick(BuildContext context) {
    WidgetUtil.showBottomSheet(
        context,
        HotelSearchWidget(
          initialData:
              context.read<HotelSearchListingCubit>().state.hotelSearch,
          onSearchClick: (search) {
            Navigator.of(context).pop();
            context.read<HotelSearchListingCubit>().searchHotels(search);
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.h),
        child: BlocBuilder<HotelSearchListingCubit, HotelSearchListingState>(
          builder: (context, state) {
            return BaseAppBar(
              title: state.hotelSearch?.place?.city ?? "Hotel Search",
              onAppBarClick: () => onAppBarClick(context),
              subTitle: getTravellerDetailsAndDate(state.hotelSearch!),
              shouldHaveRadius: false,
              actionsCustom: [
                Container(
                    margin: EdgeInsets.only(right: 8.w),
                    child: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => onAppBarClick(context),
                    ))
              ],
            );
          },
        ),
      ),
      body: BlocListener<HotelSearchListingCubit, HotelSearchListingState>(
        listener: (context, state) {
          if (state is HotelSearchListinError) {
            Navigator.of(context).pop();
            WidgetUtil.showSnackBar("Error, please try again", context);
          }
        },
        child: BlocBuilder<HotelSearchListingCubit, HotelSearchListingState>(
          builder: (context, state) {
            if (state is HotelSearchListingLoaded) {
              if (state.hotelSearchResponse.hotels.isEmpty) {
                return Center(
                  child: Text(
                    "No Hotel Found",
                    style: TextStyles.bodyLargeBoldStyle(),
                  ),
                );
              }
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
                  ListView.builder(
                    itemCount: state.hotelSearchResponse.hotels.length,
                    itemBuilder: (context, index) {
                      final hotel = state.hotelSearchResponse.hotels[index];
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(10.h),
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 8.h),
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                HotelDetailScreen.routeName,
                                arguments: {
                                  "hotelSearch": state.hotelSearch,
                                  "hotelSearchResponse": hotel,
                                },
                              );
                            },
                            child: HotelSearchDetailWidget(
                              hotelSearchResponse: hotel,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              );
            }
            return const Loader();
          },
        ),
      ),
    );
  }
}
