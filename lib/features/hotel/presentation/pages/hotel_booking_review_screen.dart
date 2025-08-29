import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yellow_rose/core/common_widgets/base_appbar.dart';
import 'package:yellow_rose/core/common_widgets/loader.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/WidgetUtils.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/features/flight/presentation/widgets/bottom_button.dart';
import 'package:yellow_rose/features/hotel/presentation/cubit/hotel_book_cubit/hotel_book_cubit.dart';
import 'package:yellow_rose/features/hotel/presentation/pages/hotel_payment_screen.dart';
import 'package:yellow_rose/features/hotel/presentation/widgets/detail/hotel_high_list_section.dart';
import 'package:yellow_rose/features/hotel/presentation/widgets/detail/hotel_penalty_widget.dart';
import 'package:yellow_rose/features/hotel/presentation/widgets/detail/mmt_hotel_policy.dart';

class HotelBookingReviewScreen extends StatefulWidget {
  static const routeName = "/hotelBookingReviewScreen";
  const HotelBookingReviewScreen({super.key});

  @override
  State<HotelBookingReviewScreen> createState() =>
      _HotelBookingReviewScreenState();
}

class _HotelBookingReviewScreenState extends State<HotelBookingReviewScreen> {
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  bool _agreeTerms = false;
  bool _confirmDetails = false;
  bool _agreePolicy = false;

  bool get _canProcess => _agreeTerms && _confirmDetails && _agreePolicy;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _loading,
      builder: (context, loading, _) {
        return Stack(
          children: [
            Scaffold(
              appBar: BaseAppBar(
                  title: "Booking Review", subTitle: "Review your booking"),
              bottomNavigationBar: BlocBuilder<HotelBookCubit, HotelBookState>(
                builder: (context, state) {
                  if (state is HotelBookLoaded) {
                    return SizedBox(
                      height: 95.h,
                      width: double.infinity,
                      child: BottomButton(
                        buttonText: _canProcess ? "Proceed" : "Proceed",
                        title:
                            "\u20b9 ${state.selectedRoom.hotelRooms[0].totalcost.toStringAsFixed(1)}",
                        subtitle: "Total Cost",
                        onClick: () async {
                          if (!_canProcess) {
                            WidgetUtil.showSnackBar(
                                "Please accept terms and confirm details to proceed",
                                context);
                            return;
                          }

                          Navigator.pushNamed(
                              context, HotelPaymentScreen.routeName,
                              arguments: {
                                "cubit": context.read<HotelBookCubit>()
                              });
                        },
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
              body: BlocBuilder<HotelBookCubit, HotelBookState>(
                builder: (context, state) {
                  if (state is HotelBookLoaded) {
                    return SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 16.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Simple hotel summary (using available data from HotelDetailResponse and HotelSearch)
                            // Hotel summary (more prominent)
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(12.h),
                              decoration: BoxDecoration(
                                color: AppColors.primaryTextSwatch[50],
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: AppColors.primarySwatch[200]!,
                                  width: 1,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(state.hotel.hotel?.name ?? '',
                                      style:
                                          TextStyles.bodyMediumSemiBoldStyle()
                                              .copyWith(fontSize: 18)),
                                  SizedBox(height: 6.h),
                                  Text(state.hotel.hotel?.address ?? '',
                                      style: TextStyles.bodySmallStyle()
                                          .copyWith(
                                              color: AppColors
                                                  .primaryTextSwatch[600])),
                                  SizedBox(height: 12.h),
                                  // Check-in / Check-out rounded pills
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10.h, horizontal: 12.w),
                                          decoration: BoxDecoration(
                                            color: AppColors.primarySwatch[100],
                                            borderRadius:
                                                BorderRadius.circular(40),
                                            border: Border.all(
                                                color: AppColors
                                                    .primaryTextSwatch[200]!),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text('Check-in',
                                                  style: TextStyles
                                                          .bodySmallStyle()
                                                      .copyWith(
                                                          color: AppColors
                                                                  .primaryTextSwatch[
                                                              500])),
                                              SizedBox(height: 6.h),
                                              Text(
                                                state.hotelSearch.checkInDate !=
                                                        null
                                                    ? state.hotelSearch
                                                        .checkInDate!
                                                        .toLocal()
                                                        .toString()
                                                        .split(' ')
                                                        .first
                                                    : '',
                                                style: TextStyles
                                                    .bodyMediumSemiBoldStyle(),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 12.w),
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10.h, horizontal: 12.w),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(40),
                                            border: Border.all(
                                                color: AppColors
                                                    .primaryTextSwatch[200]!),
                                            color: AppColors.primarySwatch[100],
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text('Check-out',
                                                  style: TextStyles
                                                          .bodySmallStyle()
                                                      .copyWith(
                                                          color: AppColors
                                                                  .primaryTextSwatch[
                                                              500])),
                                              SizedBox(height: 6.h),
                                              Text(
                                                state.hotelSearch
                                                            .checkOutDate !=
                                                        null
                                                    ? state.hotelSearch
                                                        .checkOutDate!
                                                        .toLocal()
                                                        .toString()
                                                        .split(' ')
                                                        .first
                                                    : '',
                                                style: TextStyles
                                                    .bodyMediumSemiBoldStyle(),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 12.h),
                            _sectionTitle("Room Details"),
                            _roomDetails(state),
                            SizedBox(height: 12.h),
                            _sectionTitle("Guest Details"),
                            _guestDetails(state),
                            SizedBox(height: 12.h),
                            _sectionTitle("Special Requests"),
                            _specialRequest(state),
                            SizedBox(height: 12.h),
                            if (state.hotel.hotel?.checkInInstruction != null)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _sectionTitle("Check-in Instruction"),
                                  SizedBox(height: 6.h),
                                  Text(state.hotel.hotel!.checkInInstruction!),
                                ],
                              ),
                            SizedBox(height: 12.h),
                            if (state.selectedRoom.hotelRooms.firstOrNull
                                    ?.hotelRoomPenalty !=
                                null)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _sectionTitle("Penalties "),
                                  HotelPenaltyTable(
                                      penalties: state.selectedRoom.hotelRooms
                                          .firstOrNull!.hotelRoomPenalty!)
                                ],
                              ),
                            SizedBox(height: 12.h),

                            if (state.hotel.hotel?.expediaPolicies
                                    ?.knowBeforeYouGo !=
                                null)
                              Container(
                                margin: EdgeInsets.only(top: 16.h),
                                child: PropertyHighlightsSection(
                                    title: "Policy",
                                    htmlContent: state.hotel.hotel!
                                        .expediaPolicies!.knowBeforeYouGo!),
                              ),
                            if (state.hotel.hotel?.mmtPolicies?.isNotEmpty ==
                                true)
                              Container(
                                margin: EdgeInsets.only(top: 16.h),
                                child: MmtHotelPolicy(
                                    policies: state.hotel.hotel!.mmtPolicies!),
                              ),
                            SizedBox(height: 16.h),
                            _termsCheckboxes(),
                            SizedBox(height: 90.h),
                          ],
                        ),
                      ),
                    );
                  }
                  return const Loader();
                },
              ),
            ),
            if (loading) const Loader()
          ],
        );
      },
    );
  }

  Widget _sectionTitle(String title) =>
      Text(title, style: TextStyles.h6Style());

  Widget _roomDetails(HotelBookLoaded state) {
    final room = state.selectedRoom;
    final roomType = room.hotelRooms.first;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.primaryTextSwatch[50],
        border: Border.all(color: AppColors.primarySwatch[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(room.name ?? '', style: TextStyles.bodyMediumSemiBoldStyle()),
          SizedBox(height: 8.h),
          Text(roomType.name ?? '', style: TextStyles.bodySmallStyle()),
          SizedBox(height: 8.h),
          Text("Price: \u20b9 ${roomType.totalcost.toStringAsFixed(2)}"),
        ],
      ),
    );
  }

  Widget _guestDetails(HotelBookLoaded state) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(4.h),
      child: Column(
        children: state.passengerDetails.map((p) {
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 18.h,
                      backgroundColor: AppColors.primaryGreen,
                      child:
                          Icon(Icons.person, size: 18.h, color: Colors.white),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${p.title.name} ${p.name} ${p.lastName}",
                            style: TextStyles.bodyMediumSemiBoldStyle()
                                .copyWith(fontSize: 15),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            p.passengerType.description,
                            style: TextStyles.bodySmallStyle().copyWith(
                                color: AppColors.primaryTextSwatch[600]),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(color: AppColors.primaryTextSwatch[100]),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _specialRequest(HotelBookLoaded state) {
    final req = state.specialRequest;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.primaryTextSwatch[50],
        border: Border.all(color: AppColors.primarySwatch[200]!),
      ),
      child: Text(req?.toString() ?? "No special requests"),
    );
  }

  Widget _termsCheckboxes() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CheckboxListTile(
          value: _agreeTerms,
          onChanged: (v) => setState(() => _agreeTerms = v ?? false),
          title: const Text("I accept the Terms & Conditions"),
          controlAffinity: ListTileControlAffinity.leading,
        ),
        CheckboxListTile(
          value: _confirmDetails,
          onChanged: (v) => setState(() => _confirmDetails = v ?? false),
          title: const Text("I confirm the details are correct"),
          controlAffinity: ListTileControlAffinity.leading,
        ),
        CheckboxListTile(
          value: _agreePolicy,
          onChanged: (v) => setState(() => _agreePolicy = v ?? false),
          title: const Text("I agree to the cancellation & refund policy"),
          controlAffinity: ListTileControlAffinity.leading,
        ),
      ],
    );
  }
}
