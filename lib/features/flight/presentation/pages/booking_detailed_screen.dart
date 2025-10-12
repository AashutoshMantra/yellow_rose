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
import 'package:yellow_rose/features/flight/data/models/booking/ssor_options.dart';
import 'package:yellow_rose/features/flight/domain/entities/passenger_details_entity.dart';
import 'package:yellow_rose/features/flight/domain/entities/seat_map/selected_seat.dart';
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
  final ScrollController _scrollController = ScrollController();
  bool _hasScrolledToPricing = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    // Check if user has scrolled near the bottom (pricing section)
    if (_scrollController.hasClients) {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.offset;
      final threshold = maxScroll * 0.7; // 70% scrolled

      if (currentScroll > threshold && !_hasScrolledToPricing) {
        setState(() {
          _hasScrolledToPricing = true;
        });
      } else if (currentScroll <= threshold && _hasScrolledToPricing) {
        setState(() {
          _hasScrolledToPricing = false;
        });
      }
    }
  }

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

  Widget getAddOnsSection() {
    var hasSeats = widget.bookingData.selectedSeats.values
        .any((seats) => seats.isNotEmpty);
    var hasMeals =
        widget.bookingData.selectedSsr.values.any((meals) => meals.isNotEmpty);
    var hasBaggage = widget.bookingData.selectedBaggage.values
        .any((baggage) => baggage.isNotEmpty);
    var hasSpecialRequests = widget.bookingData.selectedSpecialRequests.values
        .any((requests) => requests.isNotEmpty);

    if (!hasSeats && !hasMeals && !hasBaggage && !hasSpecialRequests) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16.h),
        Row(
          children: [
            const Icon(Icons.add_circle_outline,
                color: AppColors.primaryGreen, size: 20),
            SizedBox(width: 8.w),
            Text("Selected Add-ons",
                style: TextStyles.h6Style().copyWith(color: AppColors.primary)),
          ],
        ),
        SizedBox(height: 12.h),
        if (hasSeats) _buildSeatsSection(),
        if (hasMeals) _buildMealsSection(),
        if (hasBaggage) _buildBaggageSection(),
        if (hasSpecialRequests) _buildSpecialRequestsSection(),
      ],
    );
  }

  Widget _buildSeatsSection() {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.primaryTextSwatch[50],
        border: Border.all(color: AppColors.primarySwatch[200]!),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.airline_seat_recline_normal,
                  color: AppColors.primaryGreen, size: 20),
              SizedBox(width: 8.w),
              Text("Seats",
                  style: TextStyles.bodyMediumSemiBoldStyle()
                      .copyWith(color: AppColors.primary)),
            ],
          ),
          SizedBox(height: 8.h),
          ...widget.bookingData.selectedSeats.entries
              .where((entry) => entry.value.isNotEmpty)
              .map((entry) {
            var flightKey = entry.key;
            var seats = entry.value;
            var totalCost =
                seats.fold<double>(0, (sum, seat) => sum + seat.totalCost);

            return Padding(
              padding: EdgeInsets.symmetric(vertical: 4.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _formatFlightKey(flightKey),
                          style: TextStyles.bodySmallSemiBoldStyle(),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          seats
                              .map((s) => '${s.row}${s.seat.column}')
                              .join(', '),
                          style: TextStyles.bodySmallStyle().copyWith(
                              color: AppColors.primaryTextSwatch[500]),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '₹ ${totalCost.toStringAsFixed(2)}',
                    style: TextStyles.bodyMediumSemiBoldStyle()
                        .copyWith(color: AppColors.primaryGreen),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildMealsSection() {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.primaryTextSwatch[50],
        border: Border.all(color: AppColors.primarySwatch[200]!),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.restaurant,
                  color: AppColors.primaryGreen, size: 20),
              SizedBox(width: 8.w),
              Text("Meals",
                  style: TextStyles.bodyMediumSemiBoldStyle()
                      .copyWith(color: AppColors.primary)),
            ],
          ),
          SizedBox(height: 8.h),
          ...widget.bookingData.selectedSsr.entries
              .where((entry) => entry.value.isNotEmpty)
              .map((entry) {
            var flightKey = entry.key;
            var meals = entry.value;
            var totalCost = meals.values
                .fold<double>(0, (sum, meal) => sum + meal.totalCost);

            return Padding(
              padding: EdgeInsets.symmetric(vertical: 4.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _formatFlightKey(flightKey),
                    style: TextStyles.bodySmallSemiBoldStyle(),
                  ),
                  SizedBox(height: 4.h),
                  ...meals.entries.map((mealEntry) {
                    var passenger = widget.bookingData.passengerDetails
                        .firstWhere((p) => p.id == mealEntry.key);
                    var meal = mealEntry.value;
                    return Padding(
                      padding: EdgeInsets.only(left: 12.w, bottom: 4.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              '${passenger.name}: ${meal.type ?? meal.description ?? meal.code}',
                              style: TextStyles.bodySmallStyle().copyWith(
                                  color: AppColors.primaryTextSwatch[600]),
                            ),
                          ),
                          Text(
                            '₹ ${meal.totalCost.toStringAsFixed(2)}',
                            style: TextStyles.bodySmallMediumStyle().copyWith(
                                color: AppColors.primaryTextSwatch[600]),
                          ),
                        ],
                      ),
                    );
                  }),
                  Divider(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total',
                        style: TextStyles.bodySmallSemiBoldStyle(),
                      ),
                      Text(
                        '₹ ${totalCost.toStringAsFixed(2)}',
                        style: TextStyles.bodyMediumSemiBoldStyle()
                            .copyWith(color: AppColors.primaryGreen),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildBaggageSection() {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.primaryTextSwatch[50],
        border: Border.all(color: AppColors.primarySwatch[200]!),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.luggage,
                  color: AppColors.primaryGreen, size: 20),
              SizedBox(width: 8.w),
              Text("Baggage",
                  style: TextStyles.bodyMediumSemiBoldStyle()
                      .copyWith(color: AppColors.primary)),
            ],
          ),
          SizedBox(height: 8.h),
          ...widget.bookingData.selectedBaggage.entries
              .where((entry) => entry.value.isNotEmpty)
              .map((entry) {
            var flightKey = entry.key;
            var baggage = entry.value;
            var totalCost = baggage.values
                .fold<double>(0, (sum, bag) => sum + bag.totalCost);

            return Padding(
              padding: EdgeInsets.symmetric(vertical: 4.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _formatFlightKey(flightKey),
                    style: TextStyles.bodySmallSemiBoldStyle(),
                  ),
                  SizedBox(height: 4.h),
                  ...baggage.entries.map((baggageEntry) {
                    var passenger = widget.bookingData.passengerDetails
                        .firstWhere((p) => p.id == baggageEntry.key);
                    var bag = baggageEntry.value;
                    return Padding(
                      padding: EdgeInsets.only(left: 12.w, bottom: 4.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              '${passenger.name}: ${bag.type ?? bag.description ?? bag.code}',
                              style: TextStyles.bodySmallStyle().copyWith(
                                  color: AppColors.primaryTextSwatch[600]),
                            ),
                          ),
                          Text(
                            '₹ ${bag.totalCost.toStringAsFixed(2)}',
                            style: TextStyles.bodySmallMediumStyle().copyWith(
                                color: AppColors.primaryTextSwatch[600]),
                          ),
                        ],
                      ),
                    );
                  }),
                  Divider(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total',
                        style: TextStyles.bodySmallSemiBoldStyle(),
                      ),
                      Text(
                        '₹ ${totalCost.toStringAsFixed(2)}',
                        style: TextStyles.bodyMediumSemiBoldStyle()
                            .copyWith(color: AppColors.primaryGreen),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildSpecialRequestsSection() {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.primaryTextSwatch[50],
        border: Border.all(color: AppColors.primarySwatch[200]!),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.accessible,
                  color: AppColors.primaryGreen, size: 20),
              SizedBox(width: 8.w),
              Text("Special Requests",
                  style: TextStyles.bodyMediumSemiBoldStyle()
                      .copyWith(color: AppColors.primary)),
            ],
          ),
          SizedBox(height: 8.h),
          ...widget.bookingData.selectedSpecialRequests.entries
              .where((entry) => entry.value.isNotEmpty)
              .map((entry) {
            var flightKey = entry.key;
            var requests = entry.value;
            var totalCost = requests.values
                .fold<double>(0, (sum, req) => sum + req.totalCost);

            return Padding(
              padding: EdgeInsets.symmetric(vertical: 4.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _formatFlightKey(flightKey),
                    style: TextStyles.bodySmallSemiBoldStyle(),
                  ),
                  SizedBox(height: 4.h),
                  ...requests.entries.map((requestEntry) {
                    var passenger = widget.bookingData.passengerDetails
                        .firstWhere((p) => p.id == requestEntry.key);
                    var request = requestEntry.value;
                    return Padding(
                      padding: EdgeInsets.only(left: 12.w, bottom: 4.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              '${passenger.name}: ${request.type ?? request.description ?? request.code}',
                              style: TextStyles.bodySmallStyle().copyWith(
                                  color: AppColors.primaryTextSwatch[600]),
                            ),
                          ),
                          Text(
                            '₹ ${request.totalCost.toStringAsFixed(2)}',
                            style: TextStyles.bodySmallMediumStyle().copyWith(
                                color: AppColors.primaryTextSwatch[600]),
                          ),
                        ],
                      ),
                    );
                  }),
                  Divider(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total',
                        style: TextStyles.bodySmallSemiBoldStyle(),
                      ),
                      Text(
                        '₹ ${totalCost.toStringAsFixed(2)}',
                        style: TextStyles.bodyMediumSemiBoldStyle()
                            .copyWith(color: AppColors.primaryGreen),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  String _formatFlightKey(String key) {
    // Format: "6E-123#DEL#BOM" -> "6E-123 (DEL → BOM)"
    var parts = key.split('#');
    if (parts.length >= 3) {
      return '${parts[0]} (${parts[1]} → ${parts[2]})';
    }
    return key;
  }

  // Calculate total costs for each add-on category
  double _getTotalSeatsCost() {
    return widget.bookingData.selectedSeats.values
        .expand((seats) => seats)
        .fold<double>(0, (sum, seat) => sum + seat.totalCost);
  }

  double _getTotalMealsCost() {
    return widget.bookingData.selectedSsr.values
        .expand((meals) => meals.values)
        .fold<double>(0, (sum, meal) => sum + meal.totalCost);
  }

  double _getTotalBaggageCost() {
    return widget.bookingData.selectedBaggage.values
        .expand((baggage) => baggage.values)
        .fold<double>(0, (sum, bag) => sum + bag.totalCost);
  }

  double _getTotalSpecialRequestsCost() {
    return widget.bookingData.selectedSpecialRequests.values
        .expand((requests) => requests.values)
        .fold<double>(0, (sum, request) => sum + request.totalCost);
  }

  double _getTotalAddOnsCost() {
    return _getTotalSeatsCost() +
        _getTotalMealsCost() +
        _getTotalBaggageCost() +
        _getTotalSpecialRequestsCost();
  }

  Widget _buildPricingSection() {
    var baseFare = widget.orderUpdateResponse.priceData?.totalBaseAmount ?? 0;
    var taxes = widget.orderUpdateResponse.priceData?.airlineTaxes ?? 0;
    var seatsCost = _getTotalSeatsCost();
    var mealsCost = _getTotalMealsCost();
    var baggageCost = _getTotalBaggageCost();
    var specialRequestsCost = _getTotalSpecialRequestsCost();
    var totalAddOns = _getTotalAddOnsCost();
    var grandTotal = baseFare + taxes + totalAddOns;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.primaryTextSwatch[50],
        border: Border.all(color: AppColors.primarySwatch[200]!),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Payment Summary",
              style: TextStyles.h6Style().copyWith(color: AppColors.primary)),
          SizedBox(height: 16.h),

          // Flight Charges Section
          Text("Flight Charges", style: TextStyles.bodyMediumSemiBoldStyle()),
          SizedBox(height: 8.h),
          getPriceDetaileWidget(
            "Base Fare",
            "₹ ${baseFare.toStringAsFixed(2)}",
          ),
          getPriceDetaileWidget(
            "Taxes & Fees",
            "₹ ${taxes.toStringAsFixed(2)}",
          ),

          // Add-ons Section (only if there are add-ons)
          if (totalAddOns > 0) ...[
            SizedBox(height: 12.h),
            Text("Add-ons", style: TextStyles.bodyMediumSemiBoldStyle()),
            SizedBox(height: 8.h),
            if (seatsCost > 0)
              getPriceDetaileWidget(
                "Seats",
                "₹ ${seatsCost.toStringAsFixed(2)}",
              ),
            if (mealsCost > 0)
              getPriceDetaileWidget(
                "Meals",
                "₹ ${mealsCost.toStringAsFixed(2)}",
              ),
            if (baggageCost > 0)
              getPriceDetaileWidget(
                "Extra Baggage",
                "₹ ${baggageCost.toStringAsFixed(2)}",
              ),
            if (specialRequestsCost > 0)
              getPriceDetaileWidget(
                "Special Requests",
                "₹ ${specialRequestsCost.toStringAsFixed(2)}",
              ),
          ],

          SizedBox(height: 8.h),
          Divider(
            color: AppColors.primarySwatch[300],
            thickness: 1.5,
            height: 16.h,
          ),

          // Grand Total
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total Amount",
                    style: TextStyles.bodyLargeBoldStyle()
                        .copyWith(color: AppColors.primary)),
                Text("₹ ${grandTotal.toStringAsFixed(2)}",
                    style: TextStyles.h5Style()
                        .copyWith(color: AppColors.primaryGreen)),
              ],
            ),
          ),

          // Subtotal breakdown in a highlighted box
          Container(
            margin: EdgeInsets.only(top: 8.h),
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: AppColors.primaryGreen.withAlpha(25),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppColors.primaryGreen.withAlpha(76),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "You Pay",
                      style: TextStyles.bodySmallSemiBoldStyle()
                          .copyWith(color: AppColors.primaryTextSwatch[600]),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      "₹ ${grandTotal.toStringAsFixed(2)}",
                      style: TextStyles.h5Style()
                          .copyWith(color: AppColors.primary),
                    ),
                  ],
                ),
                const Icon(
                  Icons.arrow_forward_rounded,
                  color: AppColors.primaryGreen,
                  size: 32,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var billingEntity = widget.bookingData.billingEntity;
    var passengerDetailsWIdgets = widget.bookingData.passengerDetails
        .map(getPassengerDetailsWidget)
        .toList();

    // Calculate grand total for button
    var baseFare = widget.orderUpdateResponse.priceData?.totalBaseAmount ?? 0;
    var taxes = widget.orderUpdateResponse.priceData?.airlineTaxes ?? 0;
    var totalAddOns = _getTotalAddOnsCost();
    var grandTotal = baseFare + taxes + totalAddOns;

    return Scaffold(
      appBar: BaseAppBar(
        title: "Payment",
        subTitle: "",
        shouldHaveRadius: false,
      ),
      bottomNavigationBar: SafeArea(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 12.h),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(25),
                blurRadius: 8,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Show total amount when not scrolled to pricing
              if (!_hasScrolledToPricing)
                Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total Amount",
                        style: TextStyles.bodyMediumSemiBoldStyle(),
                      ),
                      Text(
                        "₹ ${grandTotal.toStringAsFixed(2)}",
                        style: TextStyles.h6Style()
                            .copyWith(color: AppColors.primaryGreen),
                      ),
                    ],
                  ),
                ),
              CustomButton(
                  text: _hasScrolledToPricing
                      ? "Pay ₹ ${grandTotal.toStringAsFixed(2)}"
                      : "Pay Now",
                  onPressed: () async {
                    if (_loading) return;
                    WidgetUtil.showBottomSheet(
                        context,
                        FlightPaymentMethodListWidget(
                          paymentMediumStatusList: widget
                                  .orderUpdateResponse.paymentConfig?.status ??
                              [],
                          onPaymentMethodSelected: (paymentMedium) async {
                            try {
                              setState(() {
                                _loading = true;
                              });
                              var paymentUpdateRequest = UpdatePaymentRequest(
                                  paymentMedium: paymentMedium.mediumName!);
                              await _airUseCase.updateOrderPayment(
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
                                return OrderStatusScreen(
                                    orderStatus: orderStatus);
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
                  }),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
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
                  Text("Passenger Details",
                      style: TextStyles.bodyMediumSemiBoldStyle()),
                  SizedBox(height: 8.h),
                  ...passengerDetailsWIdgets,
                  getAddOnsSection(),
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
                  SizedBox(height: 24.h),
                  _buildPricingSection(),
                  SizedBox(height: 100.h), // Extra space for bottom nav
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
