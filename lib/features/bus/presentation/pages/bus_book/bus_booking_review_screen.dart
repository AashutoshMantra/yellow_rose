import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yellow_rose/core/common_widgets/base_appbar.dart';
import 'package:yellow_rose/core/common_widgets/bottom_button.dart';
import 'package:yellow_rose/core/common_widgets/gst_info_card.dart';
import 'package:yellow_rose/core/common_widgets/key_value_row.dart';
import 'package:yellow_rose/core/common_widgets/loader.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/WidgetUtils.dart';
import 'package:yellow_rose/core/utils/date_utils.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/dependncy_injection.dart';
import 'package:yellow_rose/features/auth/domain/entities/trip_type.dart';
import 'package:yellow_rose/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:yellow_rose/features/bus/data/models/order/bos_block_response.dart';
import 'package:yellow_rose/features/bus/data/models/order/bus_order__create_request.dart';
import 'package:yellow_rose/features/bus/data/models/order/bus_payment_medium_status.dart';
import 'package:yellow_rose/features/bus/domain/usecases/bus_usecase.dart';
import 'package:yellow_rose/features/bus/presentation/cubit/bus_book/bus_book_cubit.dart';
import 'package:yellow_rose/features/bus/presentation/widgets/bus_journey_hero_card.dart';
import 'package:yellow_rose/features/bus/presentation/widgets/bus_journey_timeline.dart';
import 'package:yellow_rose/features/bus/presentation/widgets/bus_passenger_tile.dart';
import 'package:yellow_rose/features/bus/presentation/widgets/bus_section_card.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order/payment_medium_request_res.dart';
import 'package:yellow_rose/features/flight/domain/usecases/air_mapper_utility.dart';
import 'package:yellow_rose/features/flight/presentation/pages/order_status_screen.dart';
import 'package:yellow_rose/features/flight/presentation/widgets/order/payment_method_list.dart';
import 'package:yellow_rose/features/trip/presentation/cubit/trip_cubit.dart';

class BusBookingReviewScreen extends StatefulWidget {
  static const routeName = "/busBookingReviewScreen";
  final BusBlockTicketResponse busBlockResponse;
  const BusBookingReviewScreen({super.key, required this.busBlockResponse});

  @override
  State<BusBookingReviewScreen> createState() => _BusBookingReviewScreenState();
}

class _BusBookingReviewScreenState extends State<BusBookingReviewScreen> {
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  final _busUseCase = getIt.get<BusUseCase>();
  String _formatTime(DateTime? value) {
    if (value == null) return "--";
    return CustomDateUtils.timeInAmPm(value);
  }

  String _formatDate(DateTime? value) {
    if (value == null) return "--";
    return CustomDateUtils.dayDateMonthFormat(value);
  }

  double _calculateSeatTotal(BusBookLoaded state) {
    if (state.busDetailResponse.seats.isEmpty) return 0;
    double totalFare = 0;
    final defaultSeat = state.busDetailResponse.seats.first;
    for (var seat in state.selectedSeats) {
      final seatDetail = state.busDetailResponse.seats.firstWhere(
        (s) => s.name == seat,
        orElse: () => defaultSeat,
      );
      totalFare += seatDetail.fare ?? 0;
    }
    return totalFare;
  }

  List<PaymentMediumStatus> _mapPaymentStatuses(
      List<dynamic>? paymentStatuses) {
    if (paymentStatuses == null) return [];
    var paymentStatus = paymentStatuses.map((status) {
      if (status is PaymentMediumStatus) return status;
      if (status is BusPaymentMediumStatus) {
        return PaymentMediumStatus(
          mediumName: status.mediumName,
          isBusinessEnabled: status.isBusinessEnabled,
          isPersonalEnabled: status.isPersonalEnabled,
        );
      }
      if (status is Map<String, dynamic>) {
        return PaymentMediumStatus.fromMap(status);
      }
      return PaymentMediumStatus(mediumName: status.toString());
    }).toList();
    var selectedTrip = context.read<TripCubit>().selectedTrip;
    return AirMapperUtility.getFilteredPaymentMediumStatusList(
        paymentStatus, selectedTrip);
  }

  void _handlePaymentSelection(
    BuildContext context,
    List<PaymentMediumStatus> methods,
    BusBookLoaded state,
  ) {
    if (methods.isEmpty) {
      WidgetUtil.showSnackBar(
          "Payment methods are not available for this booking yet", context);
      return;
    }

    var selectedTrip = context.read<TripCubit>().selectedTrip;
    var tripType = context.read<AuthCubit>().tripType;

    // For trip prebooking, auto-select first payment method without popup
    if (selectedTrip != null && tripType == TripType.PreBooking) {
      _handlePaymentAndBooking(methods.first, state);
    } else {
      // Show payment method selector for non-trip bookings
      WidgetUtil.showBottomSheet(
        context,
        FlightPaymentMethodListWidget(
          paymentMediumStatusList: methods,
          onPaymentMethodSelected: (paymentMedium) async {
            await _handlePaymentAndBooking(paymentMedium, state);
          },
        ),
      );
    }
  }

  Future<void> _handlePaymentAndBooking(
    PaymentMediumStatus paymentMedium,
    BusBookLoaded state,
  ) async {
    try {
      _loading.value = true;

      await _busUseCase.updateOrder(
        state.busOrderResponse.orderNumber!,
        BusOrderCreateRequest(
          paymentMedium: paymentMedium.mediumName!,
        ),
      );

      var selectedTrip = context.read<TripCubit>().selectedTrip;
      var tripType = context.read<AuthCubit>().tripType;
      OrderStatusEnum orderStatus = OrderStatusEnum.success;

      if (selectedTrip == null || tripType == TripType.PostBooking) {
        var response = await _busUseCase.bookOrder(
            state.busOrderResponse.orderNumber!,
            widget.busBlockResponse.blockKey!);

        var hasErrors = response.error != null;
        if (hasErrors) {
          orderStatus = OrderStatusEnum.error;
        }
      } else {
        await context
            .read<TripCubit>()
            .addToTrip(state.busOrderResponse.orderNumber!);
      }

      if (mounted) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (ctx) {
          return OrderStatusScreen(orderStatus: orderStatus);
        }), (route) {
          return route.settings.name == "/";
        });
      }
    } catch (e, s) {
      log("$e $s");
      if (mounted) {
        WidgetUtil.showSnackBar(
            "Failed to complete booking, try again", context);
      }
    } finally {
      _loading.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _loading,
      builder: (context, loading, _) {
        return Stack(
          children: [
            Scaffold(
              appBar: BaseAppBar(
                title: "Bus Booking Review",
                subTitle: "Review and confirm your booking",
                shouldHaveRadius: false,
              ),
              bottomNavigationBar: BlocBuilder<BusBookCubit, BusBookState>(
                  builder: (context, state) {
                if (state is! BusBookLoaded) return const SizedBox.shrink();
                final orderResponse =
                    state.updateOrderDetailResponse ?? state.busOrderResponse;
                final totalAmount =
                    orderResponse.priceData?.totalBookingAmount ??
                        _calculateSeatTotal(state);
                final paymentMethods =
                    _mapPaymentStatuses(orderResponse.paymentConfig?.status);
                final currency = orderResponse.priceData?.currency ?? 'INR';

                return SizedBox(
                  height: 95.h,
                  width: double.infinity,
                  child: BottomButton(
                    title: '₹ ${totalAmount.toStringAsFixed(2)}',
                    subtitle: '$currency • Taxes included',
                    buttonText:
                        paymentMethods.isEmpty ? 'Payment Unavailable' : 'Pay',
                    onClick: () => _handlePaymentSelection(
                      context,
                      paymentMethods,
                      state,
                    ),
                  ),
                );
              }),
              body: BlocBuilder<BusBookCubit, BusBookState>(
                builder: (context, state) {
                  if (state is BusBookLoaded) {
                    final billingEntity = state.billingEntity;
                    final busSearchResponse = state.busSearchResponse;
                    final seatList = state.selectedSeats.toList()..sort();
                    final orderResponse = state.updateOrderDetailResponse ??
                        state.busOrderResponse;
                    final totalFare =
                        orderResponse.priceData?.totalBookingAmount ??
                            _calculateSeatTotal(state);

                    final departureTime = busSearchResponse.departureTime;

                    return Stack(
                      children: [
                        SingleChildScrollView(
                          padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 120.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              BusJourneyHeroCard(
                                busInfo: busSearchResponse,
                                seatCount: state.selectedSeats.length,
                              ),
                              SizedBox(height: 16.h),
                              BusSectionCard(
                                title: 'Boarding & Drop',
                                child: BusJourneyTimeline(
                                  entries: [
                                    BusTimelineEntry(
                                      title: 'Boarding',
                                      location:
                                          state.selectedBoardingPoint?.location,
                                      time: _formatTime(
                                          state.selectedBoardingPoint?.time),
                                      address:
                                          state.selectedBoardingPoint?.address,
                                    ),
                                    BusTimelineEntry(
                                      title: 'Dropping',
                                      location:
                                          state.selectedDroppingPoint?.location,
                                      time: _formatTime(
                                          state.selectedDroppingPoint?.time),
                                      address:
                                          state.selectedDroppingPoint?.address,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 16.h),
                              BusSectionCard(
                                title: 'Seats & Travel Date',
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Wrap(
                                      spacing: 8.w,
                                      runSpacing: 8.h,
                                      children: seatList
                                          .map((seat) => Chip(
                                                backgroundColor:
                                                    AppColors.primarySwatch[50],
                                                label: Text(
                                                  'Seat $seat',
                                                  style: TextStyles
                                                      .bodySmallBoldStyle(),
                                                ),
                                              ))
                                          .toList(),
                                    ),
                                    SizedBox(height: 12.h),
                                    Text(
                                      'Journey on ${_formatDate(departureTime)}',
                                      style: TextStyles.bodySmallMediumStyle()
                                          .copyWith(
                                              color: AppColors
                                                  .primaryTextSwatch[600]),
                                    ),
                                    Text(
                                      '${seatList.length} passenger${seatList.length > 1 ? 's' : ''} travelling',
                                      style: TextStyles.bodySmallMediumStyle()
                                          .copyWith(
                                              color: AppColors
                                                  .primaryTextSwatch[600]),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 16.h),
                              BusSectionCard(
                                title:
                                    'Passengers (${state.passengers.length})',
                                child: Column(
                                  children: state.passengers
                                      .asMap()
                                      .entries
                                      .map((entry) => BusPassengerTile(
                                            passenger: entry.value,
                                            seatLabel:
                                                entry.key < seatList.length
                                                    ? seatList[entry.key]
                                                    : null,
                                          ))
                                      .toList(),
                                ),
                              ),
                              if (billingEntity != null &&
                                  ((billingEntity.entityGST?.isNotEmpty ??
                                          false) ||
                                      (billingEntity.entityName?.isNotEmpty ??
                                          false)))
                                Padding(
                                  padding: EdgeInsets.only(top: 16.h),
                                  child:
                                      GstInfoCard(billingEntity: billingEntity),
                                ),
                              SizedBox(height: 16.h),
                              BusSectionCard(
                                title: 'Fare Breakdown',
                                child: Column(
                                  children: [
                                    KeyValueRow(
                                      label:
                                          'Base Fare (${seatList.length} seat${seatList.length > 1 ? 's' : ''})',
                                      value:
                                          '₹ ${_calculateSeatTotal(state).toStringAsFixed(2)}',
                                    ),
                                    if (state.busDetailResponse.seats
                                            .isNotEmpty &&
                                        state.busDetailResponse.seats.first
                                                .commercialData !=
                                            null)
                                      Column(
                                        children: [
                                          KeyValueRow(
                                            label: 'Service Charge',
                                            value:
                                                '₹ ${(state.busDetailResponse.seats.first.commercialData!.charge ?? 0).toStringAsFixed(2)}',
                                          ),
                                          KeyValueRow(
                                            label: 'GST',
                                            value:
                                                '₹ ${(state.busDetailResponse.seats.first.commercialData!.tax ?? 0).toStringAsFixed(2)}',
                                          ),
                                        ],
                                      ),
                                    Divider(height: 24.h),
                                    KeyValueRow(
                                      label: 'Total Payable',
                                      value:
                                          '₹ ${totalFare.toStringAsFixed(2)}',
                                      emphasised: true,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 100.h),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                  return const Loader();
                },
              ),
            ),
            if (loading) const Loader(),
          ],
        );
      },
    );
  }
}
