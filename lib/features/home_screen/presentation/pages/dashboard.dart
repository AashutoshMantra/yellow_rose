import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yellow_rose/core/common_widgets/base_appbar.dart';
import 'package:yellow_rose/core/common_widgets/button.dart';
import 'package:yellow_rose/core/common_widgets/image_icon_button.dart';
import 'package:yellow_rose/core/constants/supported_service.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:yellow_rose/features/flight/data/models/airports.dart';
import 'package:yellow_rose/features/flight/domain/entities/flight_recent_search.dart';
import 'package:yellow_rose/features/flight/domain/entities/name_code.dart';
import 'package:yellow_rose/features/flight/domain/entities/source_date_pair.dart';
import 'package:yellow_rose/features/flight/presentation/pages/flight_search_screen.dart';
import 'package:yellow_rose/features/home_screen/presentation/cubit/home_screen_cubit.dart';
import 'package:yellow_rose/features/home_screen/presentation/pages/order_list_screen.dart';
import 'package:yellow_rose/features/home_screen/presentation/pages/home_screen.dart';
import 'package:yellow_rose/features/home_screen/presentation/pages/profile_screen.dart';
import 'package:yellow_rose/features/home_screen/presentation/widgets/bottom_navigation_bar.dart';
import 'package:yellow_rose/features/home_screen/presentation/widgets/recent/flight_recent_search.dart';
import 'package:yellow_rose/features/home_screen/presentation/widgets/recent/show_recent_searches_widget.dart';
import 'package:yellow_rose/features/trip/presentation/pages/trip_home_screen.dart';

class Dashboard extends StatefulWidget {
  static const String routeName = "/homeScreen";

  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    context.read<HomeScreenCubit>().loadRecentSearch();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  bool heart = false;
  final controller = PageController();

  bool get _shouldShowTripAsHome {
    final authCubit = context.read<AuthCubit>();
    return authCubit.shouldShowTripAsHome();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenCubit, HomeScreenState>(
      builder: (context, state) {
        var castedState = state;
        return Scaffold(
            appBar: BaseAppBar(
              title: castedState.selectedPage == 0
                  ? (_shouldShowTripAsHome ? "My Trips" : "Where to go?")
                  : castedState.selectedPage == 1
                      ? "My Bookings"
                      : "Profile",
              subTitle: "",
              titleStyle: TextStyles.bodyXLargeBoldStyle()
                  .copyWith(color: Colors.white),
              height: 90.h,
              shouldHaveRadius:
                  castedState.selectedPage == 0 && !_shouldShowTripAsHome,
            ),
            bottomNavigationBar: CustomBottomNavigationBar(
                selected: castedState.selectedPage,
                hideBookings: _shouldShowTripAsHome,
                onClick: (value) {
                  if (value == castedState.selectedPage) return;
                  controller.animateToPage(value,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut);
                  context.read<HomeScreenCubit>().setSelectedPage(value);
                }),
            body: PageView(
              controller: controller,
              physics: const NeverScrollableScrollPhysics(),
              children: _shouldShowTripAsHome
                  ? [
                      const TripHomeScreen(),
                      const ProfileScreen(),
                    ]
                  : [
                      const HomeScreen(),
                      const OrderListScreen(),
                      const ProfileScreen(),
                    ],
            ));
      },
    );
  }
}
