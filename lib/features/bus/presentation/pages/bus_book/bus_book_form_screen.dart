import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yellow_rose/core/common_widgets/base_appbar.dart';
import 'package:yellow_rose/core/common_widgets/loader.dart';
import 'package:yellow_rose/core/common_widgets/labelled_drop_dowdn.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/utils/WidgetUtils.dart';
import 'package:yellow_rose/core/utils/extensions.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:yellow_rose/features/bus/data/models/search/bus_search_response.dart';
import 'package:yellow_rose/core/common_widgets/passenger_detail/traveller_details_widget.dart';
import 'package:yellow_rose/features/bus/presentation/cubit/bus_book/bus_book_cubit.dart';
import 'package:yellow_rose/features/bus/presentation/pages/bus_book/bus_booking_review_screen.dart';
import 'package:yellow_rose/features/flight/presentation/widgets/bottom_button.dart';

class BusBookFormScreen extends StatelessWidget {
  final BusSearchResponse busSearchResponse;
  static const routeName = "/busBookFormScreen";

  const BusBookFormScreen({super.key, required this.busSearchResponse});

  @override
  Widget build(BuildContext context) {
    final loader = ValueNotifier(false);

    return ValueListenableBuilder(
      valueListenable: loader,
      builder: (context, loading, child) {
        return Stack(
          children: [
            Scaffold(
              appBar: BaseAppBar(
                title: 'Bus Booking',
                subTitle:
                    '${busSearchResponse.source} to ${busSearchResponse.destination}',
                shouldHaveRadius: false,
              ),
              bottomNavigationBar: BlocBuilder<BusBookCubit, BusBookState>(
                builder: (context, state) {
                  if (state is BusBookLoaded) {
                    return SizedBox(
                      height: 95.h,
                      width: double.infinity,
                      child: BottomButton(
                        buttonText: "Book",
                        title:
                            "₹ ${(state.busDetailResponse.fare.isNotEmpty ? state.busDetailResponse.fare[0].totalFare ?? 0 : 0) * state.selectedSeats.length}",
                        subtitle: "Total Cost",
                        onClick: () async {
                          if (state.billingEntity == null) {
                            WidgetUtil.showSnackBar(
                                "Please select billing entity", context);
                            return;
                          }
                          if (state.passengers.length !=
                              state.selectedSeats.length) {
                            WidgetUtil.showSnackBar(
                                "Please add details for all passengers",
                                context);
                            return;
                          }

                          loader.value = true;
                          try {
                            var response = await context
                                .read<BusBookCubit>()
                                .updatePassengerDetailInOrder();
                            if (response.error != null) {
                              throw "Error updating passenger details";
                            }
                            var updatedCubit = context.read<BusBookCubit>();
                            Navigator.of(context).pushNamed(
                              BusBookingReviewScreen.routeName,
                              arguments: {
                                "cubit": updatedCubit,
                                'blockResponse': response
                              },
                            );
                          } catch (e, s) {
                            log("$e $s");
                            WidgetUtil.showSnackBar(
                                "Error updating passenger details, try again!",
                                context);
                          }
                          loader.value = false;
                        },
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
              body: BlocListener<BusBookCubit, BusBookState>(
                listener: (context, state) {
                  if (state is BusBookError) {
                    WidgetUtil.showSnackBar("Error, please try again", context);
                  }
                },
                child: BlocBuilder<BusBookCubit, BusBookState>(
                  builder: (context, state) {
                    if (state is BusBookLoaded) {
                      var billingEntities =
                          (context.read<AuthCubit>().state as Authenticated)
                              .billingEntities;

                      // Get saved profiles for searchable dropdown
                      final allProfiles = context.read<AuthCubit>().allProfiles;

                      return SingleChildScrollView(
                        physics: const ClampingScrollPhysics(),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: Column(
                                children: [
                                  SizedBox(height: 16.h),
                                  TravelerDetailsWidget(
                                    maxAdult: state.selectedSeats.length,
                                    maxChild: 0,
                                    maxInfant: 0,
                                    showAge: false,
                                    passengerDetails: state.passengers,
                                    savedProfiles: allProfiles,
                                    onAddUpdate: (passenger) {
                                      context
                                          .read<BusBookCubit>()
                                          .onAddUpdatePassenger(passenger);
                                    },
                                  ),
                                  SizedBox(height: 16.h),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColors.primarySwatch[200]!),
                                      borderRadius: BorderRadius.circular(10),
                                      color: AppColors.primaryTextSwatch[50],
                                    ),
                                    child: LabeledDropDownField(
                                      label: "Billing Entity",
                                      items: billingEntities
                                          .map((e) => e.entityName ?? "")
                                          .toList(),
                                      selectedValue:
                                          state.billingEntity?.entityName,
                                      onChanged: (value) {
                                        var found =
                                            billingEntities.firstWhereOrNull(
                                          (e) =>
                                              e.entityName?.equalsIgnoreCase(
                                                  value ?? '') ==
                                              true,
                                        );
                                        context
                                            .read<BusBookCubit>()
                                            .onBillingEntityChange(found);
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 150.h),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return const Loader();
                  },
                ),
              ),
            ),
            if (loading) const Loader(),
          ],
        );
      },
    );
  }
}
