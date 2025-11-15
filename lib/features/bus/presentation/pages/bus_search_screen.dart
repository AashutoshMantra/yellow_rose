import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yellow_rose/core/common_widgets/base_appbar.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/features/bus/domain/entities/bus_search.dart';
import 'package:yellow_rose/features/bus/presentation/cubit/search/bus_search_cubit.dart';
import 'package:yellow_rose/features/bus/presentation/pages/bus_search_list_screen.dart';
import 'package:yellow_rose/features/bus/presentation/widgets/bus_search_widget.dart';
import 'package:yellow_rose/features/home_screen/presentation/widgets/recent/show_recent_searches_widget.dart';
import 'package:yellow_rose/core/constants/supported_service.dart';

class BusSearchScreen extends StatelessWidget {
  static const String routeName = "/busSearchScreen";
  final BusSearch? busSearch;

  const BusSearchScreen({super.key, this.busSearch});

  @override
  Widget build(BuildContext context) {
    var busSearchListner = ValueNotifier<BusSearch?>(busSearch);
    return BlocProvider(
      create: (context) => BusSearchCubit()..loadInitial(busSearch: busSearch),
      child: Scaffold(
        appBar: BaseAppBar(
          title: "Book Bus Ticket",
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
                    child: ValueListenableBuilder<BusSearch?>(
                        valueListenable: busSearchListner,
                        builder: (context, value, _) {
                          if (value != null) {
                            context
                                .read<BusSearchCubit>()
                                .updateFromBusSearch(value);
                          }
                          return BusSearchWidget(
                            initialData: value,
                            key: UniqueKey(),
                            onSearchClick: (BusSearch search) {
                              Navigator.of(context).pushNamed(
                                  BusSearchListScreen.routeName,
                                  arguments: {'busSearch': search});
                            },
                          );
                        }),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 24.w),
                    child: ShowRecentSearchesWidget(
                      supportedService: const [SupportedService.Buses],
                      onClick: (data) {
                        var search = data as BusSearch;
                        busSearchListner.value = search;
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
      ),
    );
  }
}
