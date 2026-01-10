import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yellow_rose/core/common_widgets/bottom_button.dart';
import 'package:yellow_rose/core/common_widgets/button.dart';
import 'package:yellow_rose/core/common_widgets/custom_outline_button.dart';
import 'package:yellow_rose/core/common_widgets/popup.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/core/utils/WidgetUtils.dart';
import 'package:yellow_rose/features/trip/data/models/trip_response.dart';
import 'package:yellow_rose/features/trip/data/models/trip_status_enum.dart';
import 'package:yellow_rose/features/trip/domain/entities/trip_approval_response_status.dart';
import 'package:yellow_rose/features/trip/presentation/cubit/trip_cubit.dart';

class TripBottomBar extends StatefulWidget {
  final TripResponse trip;
  final Map<String, dynamic> orderDetails;
  final TripApprovalResponseStatus? approvalStatus;
  final VoidCallback onApprovalStatusChanged;

  const TripBottomBar({
    super.key,
    required this.trip,
    required this.orderDetails,
    this.approvalStatus,
    required this.onApprovalStatusChanged,
  });

  @override
  State<TripBottomBar> createState() => _TripBottomBarState();
}

class _TripBottomBarState extends State<TripBottomBar> {
  bool _isApprovingOrDenying = false;

  @override
  Widget build(BuildContext context) {
    if (widget.orderDetails.isEmpty) return const SizedBox.shrink();

    final isNewStatus = widget.trip.status == TripStatusEnum.NEW ||
        widget.trip.status?.code == 'N';

    final isCancellableStatus = widget.trip.status == TripStatusEnum.BOOKED ||
        widget.trip.status == TripStatusEnum.PARTIALLYBOOKED ||
        widget.trip.status == TripStatusEnum.PARTIALCANCELLED;

    final totalPrice = _calculateTotalPrice(widget.trip);

    return BlocConsumer<TripCubit, TripState>(
      listener: (context, state) {
        if (state is TripError) {
          WidgetUtil.showSnackBar(state.message, context);
        }
      },
      builder: (context, state) {
        final isTeamTrip = state is TripLoaded && state.isViewingTeamTrip;

        if (isTeamTrip) {
          return _buildTeamTripBottomBar(context);
        }

        if (isNewStatus) {
          return _buildNewTripBottomBar(context, totalPrice);
        }

        if (isCancellableStatus) {
          return _buildCancelTripBottomBar(context);
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildTeamTripBottomBar(BuildContext context) {
    final showApprovalButtons =
        widget.approvalStatus == TripApprovalResponseStatus.REVIEW;

    if (!showApprovalButtons) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: EdgeInsets.all(16.w),
      margin: EdgeInsets.only(bottom: 24.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: _isApprovingOrDenying
          ? const Center(child: CircularProgressIndicator())
          : Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: 'Approve',
                    onPressed: () => _handleApproveTrip(context),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: CustomOutlinedButton(
                    text: 'Deny',
                    buttonType: OutlinedButtonType.danger,
                    onPressed: () => _handleDenyTrip(context),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildNewTripBottomBar(BuildContext context, double totalPrice) {
    return SizedBox(
      height: 100.h,
      child: BottomButton(
        title: '₹${totalPrice.toStringAsFixed(2)}',
        subtitle: 'Total Trip Cost',
        buttonText: 'Send for Approval',
        onClick: () async {
          try {
            await context.read<TripCubit>().sendTripForApproval();
            if (context.mounted) {
              WidgetUtil.showSnackBar(
                  'Trip sent for approval successfully', context,
                  col: AppColors.primaryGreen);
            }
          } catch (e) {
            if (context.mounted) {
              WidgetUtil.showSnackBar(
                  'Failed to send trip for approval', context);
            }
          }
        },
      ),
    );
  }

  Widget _buildCancelTripBottomBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      margin: EdgeInsets.only(bottom: 24.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: _isApprovingOrDenying
          ? const Center(child: CircularProgressIndicator())
          : CustomOutlinedButton(
              text: 'Cancel Trip',
              buttonType: OutlinedButtonType.danger,
              onPressed: () => _handleCancelTrip(context),
            ),
    );
  }

  double _calculateTotalPrice(TripResponse trip) {
    return trip.tripItemList?.fold(
            0.0, (prev, element) => prev! + (element.itineraryCost ?? 0.0)) ??
        0.0;
  }

  Future<void> _handleApproveTrip(BuildContext context) async {
    if (widget.trip.tripUid == null) return;

    _showApprovalDialog(
      context,
      title: "Are you sure you want to approve this trip?",
      iconPath: "assets/images/order_success.png",
      iconHeight: 100.h,
      onConfirm: () async {
        setState(() => _isApprovingOrDenying = true);

        try {
          await context.read<TripCubit>().approveTrip(widget.trip.tripUid!, '');

          widget.onApprovalStatusChanged();
          context.read<TripCubit>().refereshSelectedTrip();

          if (mounted) {
            WidgetUtil.showSnackBar(
              'Trip approved successfully',
              context,
              col: AppColors.primaryGreen,
            );
          }
        } catch (e) {
          if (mounted) {
            WidgetUtil.showSnackBar(
              'Failed to approve trip, try again',
              context,
            );
          }
        } finally {
          if (mounted) {
            setState(() => _isApprovingOrDenying = false);
          }
        }
      },
    );
  }

  Future<void> _handleDenyTrip(BuildContext context) async {
    if (widget.trip.tripUid == null) return;

    _showApprovalDialog(
      context,
      title: "Are you sure you want to deny this trip?",
      iconPath: "assets/images/cacel_icon.png",
      iconHeight: 40.h,
      onConfirm: () async {
        setState(() => _isApprovingOrDenying = true);

        try {
          await context.read<TripCubit>().denyTrip(widget.trip.tripUid!, '');

          widget.onApprovalStatusChanged();

          if (mounted) {
            WidgetUtil.showSnackBar(
              'Trip denied successfully',
              context,
              col: AppColors.primaryGreen,
            );
          }
        } catch (e) {
          if (mounted) {
            WidgetUtil.showSnackBar(
              'Failed to deny trip: ${e.toString()}',
              context,
            );
          }
        } finally {
          if (mounted) {
            setState(() => _isApprovingOrDenying = false);
          }
        }
      },
    );
  }

  Future<void> _handleCancelTrip(BuildContext context) async {
    _showApprovalDialog(
      context,
      title: "Are you sure you want to cancel this entire trip?",
      iconPath: "assets/images/cacel_icon.png",
      iconHeight: 40.h,
      onConfirm: () async {
        setState(() => _isApprovingOrDenying = true);

        try {
          await context.read<TripCubit>().cancelTrip();

          if (mounted) {
            WidgetUtil.showSnackBar(
              'Trip cancelled successfully',
              context,
              col: AppColors.primaryGreen,
            );
          }
        } catch (e) {
          if (mounted) {
            WidgetUtil.showSnackBar(
              'Failed to cancel trip: ${e.toString()}',
              context,
            );
          }
        } finally {
          if (mounted) {
            setState(() => _isApprovingOrDenying = false);
          }
        }
      },
    );
  }

  void _showApprovalDialog(
    BuildContext context, {
    required String title,
    required String iconPath,
    required double iconHeight,
    required VoidCallback onConfirm,
  }) {
    WidgetUtil.showPopup(
      context,
      icon: Image.asset(iconPath, height: iconHeight),
      title: title,
      buttons: [
        PopupButton(
          text: "No",
          type: PopupButtonType.secondary,
          onPressed: () {},
        ),
        PopupButton(
          text: "Yes",
          onPressed: onConfirm,
        ),
      ],
    );
  }
}
