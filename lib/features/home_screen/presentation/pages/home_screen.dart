import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yellow_rose/core/common_widgets/button.dart';
import 'package:yellow_rose/core/common_widgets/image_icon_button.dart';
import 'package:yellow_rose/core/constants/supported_service.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/utils/WidgetUtils.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/features/bus/presentation/pages/bus_search_screen.dart';
import 'package:yellow_rose/features/flight/presentation/pages/flight_search_screen.dart';
import 'package:yellow_rose/features/home_screen/presentation/cubit/app_update/app_update_cubit.dart';
import 'package:yellow_rose/features/home_screen/presentation/widgets/recent/show_recent_searches_widget.dart';
import 'package:yellow_rose/features/hotel/presentation/pages/hotel_search_screen.dart';

void navigateToService(BuildContext context, SupportedService service) {
  switch (service) {
    case SupportedService.Flights:
      Navigator.of(context).pushNamed(FlightSearchScreen.routeName);
      break;
    case SupportedService.Hotels:
      Navigator.of(context).pushNamed(HotelSearchScreen.routeName);
      break;
    case SupportedService.Buses:
      Navigator.of(context).pushNamed(BusSearchScreen.routeName);
      break;
    case SupportedService.Cabs:
      WidgetUtil.showSnackBar("Cab booking coming soon!", context,
          col: AppColors.primaryGreen);
      break;
    case SupportedService.Insurance:
      WidgetUtil.showSnackBar("Insurance booking coming soon!", context,
          col: AppColors.primaryGreen);
      break;
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    final cubit = context.read<AppUpdateCubit>();
    cubit.stream.listen(onAppUpdateChange);
  }

  void onAppUpdateChange(AppUpdateState appUpdateState) async {
    if (appUpdateState is AppUpdateAvailable) {
      final cubit = context.read<AppUpdateCubit>();
      final shouldSHowPromt = await cubit.shouldShowUpdatePrompt();
      debugPrint("Should show prompt $shouldSHowPromt");
      if (!shouldSHowPromt) {
        return;
      }
      if (!mounted) return;
      cubit.setLastPromptInfo();
      WidgetUtil.showUpdateBottomSheet(context,
          shouldForceUpdate: appUpdateState.forceUpdate);
    }
    debugPrint("State AppUpdate ${appUpdateState.runtimeType.toString()}");
  }

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
                    navigateToService(context, supportedService);
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
