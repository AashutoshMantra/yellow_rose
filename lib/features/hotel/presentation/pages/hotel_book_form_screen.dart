import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yellow_rose/core/common_widgets/base_appbar.dart';
import 'package:yellow_rose/core/common_widgets/labelled_container.dart';
import 'package:yellow_rose/core/common_widgets/labelled_drop_dowdn.dart';
import 'package:yellow_rose/core/common_widgets/loader.dart';
import 'package:yellow_rose/core/common_widgets/passenger_detail/traveller_details_widget.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/utils/WidgetUtils.dart';
import 'package:yellow_rose/core/utils/extensions.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:yellow_rose/features/flight/presentation/widgets/bottom_button.dart';
import 'package:yellow_rose/features/hotel/data/models/details/hotel_detail_resonse.dart';
import 'package:yellow_rose/features/hotel/domain/entities/hotel_search.dart';
import 'package:yellow_rose/features/hotel/presentation/cubit/hotel_book_cubit/hotel_book_cubit.dart';
import 'package:yellow_rose/features/hotel/presentation/pages/hotel_booking_review_screen.dart';
import 'package:yellow_rose/features/hotel/presentation/pages/hotel_search_list_scree.dart';
import 'package:yellow_rose/features/hotel/presentation/widgets/book_form/hotel_special_request.dart';
import 'package:yellow_rose/features/trip/presentation/cubit/trip_cubit.dart';

class HotelBookFormScreen extends StatelessWidget {
  final HotelSearch hotelSearch;
  final HotelDetailResponse hotelDetailResponse;
  static const routeName = "/hotelBookFormScreen";
  const HotelBookFormScreen(
      {super.key,
      required this.hotelSearch,
      required this.hotelDetailResponse});
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
                  title: hotelDetailResponse.hotel?.name ?? '',
                  subTitle: getTravellerDetailsAndDate(hotelSearch),
                  shouldHaveRadius: false,
                ),
                bottomNavigationBar:
                    BlocBuilder<HotelBookCubit, HotelBookState>(
                  builder: (context, state) {
                    if (state is HotelBookLoaded) {
                      return SizedBox(
                        height: 95.h,
                        width: double.infinity,
                        child: BottomButton(
                          buttonText: "Book",
                          title:
                              "₹ ${state.selectedRoom.hotelRooms[0].totalcost.toStringAsFixed(1)}",
                          subtitle: "Total Cost",
                          onClick: () async {
                            var adultCount = state.passengerDetails
                                .where((p) => p.passengerType.isAdult())
                                .length;
                            var childCount = state.passengerDetails
                                .where((p) => p.passengerType.isChild())
                                .length;

                            if (state.billingEntity == null) {
                              WidgetUtil.showSnackBar(
                                  "Please select billing entity", context);
                              return;
                            }
                            if (adultCount != hotelSearch.adultCount ||
                                childCount != hotelSearch.childAges?.length) {
                              WidgetUtil.showSnackBar(
                                  "Please add all traveler details", context);
                            } else {
                              loader.value = true;
                              try {
                                var response = await context
                                    .read<HotelBookCubit>()
                                    .udpatePassengerDetailInorder();
                                if (response.priceData == null) {
                                  throw "Error ";
                                }
                                Navigator.of(context).pushNamed(
                                    HotelBookingReviewScreen.routeName,
                                    arguments: {
                                      "cubit": context.read<HotelBookCubit>()
                                    });
                              } catch (e, s) {
                                log("$e $s");
                                WidgetUtil.showSnackBar(
                                    "Error updaing passenger, try again!",
                                    context);
                              }

                              loader.value = false;
                            }
                          },
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
                body: BlocListener<HotelBookCubit, HotelBookState>(
                  listener: (context, state) {
                    if (state is HotelBookError) {
                      Navigator.of(context).pop();
                      WidgetUtil.showSnackBar(
                          "Error, please try again", context);
                    }
                  },
                  child: BlocBuilder<HotelBookCubit, HotelBookState>(
                    builder: (context, state) {
                      if (state is HotelBookLoaded) {
                        var billingEntities =
                            (context.read<AuthCubit>().state as Authenticated)
                                .billingEntities;

                        // Get saved profiles for searchable dropdown
                        final allProfiles =
                            context.read<AuthCubit>().allProfiles;

                        return SingleChildScrollView(
                          physics: const ClampingScrollPhysics(),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.w),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 16.h,
                                    ),
                                    TravelerDetailsWidget(
                                      maxAdult: hotelSearch.adultCount!,
                                      maxChild:
                                          hotelSearch.childAges?.length ?? 0,
                                      maxInfant: 0,
                                      passengerDetails: state.passengerDetails,
                                      savedProfiles: allProfiles,
                                      isReadOnly: context
                                              .read<TripCubit>()
                                              .selectedTrip !=
                                          null,
                                      lockMessage: context
                                                  .read<TripCubit>()
                                                  .selectedTrip !=
                                              null
                                          ? "Passenger details are fixed for this trip booking"
                                          : null,
                                      onAddUpdate: (passengerDetail) {
                                        context
                                            .read<HotelBookCubit>()
                                            .onAddUpdatePassenger(
                                                passengerDetail);
                                      },
                                    ),
                                    SizedBox(
                                      height: 16.h,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color:
                                                AppColors.primarySwatch[200]!,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color:
                                              AppColors.primaryTextSwatch[50]),
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
                                              .read<HotelBookCubit>()
                                              .onBillingEntityChange(found);
                                        },
                                      ),
                                    ),
                                    Container(
                                        margin: EdgeInsets.only(top: 16.h),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                              color:
                                                  AppColors.primarySwatch[200]!,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: AppColors
                                                .primaryTextSwatch[50]),
                                        child: LabeledContainerField(
                                          label: "Special Request",
                                          child: HotelSpecialRequestWidget(
                                            onChanged: (specialRequest) {
                                              context
                                                  .read<HotelBookCubit>()
                                                  .onSpecialRequestChange(
                                                      specialRequest);
                                            },
                                            request: state.specialRequest,
                                          ),
                                        )),
                                    SizedBox(
                                      height: 150.h,
                                    ),
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
              if (loading) const Loader()
            ],
          );
        });
  }
}
