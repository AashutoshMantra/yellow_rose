import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yellow_rose/core/common_widgets/base_appbar.dart';
import 'package:yellow_rose/core/common_widgets/bottom_button.dart';
import 'package:yellow_rose/core/common_widgets/loader.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/WidgetUtils.dart';
import 'package:yellow_rose/core/utils/date_utils.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/features/bus/domain/entities/bus_search.dart';
import 'package:yellow_rose/features/bus/presentation/cubit/bus_search_filter/bus_search_filter_cubit.dart';
import 'package:yellow_rose/features/bus/presentation/cubit/bus_search_listing/bus_search_listing_cubit.dart';
import 'package:yellow_rose/features/bus/presentation/pages/bus_search_filter_screen.dart';
import 'package:yellow_rose/features/bus/presentation/widgets/bus_search_result_card.dart';
import 'package:yellow_rose/features/bus/presentation/widgets/bus_search_widget.dart';
import 'package:yellow_rose/features/bus/presentation/pages/bus_detail/bus_detail_screen.dart';

String getBusDetailTitle(BusSearch busSearch) {
  return "${busSearch.source?.cityName} → ${busSearch.destination?.cityName}";
}

class BusSearchListScreen extends StatelessWidget {
  static const String routeName = "/busSearchListScreen";

  const BusSearchListScreen({super.key});

  void onAppBarClick(BuildContext context) {
    WidgetUtil.showBottomSheet(
      context,
      BusSearchWidget(
        initialData: context.read<BusSearchListingCubit>().state.busSearch,
        onSearchClick: (search) {
          Navigator.of(context).pop();
          context.read<BusSearchListingCubit>().searchBuses(search);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.h),
        child: BlocBuilder<BusSearchListingCubit, BusSearchListingState>(
          builder: (context, state) {
            return BaseAppBar(
              title: getBusDetailTitle(state.busSearch!),
              onAppBarClick: () => onAppBarClick(context),
              shouldHaveRadius: false,
              actionsCustom: [
                Container(
                  margin: EdgeInsets.only(right: 8.w),
                  child: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => onAppBarClick(context),
                  ),
                )
              ],
            );
          },
        ),
      ),
      floatingActionButton:
          BlocBuilder<BusSearchListingCubit, BusSearchListingState>(
        builder: (context, state) {
          if (state is BusSearchListingLoaded &&
              state.busSearchResponse.isNotEmpty) {
            return FloatingActionButton(
              onPressed: () async {
                final cubit = context.read<BusSearchListingCubit>();

                // Get unique pickup and drop points from search results
                final pickupPoints = state.busSearchResponse
                    .expand((bus) => bus.boardingPoint ?? [])
                    .map((point) => point.location ?? '')
                    .where((location) => location.isNotEmpty)
                    .toSet()
                    .toList();

                final dropPoints = state.busSearchResponse
                    .expand((bus) => bus.droppingPoint ?? [])
                    .map((point) => point.location ?? '')
                    .where((location) => location.isNotEmpty)
                    .toSet()
                    .toList();

                final result = await WidgetUtil.showBottomSheet(
                  context,
                  BusSearchFilterScreen(
                    filterState: state.filterState,
                    pickupPoints: pickupPoints.cast<String>(),
                    dropPoints: dropPoints.cast<String>(),
                    operatorDetails: state.busSearchResponse
                        .map((bus) => bus.operatorDetails)
                        .nonNulls
                        .toSet()
                        .toList(),
                  ),
                );

                if (result != null && result is BusSearchFilterState) {
                  cubit.onApplyFilters(result);
                }
              },
              child: const Icon(Icons.filter_alt_outlined),
            );
          }
          return const SizedBox();
        },
      ),
      bottomNavigationBar:
          BlocBuilder<BusSearchListingCubit, BusSearchListingState>(
        builder: (context, state) {
          if (state is BusSearchListingLoaded && state.selectedBus != null) {
            return SizedBox(
              height: 95.h,
              child: BottomButton(
                buttonText: "Book Now",
                title:
                    "₹ ${context.read<BusSearchListingCubit>().getSelectedBusPrice().toStringAsFixed(0)}",
                subtitle: "TOTAL COST",
                onClick: () {
                  // TODO: Navigate to booking screen
                  log("Navigate to bus booking screen");
                },
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
      body: BlocListener<BusSearchListingCubit, BusSearchListingState>(
        listener: (context, state) {
          if (state is BusSearchListingError) {
            Navigator.of(context).pop();
            WidgetUtil.showSnackBar("Error, please try again", context);
          }
        },
        child: BlocBuilder<BusSearchListingCubit, BusSearchListingState>(
          builder: (context, state) {
            if (state is BusSearchListingLoaded) {
              final filteredBuses =
                  context.read<BusSearchListingCubit>().getFilteredBuses();

              if (filteredBuses.isEmpty) {
                return Center(
                  child: Text(
                    "No Buses Found",
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
                  Container(
                    child: ListView.separated(
                      padding: EdgeInsets.all(16.w),
                      itemCount: filteredBuses.length,
                      itemBuilder: (ctx, idx) {
                        final bus = filteredBuses[idx];
                        final isSelected = state.selectedBus?.id == bus.id;

                        return BusSearchResultCard(
                          busSearchResponse: bus,
                          isSelected: isSelected,
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              BusDetailScreen.routeName,
                              arguments: {
                                'busSearchResponse': bus,
                                'busSearch': context
                                    .read<BusSearchListingCubit>()
                                    .state
                                    .busSearch,
                              },
                            );
                          },
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(height: 12.h);
                      },
                    ),
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
