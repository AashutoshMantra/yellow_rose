import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yellow_rose/core/common_widgets/bottom_button.dart';
import 'package:yellow_rose/core/common_widgets/bottom_sheet_title_widget.dart';
import 'package:yellow_rose/core/common_widgets/pill_button.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/features/bus/data/models/search/bus_operator_detail.dart';
import 'package:yellow_rose/features/bus/domain/entities/bus_search_filter.dart';
import 'package:yellow_rose/features/bus/presentation/cubit/bus_search_filter/bus_search_filter_cubit.dart';

class BusSearchFilterScreen extends StatelessWidget {
  final BusSearchFilterState? filterState;
  final List<String> pickupPoints;
  final List<String> dropPoints;
  final Function? onClick;
  final List<BusOperatorDetail> operatorDetails;

  const BusSearchFilterScreen({
    super.key,
    this.filterState,
    this.pickupPoints = const [],
    this.dropPoints = const [],
    this.onClick,
    this.operatorDetails = const [],
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BusSearchFilterCubit(busSearchState: filterState),
      child: BlocBuilder<BusSearchFilterCubit, BusSearchFilterState>(
        builder: (context, state) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * .85,
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const BottomSheetTitleWidget(title: "Filter"),
                      SizedBox(height: 12.h),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Sort",
                                style: TextStyles.bodyLargeBoldStyle().copyWith(
                                  color: AppColors.primaryTextSwatch[500],
                                ),
                              ),
                              SizedBox(height: 20.h),
                              Wrap(
                                spacing: 10.h,
                                runSpacing: 16.h,
                                children: [
                                  ...BusSortBy.values.map((busSortBy) {
                                    return PillButton(
                                      text: busSortBy.text,
                                      onClick: () {
                                        context
                                            .read<BusSearchFilterCubit>()
                                            .onChangeSortBy(busSortBy);
                                      },
                                      pillType: state.sortBy == busSortBy
                                          ? PillType.primary
                                          : PillType.secondary,
                                    );
                                  })
                                ],
                              ),
                              SizedBox(height: 30.h),
                              Text(
                                "Departure Time",
                                style: TextStyles.bodyLargeBoldStyle().copyWith(
                                  color: AppColors.primaryTextSwatch[500],
                                ),
                              ),
                              SizedBox(height: 20.h),
                              Wrap(
                                spacing: 10.h,
                                runSpacing: 16.h,
                                alignment: WrapAlignment.start,
                                children: [
                                  ...BusTiming.values.map((busTiming) {
                                    return PillButton(
                                      text:
                                          "${busTiming.text}\n(${busTiming.timing})",
                                      onClick: () {
                                        context
                                            .read<BusSearchFilterCubit>()
                                            .onClickDepartureTimingFilter(
                                                busTiming);
                                      },
                                      pillType: state.departureTiming
                                              .contains(busTiming)
                                          ? PillType.primary
                                          : PillType.secondary,
                                    );
                                  })
                                ],
                              ),
                              SizedBox(height: 30.h),
                              Text(
                                "Bus Type",
                                style: TextStyles.bodyLargeBoldStyle().copyWith(
                                  color: AppColors.primaryTextSwatch[500],
                                ),
                              ),
                              SizedBox(height: 20.h),
                              Wrap(
                                spacing: 10.h,
                                runSpacing: 16.h,
                                alignment: WrapAlignment.start,
                                children: [
                                  ...BusType.values.map((busType) {
                                    return PillButton(
                                      text: busType.text,
                                      onClick: () {
                                        context
                                            .read<BusSearchFilterCubit>()
                                            .onClickBusTypeFilter(busType);
                                      },
                                      pillType: state.busTypes.contains(busType)
                                          ? PillType.primary
                                          : PillType.secondary,
                                    );
                                  })
                                ],
                              ),
                              if (pickupPoints.isNotEmpty) ...[
                                SizedBox(height: 30.h),
                                Text(
                                  "Pickup Points",
                                  style:
                                      TextStyles.bodyLargeBoldStyle().copyWith(
                                    color: AppColors.primaryTextSwatch[500],
                                  ),
                                ),
                                SizedBox(height: 20.h),
                                Wrap(
                                  spacing: 10.h,
                                  runSpacing: 16.h,
                                  alignment: WrapAlignment.start,
                                  children: [
                                    ...pickupPoints.map((pickupPoint) {
                                      return PillButton(
                                        text: pickupPoint,
                                        onClick: () {
                                          context
                                              .read<BusSearchFilterCubit>()
                                              .onClickPickupPointFilter(
                                                  pickupPoint);
                                        },
                                        pillType: state.pickupPoints
                                                .contains(pickupPoint)
                                            ? PillType.primary
                                            : PillType.secondary,
                                      );
                                    })
                                  ],
                                ),
                              ],
                              if (dropPoints.isNotEmpty) ...[
                                SizedBox(height: 30.h),
                                Text(
                                  "Drop Points",
                                  style:
                                      TextStyles.bodyLargeBoldStyle().copyWith(
                                    color: AppColors.primaryTextSwatch[500],
                                  ),
                                ),
                                SizedBox(height: 20.h),
                                Wrap(
                                  spacing: 10.h,
                                  runSpacing: 16.h,
                                  alignment: WrapAlignment.start,
                                  children: [
                                    ...dropPoints.map((dropPoint) {
                                      return PillButton(
                                        text: dropPoint,
                                        onClick: () {
                                          context
                                              .read<BusSearchFilterCubit>()
                                              .onClickDropPointFilter(
                                                  dropPoint);
                                        },
                                        pillType:
                                            state.dropPoints.contains(dropPoint)
                                                ? PillType.primary
                                                : PillType.secondary,
                                      );
                                    })
                                  ],
                                ),
                              ],
                              if (operatorDetails.isNotEmpty) ...[
                                SizedBox(height: 30.h),
                                Text(
                                  "Operators",
                                  style:
                                      TextStyles.bodyLargeBoldStyle().copyWith(
                                    color: AppColors.primaryTextSwatch[500],
                                  ),
                                ),
                                SizedBox(height: 20.h),
                                Wrap(
                                  spacing: 10.h,
                                  runSpacing: 16.h,
                                  alignment: WrapAlignment.start,
                                  children: [
                                    ...operatorDetails.map((operatorDetail) {
                                      return PillButton(
                                        text: operatorDetail.operatorName ??
                                            'Unknown Operator',
                                        onClick: () {
                                          context
                                              .read<BusSearchFilterCubit>()
                                              .onClickOperatorFilter(
                                                  operatorDetail);
                                        },
                                        pillType: state.operators
                                                .contains(operatorDetail)
                                            ? PillType.primary
                                            : PillType.secondary,
                                      );
                                    })
                                  ],
                                ),
                              ],
                              SizedBox(height: 120.h),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: double.infinity,
                    height: 95.h,
                    child: BottomButton(
                      title: "",
                      onClick: () {
                        Navigator.of(context).pop(state);
                      },
                      buttonText: "Apply",
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
