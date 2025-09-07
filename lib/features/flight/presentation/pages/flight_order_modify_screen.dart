import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yellow_rose/core/common_widgets/base_appbar.dart';
import 'package:yellow_rose/core/common_widgets/button.dart';
import 'package:yellow_rose/core/common_widgets/custom_outline_button.dart';
import 'package:yellow_rose/core/common_widgets/loader.dart';
import 'package:yellow_rose/core/common_widgets/pill_button.dart';
import 'package:yellow_rose/core/common_widgets/popup.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/WidgetUtils.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order_status/air_order_iitinerary.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order_status/order_status.dart';
import 'package:yellow_rose/features/flight/presentation/cubit/flight_order_modify/flight_order_modify_cubit.dart';
import 'package:yellow_rose/features/flight/presentation/pages/order_status_screen.dart';
import 'package:yellow_rose/features/flight/presentation/widgets/order/ticket_details/air_ticekt_widget.dart';
import 'package:yellow_rose/features/flight/presentation/widgets/order/ticket_details/ticket_passenger_details.dart';

class FlightOrderModifyScreen extends StatelessWidget {
  static const String routeName = "/flightOrderModifyScreen";
  final AirOrderItinerary airOrderItinerary;
  final OrderStatus? orderStatus;
  const FlightOrderModifyScreen({
    super.key,
    required this.airOrderItinerary,
    this.orderStatus,
  });

  @override
  Widget build(BuildContext context) {
    var filteredPassengers = airOrderItinerary.orderPassengerDetails
        .where((element) =>
            element.pnrStatus != null &&
            element.pnrStatus!.toLowerCase() !=
                CANCELLED_PASSENGER_PNR_STATUS.toLowerCase())
        .toList();
    return Scaffold(
      appBar: BaseAppBar(
        title: "Modify Ticket",
        subTitle: "",
        shouldHaveRadius: false,
      ),
      body: BlocListener<FlightOrderModifyCubit, FlightOrderModifyState>(
        listener: (context, state) {
          if (!state.isLoading && state.errorMessage.isNotEmpty) {
            WidgetUtil.showSnackBar(
                "Error cancelling ticket,try again", context);
            context
                .read<FlightOrderModifyCubit>()
                .emit(state.copyWith(errorMessage: "", isLoading: false));
          }
          if (state.done) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (ctx) {
              return const OrderStatusScreen(
                  orderStatus: OrderStatusEnum.flight_cancel);
            }), (route) {
              return route.settings.name == "/";
            });
          }
        },
        child: BlocBuilder<FlightOrderModifyCubit, FlightOrderModifyState>(
          builder: (context, state) {
            return Stack(
              children: [
                SingleChildScrollView(
                  child: Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.primaryTextSwatch[200]!,
                            ),
                            borderRadius: BorderRadius.circular(8.h),
                          ),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 12.h),
                            child: Column(
                              children: [
                                Container(
                                  child: AirTicektFlightDetails(
                                    airOrderItinerary: airOrderItinerary,
                                    orderStatus: orderStatus,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 8.h),
                                  child: DottedLine(
                                    alignment: WrapAlignment.center,
                                    dashColor: AppColors.primarySwatch[400]!,
                                  ),
                                ),
                                Container(
                                    width: double.infinity,
                                    decoration: const BoxDecoration(
                                      color: AppColors.primaryGreen,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(8),
                                          topRight: Radius.circular(8)),
                                    ),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.w, vertical: 8.h),
                                      child: Text("Passengers",
                                          style:
                                              TextStyles.bodySmallMediumStyle()
                                                  .copyWith(
                                                      color: Colors.white)),
                                    )),
                                SizedBox(height: 8.h),
                                ListView.separated(
                                    shrinkWrap: true,
                                    itemBuilder: (ctx, idx) {
                                      return Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8.h),
                                          color: AppColors.primarySwatch[100],
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Name (${filteredPassengers[idx].passengerType?.description})",
                                                    style: TextStyles
                                                            .bodySmallSemiBoldStyle()
                                                        .copyWith(
                                                            color: AppColors
                                                                    .primaryTextSwatch[
                                                                500]),
                                                  ),
                                                  SizedBox(height: 4.h),
                                                  Text(
                                                    "${filteredPassengers[idx].firstName} ${filteredPassengers[idx].lastName}",
                                                    style: TextStyles
                                                        .bodyMediumBoldStyle(),
                                                  ),
                                                ],
                                              ),
                                              const Spacer(),
                                              Checkbox(
                                                  value: state.selectedPassenger
                                                      .contains(
                                                          filteredPassengers[
                                                                  idx]
                                                              .id),
                                                  onChanged: (_) {
                                                    context
                                                        .read<
                                                            FlightOrderModifyCubit>()
                                                        .togglePassengerSelection(
                                                            filteredPassengers[
                                                                    idx]
                                                                .id!);
                                                  })
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    separatorBuilder: (ctx, idx) {
                                      return SizedBox(height: 8.h);
                                    },
                                    itemCount: filteredPassengers.length)
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 24.h),
                        SizedBox(
                          width: double.infinity,
                          child: CustomOutlinedButton(
                            onPressed: state.selectedPassenger.isEmpty
                                ? null
                                : () {
                                    WidgetUtil.showPopup(context,
                                        icon: Image.asset(
                                          "assets/images/cacel_icon.png",
                                          height: 40.h,
                                        ),
                                        title:
                                            "Are you sure you want to cancel your Flight booking?",
                                        buttons: [
                                          PopupButton(
                                              text: "No",
                                              type: PopupButtonType.secondary,
                                              onPressed: () {}),
                                          PopupButton(
                                              text: "Yes",
                                              onPressed: () async {
                                                await context
                                                    .read<
                                                        FlightOrderModifyCubit>()
                                                    .onCancel();
                                              })
                                        ]);
                                  },
                            text: "Cancel Flight",
                            buttonType: OutlinedButtonType.danger,
                            textStyleOverride: TextStyle(
                                fontWeight:
                                    TextStyles.bodyLargeBoldStyle().fontWeight,
                                fontSize:
                                    TextStyles.bodyLargeBoldStyle().fontSize),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                if (state.isLoading) const Loader()
              ],
            );
          },
        ),
      ),
    );
  }
}
