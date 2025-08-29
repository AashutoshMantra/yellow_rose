import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';
import 'package:yellow_rose/core/common_widgets/ImageIcon.dart';
import 'package:yellow_rose/core/common_widgets/base_appbar.dart';
import 'package:yellow_rose/core/common_widgets/button.dart';
import 'package:yellow_rose/core/common_widgets/date_picker.dart';
import 'package:yellow_rose/core/constants/supported_service.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/utils/WidgetUtils.dart';
import 'package:yellow_rose/core/utils/date_utils.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/features/flight/domain/entities/flight_recent_search.dart';
import 'package:yellow_rose/features/flight/presentation/cubit/flight_search_cubit.dart';
import 'package:yellow_rose/core/common_widgets/labeled_info_widget.dart';
import 'package:yellow_rose/features/flight/presentation/pages/airport_search_screen.dart';
import 'package:yellow_rose/features/flight/presentation/pages/flight_search_list.dart';
import 'package:yellow_rose/features/flight/presentation/pages/traveller_class_selection_screen.dart';
import 'package:yellow_rose/features/flight/presentation/widgets/flight_search_widget.dart';
import 'package:yellow_rose/features/home_screen/presentation/widgets/recent/show_recent_searches_widget.dart';
import 'package:yellow_rose/features/hotel/domain/entities/hotel_search.dart';
import 'package:yellow_rose/features/hotel/presentation/pages/hotel_search_list_scree.dart';
import 'package:yellow_rose/features/hotel/presentation/widgets/search/hotel_search_widget.dart';

class HotelSearchScreen extends StatelessWidget {
  static const String routeName = "/HotelSearchScreen";
  final HotelSearch? hotelSeatch;

  const HotelSearchScreen({super.key, this.hotelSeatch});

  @override
  Widget build(BuildContext context) {
    var airSearchListner = ValueNotifier<HotelSearch?>(hotelSeatch);
    return Scaffold(
      appBar: BaseAppBar(
        title: "Hotels",
        subTitle: "",
        shouldHaveRadius: false,
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: 150.h,
                  decoration: const BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(8),
                          bottomLeft: Radius.circular(8))),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 24.w, vertical: 15.h),
                  child: ValueListenableBuilder<HotelSearch?>(
                      valueListenable: airSearchListner,
                      builder: (context, value, _) {
                        return HotelSearchWidget(
                          initialData: value,
                          key: UniqueKey(),
                          onSearchClick: (HotelSearch search) {
                            Navigator.of(context).pushNamed(
                                HotelSearchListScreen.routeName,
                                arguments: {'hotelSearch': search});
                          },
                        );
                      }),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 24.h),
                  child: ShowRecentSearchesWidget(
                    supportedService: const [SupportedService.Hotels],
                    onClick: (data) {
                      var search = data as HotelSearch;
                      airSearchListner.value = search;
                    },
                  ),
                ),
                SizedBox(
                  height: 40.h,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
