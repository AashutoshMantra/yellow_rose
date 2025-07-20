import 'package:flutter/material.dart';
import 'package:yellow_rose/core/common_widgets/button.dart';
import 'package:yellow_rose/core/common_widgets/image_icon_button.dart';
import 'package:yellow_rose/core/constants/supported_service.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/features/flight/presentation/pages/flight_search_screen.dart';
import 'package:yellow_rose/features/home_screen/presentation/widgets/recent/show_recent_searches_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: SupportedService.values.map((supportedService) {
                return ImageIconButton(
                  onClick: () {
                    if (supportedService == SupportedService.Flights) {
                      Navigator.of(context)
                          .pushNamed(FlightSearchScreen.routeName);
                    }
                  },
                  image: AssetImage(
                      "assets/images/icons/${supportedService.getImagePath()}.png"),
                  title: supportedService.name,
                );
              }).toList(),
            ),
            SizedBox(
              height: 24.h,
            ),
            CustomButton(
              text: "Book new ticket",
              onPressed: () {},
            ),
            SizedBox(
              height: 24.h,
            ),
            const ShowRecentSearchesWidget()
          ],
        ),
      ),
    );
  }
}
