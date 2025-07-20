import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yellow_rose/app_routes.dart';
import 'package:yellow_rose/core/constants/supported_service.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/features/flight/domain/entities/flight_recent_search.dart';
import 'package:yellow_rose/features/flight/presentation/pages/flight_search_screen.dart';
import 'package:yellow_rose/features/home_screen/presentation/cubit/home_screen_cubit.dart';
import 'package:yellow_rose/features/home_screen/presentation/widgets/recent/flight_recent_search.dart';

class ShowRecentSearchesWidget extends StatelessWidget {
  final List<SupportedService>? supportedService;
  final Function(dynamic)? onClick;
  const ShowRecentSearchesWidget({
    super.key,
    this.supportedService,
    this.onClick,
  });

  Widget getRecentSearchWidget(BuildContext context, dynamic data) {
    return GestureDetector(
      onTap: () {
        if (onClick != null) {
          onClick!(data);
          return;
        }
        if (data is AirSearch) {
          Navigator.of(context).pushNamed(FlightSearchScreen.routeName,
              arguments: {'airSearch': data});
        }
      },
      child: Builder(builder: (ctx) {
        if (data is AirSearch) {
          return FlightRecentSearchCard(recentSearch: data);
        }
        return const SizedBox();
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenCubit, HomeScreenState>(
      builder: (context, state) {
        var airRecentSearch = [];
        if (state is HomeScreenLoaded) {
          airRecentSearch = context
              .read<HomeScreenCubit>()
              .getRecentSearchesData(supportedService: supportedService);
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (airRecentSearch.isNotEmpty)
              Text(
                "Recent Searches",
                style: TextStyles.bodyMediumBoldStyle(),
              ),
            if (airRecentSearch.isNotEmpty)
              SizedBox(
                height: 16.h,
              ),
            SizedBox(
              height: 150.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: airRecentSearch.length,
                itemBuilder: (ctx, idx) {
                  var recentSearch = airRecentSearch[idx];
                  return getRecentSearchWidget(context, recentSearch);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    width: 16.w,
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
