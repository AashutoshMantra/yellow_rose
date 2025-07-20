import 'dart:developer';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:yellow_rose/app_routes.dart';
import 'package:yellow_rose/core/common_widgets/base_appbar.dart';
import 'package:yellow_rose/core/common_widgets/button.dart';
import 'package:yellow_rose/core/common_widgets/loader.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/WidgetUtils.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/dependncy_injection.dart';
import 'package:yellow_rose/features/auth/data/models/billing_entity.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order/update_order_detail_response.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order/update_payment.dart';
import 'package:yellow_rose/features/flight/domain/entities/passenger_details_entity.dart';
import 'package:yellow_rose/features/flight/domain/usecases/air_usecase.dart';
import 'package:yellow_rose/features/flight/presentation/cubit/flight_booking/flight_booking_cubit.dart';
import 'package:yellow_rose/features/flight/presentation/pages/flight_booking_screen.dart';
import 'package:yellow_rose/features/flight/presentation/pages/order_status_screen.dart';
import 'package:yellow_rose/features/flight/presentation/widgets/order/payment_method_list.dart';
import 'package:yellow_rose/features/home_screen/presentation/pages/dashboard.dart';

class BookingDetailedScreen extends StatefulWidget {
  static const String routeName = "/bookingDetailedScreen";
  final FlightBookingLoaded bookingData;
  final UpdateOrderDetailResponse orderUpdateResponse;
  const BookingDetailedScreen(
      {super.key,
      required this.bookingData,
      required this.orderUpdateResponse});

  @override
  State<BookingDetailedScreen> createState() => _BookingDetailedScreenState();
}

class _BookingDetailedScreenState extends State<BookingDetailedScreen> {
  bool _gstDetailsExpanded = false;
  final _airUseCase = getIt<AirUseCase>();
  bool _loading = false;
  Widget getTitleSubtitleWidget(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyles.bodyMediumSemiBoldStyle()),
          const SizedBox(height: 4),
          Text(subtitle,
              style: TextStyles.bodySmallMediumStyle().copyWith(
                color: AppColors.primaryTextSwatch[500],
              )),
        ],
      ),
    );
  }

  Widget getPriceDetaileWidget(String title, String subtitle,
      {Color? titleColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(title,
                style: TextStyles.bodySmallStyle().copyWith(
                  color: titleColor ?? AppColors.primaryTextSwatch[500],
                )),
          ),
          Flexible(child: Text(subtitle, style: TextStyles.bodyMediumStyle())),
        ],
      ),
    );
  }

  List<Widget> getGstDetailsWidget(BillingEntity? billingEntity) {
    return [
      if (_gstDetailsExpanded &&
          billingEntity != null &&
          billingEntity.entityGST != null &&
          billingEntity.entityGST!.isNotEmpty)
        getTitleSubtitleWidget(
          "GST Number",
          billingEntity.entityGST!,
        ),
      if (_gstDetailsExpanded &&
          billingEntity!.gstName != null &&
          billingEntity.gstName!.isNotEmpty)
        getTitleSubtitleWidget(
          "GST Name",
          billingEntity.gstName!,
        ),
      if (_gstDetailsExpanded &&
          billingEntity != null &&
          billingEntity.email != null &&
          billingEntity.email!.isNotEmpty)
        getTitleSubtitleWidget(
          "GST Email",
          billingEntity.email!,
        ),
      if (_gstDetailsExpanded &&
          billingEntity != null &&
          billingEntity.phone != null &&
          billingEntity.phone!.isNotEmpty)
        getTitleSubtitleWidget(
          "GST Phone No.",
          billingEntity.phone!,
        ),
    ];
  }

  Widget getPassengerDetailsWidget(PassengerDetailsEntity passengerDetails) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${passengerDetails.name} ${passengerDetails.lastName ?? ''} (${passengerDetails.gender.name[0]})',
          style: TextStyles.bodySmallStyle()
              .copyWith(color: AppColors.primaryTextSwatch[600]),
        ),
        SizedBox(
          height: 4.h,
        ),
        Text(
          '${passengerDetails.email} | ${passengerDetails.phoneNumber ?? ''}',
          style: TextStyles.bodySmallStyle()
              .copyWith(color: AppColors.primaryTextSwatch[600]),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var billingEntity = widget.bookingData.billingEntity;
    var passengerDetailsWIdgets = widget.bookingData.passengerDetails
        .map(getPassengerDetailsWidget)
        .toList();
    return Scaffold(
      appBar: BaseAppBar(
        title: "Payment",
        subTitle: "",
        shouldHaveRadius: false,
      ),
      bottomNavigationBar: Container(
          margin: EdgeInsets.only(bottom: 28.h),
          child: CustomButton(
              text: "Pay Now",
              onPressed: () async {
                if (_loading) return;
                WidgetUtil.showBottomSheet(
                    context,
                    FlightPaymentMethodListWidget(
                      paymentMediumStatusList:
                          widget.orderUpdateResponse.paymentConfig?.status ??
                              [],
                      onPaymentMethodSelected: (paymentMedium) async {
                        try {
                          setState(() {
                            _loading = true;
                          });
                          var paymentUpdateRequest = UpdatePaymentRequest(
                              paymentMedium: paymentMedium.mediumName!);
                          var response = await _airUseCase.updateOrderPayment(
                              widget.bookingData.orderDetails.orderId!,
                              paymentUpdateRequest);

                          var bookResponse = await _airUseCase.bookOrder(
                              widget.bookingData.orderDetails.orderId!);
                          if (bookResponse.isEmpty) {
                            throw Exception("Empty response");
                          }
                          var errorPnrs = bookResponse
                              .where((d) => d.errorDetails != null)
                              .toList();
                          late OrderStatusEnum orderStatus;
                          if (errorPnrs.isNotEmpty) {
                            if (errorPnrs.length == bookResponse.length) {
                              orderStatus = OrderStatusEnum.error;
                            } else {
                              orderStatus = OrderStatusEnum.warning;
                            }
                          } else {
                            orderStatus = OrderStatusEnum.success;
                          }
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (ctx) {
                            return OrderStatusScreen(orderStatus: orderStatus);
                          }), (route) {
                            return route.settings.name == "/";
                          });
                        } catch (e, s) {
                          log("$e $s");
                          WidgetUtil.showSnackBar(
                              "Failed to book order,try again", context);
                        }

                        setState(() {
                          _loading = false;
                        });
                      },
                    ));
              })),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.bookingData.selectedItineraries.length,
                    itemBuilder: (ctx, idx) {
                      return ItineraryDetail(
                        isLight: true,
                        showIcon: false,
                        airResponseData:
                            widget.bookingData.selectedItineraries[idx],
                        airSearch: widget.bookingData.airSearch,
                        fareType: widget.bookingData.selectedFares[idx]!
                                .fareTypeDisplay ??
                            widget.bookingData.selectedFares[idx]?.fareType ??
                            "",
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 12.h),
                        child: const DottedLine(
                          dashColor: Colors.white,
                        ),
                      );
                    },
                  ),
                  Divider(
                      height: 16.h, color: AppColors.primaryTextSwatch[400]),
                  ...passengerDetailsWIdgets,
                  SizedBox(
                    height: 24.h,
                  ),
                  if (billingEntity != null &&
                      billingEntity.gstName != null &&
                      billingEntity.gstName!.isNotEmpty &&
                      billingEntity.entityGST != null &&
                      billingEntity.entityGST!.isNotEmpty)
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _gstDetailsExpanded = !_gstDetailsExpanded;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.primaryGreen,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        width: MediaQuery.of(context).size.width * .6,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text("GST Information",
                                  style: TextStyles.bodySmallBoldStyle()
                                      .copyWith(color: Colors.white)),
                              const Spacer(),
                              Icon(
                                _gstDetailsExpanded
                                    ? Icons.keyboard_arrow_up_rounded
                                    : Icons.keyboard_arrow_down_rounded,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ...getGstDetailsWidget(billingEntity),
                  SizedBox(height: 16.h),
                  Text("Total Amount",
                      style: TextStyles.bodyMediumSemiBoldStyle()),
                  SizedBox(height: 12.h),
                  getPriceDetaileWidget(
                    "Base fare ",
                    "₹ ${widget.orderUpdateResponse.priceData?.totalBaseAmount.toStringAsFixed(2)}",
                  ),
                  getPriceDetaileWidget(
                    "Airline Taxes ",
                    "+ ₹ ${widget.orderUpdateResponse.priceData?.airlineTaxes.toStringAsFixed(2)}",
                  ),
                  Divider(
                    color: AppColors.primaryTextSwatch[500],
                    thickness: 1.h,
                    height: 12.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text("Net Pay",
                              style: TextStyles.bodySmallBoldStyle()),
                        ),
                        Flexible(
                            child: Text(
                                "₹ ${widget.orderUpdateResponse.priceData?.totalBookingAmount.toStringAsFixed(2)}",
                                style: TextStyles.bodyMediumBoldStyle())),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_loading) const Loader()
        ],
      ),
    );
  }
}
