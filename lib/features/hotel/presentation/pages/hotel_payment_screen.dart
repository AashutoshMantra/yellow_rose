import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yellow_rose/core/common_widgets/base_appbar.dart';
import 'package:yellow_rose/core/common_widgets/loader.dart';
import 'package:yellow_rose/core/common_widgets/button.dart';
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
import 'package:yellow_rose/features/flight/presentation/pages/order_status_screen.dart';
import 'package:yellow_rose/features/flight/presentation/widgets/order/payment_method_list.dart';
import 'package:yellow_rose/features/hotel/presentation/cubit/hotel_book_cubit/hotel_book_cubit.dart';
import 'package:yellow_rose/features/hotel/domain/usecases/hotel_book_use_case.dart';
// ...existing imports...

class HotelPaymentScreen extends StatefulWidget {
  static const String routeName = "/hotelPaymentScreen";
  final UpdateOrderDetailResponse orderUpdateResponse;
  const HotelPaymentScreen({super.key, required this.orderUpdateResponse});

  @override
  State<HotelPaymentScreen> createState() => _HotelPaymentScreenState();
}

class _HotelPaymentScreenState extends State<HotelPaymentScreen> {
  bool _gstDetailsExpanded = false;
  final _hotelUseCase = getIt<HotelBookUseCase>();
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

  Widget getGuestWidget(PassengerDetailsEntity p) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 16.h,
              backgroundColor: AppColors.primaryGreen,
              child: Icon(Icons.person, size: 16.h, color: Colors.white),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${p.name} ${p.lastName} (${p.gender.name[0]})',
                    style: TextStyles.bodyMediumSemiBoldStyle().copyWith(
                      fontSize: 15,
                      color: AppColors.primaryTextSwatch[700],
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '${p.email} | ${p.phoneNumber}',
                    style: TextStyles.bodySmallMediumStyle()
                        .copyWith(color: AppColors.primaryTextSwatch[600]),
                  ),
                ],
              ),
            )
          ],
        ),
        SizedBox(height: 10.h),
        Divider(color: AppColors.primaryTextSwatch[100]),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
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
            WidgetUtil.showBottomSheet(
                context,
                FlightPaymentMethodListWidget(
                  paymentMediumStatusList:
                      widget.orderUpdateResponse.paymentConfig?.status ?? [],
                  onPaymentMethodSelected: (paymentMedium) async {
                    try {
                      setState(() {
                        _loading = true;
                      });
                      var paymentUpdateRequest = UpdatePaymentRequest(
                          paymentMedium: paymentMedium.mediumName!);
                      var response = await _hotelUseCase.updateOrderPayment(
                          widget.orderUpdateResponse.orderNumber!,
                          paymentUpdateRequest);

                      var bookResponse = await _hotelUseCase
                          .bookHotel(widget.orderUpdateResponse.orderNumber!);

                      var hasErrors = bookResponse.error?.errorData != null;
                      OrderStatusEnum orderStatus = OrderStatusEnum.success;
                      if (hasErrors ||
                          (bookResponse.mmtBookingResponse ?? []).isEmpty &&
                              (bookResponse.expediaBookingResponse ?? [])
                                  .isEmpty) {
                        orderStatus = OrderStatusEnum.error;
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
          },
        ),
      ),
      body: BlocBuilder<HotelBookCubit, HotelBookState>(
          builder: (context, state) {
        if (state is HotelBookLoaded) {
          var billingEntity = state.billingEntity;
          return Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(12.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Hotel summary (prominent text — app style)
                      Text(state.hotel.hotel?.name ?? '',
                          style: TextStyles.bodyMediumSemiBoldStyle()
                              .copyWith(fontSize: 18)),
                      SizedBox(height: 6.h),
                      Text(state.hotel.hotel?.address ?? '',
                          style: TextStyles.bodySmallStyle().copyWith(
                              color: AppColors.primaryTextSwatch[600])),
                      SizedBox(height: 12.h),
                      Divider(
                        color: AppColors.primaryTextSwatch[100],
                        thickness: 1.h,
                        height: 1.h,
                      ),
                      SizedBox(height: 12.h),

                      // Room details (prominent text)
                      Text("Room", style: TextStyles.bodyMediumSemiBoldStyle()),
                      SizedBox(height: 6.h),
                      Text(
                        state.selectedRoom.hotelRooms.isNotEmpty
                            ? state.selectedRoom.hotelRooms[0].name ?? ''
                            : '',
                        style: TextStyles.bodyMediumBoldStyle()
                            .copyWith(fontSize: 16),
                      ),
                      SizedBox(height: 12.h),

                      // Check-in / Check-out side-by-side rounded containers

                      // Check-in / Check-out side-by-side rounded containers
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 12.h, horizontal: 12.w),
                              decoration: BoxDecoration(
                                color: AppColors.primarySwatch[100],
                                borderRadius: BorderRadius.circular(40),
                                border: Border.all(
                                    color: AppColors.primaryTextSwatch[200] ??
                                        Colors.grey.shade300),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Check-in",
                                      style: TextStyles.bodySmallStyle()
                                          .copyWith(
                                              color: AppColors
                                                  .primaryTextSwatch[500])),
                                  SizedBox(height: 6.h),
                                  Text(
                                    state.hotelSearch.checkInDate
                                            ?.toLocal()
                                            .toString()
                                            .split(' ')[0] ??
                                        '',
                                    style: TextStyles.bodyMediumSemiBoldStyle(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 12.h, horizontal: 12.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: AppColors.primarySwatch[100],
                                border: Border.all(
                                    color: AppColors.primaryTextSwatch[200] ??
                                        Colors.grey.shade300),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Check-out",
                                      style: TextStyles.bodySmallStyle()
                                          .copyWith(
                                              color: AppColors
                                                  .primaryTextSwatch[500])),
                                  SizedBox(height: 6.h),
                                  Text(
                                    state.hotelSearch.checkOutDate
                                            ?.toLocal()
                                            .toString()
                                            .split(' ')[0] ??
                                        '',
                                    style: TextStyles.bodyMediumSemiBoldStyle(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),

                      // Guests (prominent text list)
                      Text("Guests",
                          style: TextStyles.bodyMediumSemiBoldStyle()),
                      SizedBox(height: 8.h),
                      ...state.passengerDetails.map((p) => Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 8.h, horizontal: 0),
                            child: getGuestWidget(p),
                          )),
                      SizedBox(height: 16.h),

                      // GST / Billing
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
                      Text("Payment Details",
                          style: TextStyles.bodyMediumSemiBoldStyle()),
                      SizedBox(height: 12.h),
                      getPriceDetaileWidget("Room Price",
                          "₹ ${state.selectedRoom.hotelRooms.isNotEmpty ? state.selectedRoom.hotelRooms[0].totalcost.toStringAsFixed(2) : '0.00'}"),
                      Divider(
                          color: AppColors.primaryTextSwatch[500],
                          thickness: 1.h,
                          height: 12.h),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                                child: Text("Net Pay",
                                    style: TextStyles.bodySmallBoldStyle())),
                            Flexible(
                                child: Text(
                                    "₹ ${state.selectedRoom.hotelRooms.isNotEmpty ? state.selectedRoom.hotelRooms[0].totalcost.toStringAsFixed(2) : '0.00'}",
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
          );
        }
        return const SizedBox.shrink();
      }),
    );
  }
}
