import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yellow_rose/core/common_widgets/bottom_button.dart';
import 'package:yellow_rose/core/common_widgets/button.dart';
import 'package:yellow_rose/core/common_widgets/custom_outline_button.dart';
import 'package:yellow_rose/core/common_widgets/loader.dart';
import 'package:yellow_rose/core/common_widgets/popup.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/core/utils/WidgetUtils.dart';
import 'package:yellow_rose/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:yellow_rose/features/trip/data/models/trip_approver.dart';
import 'package:yellow_rose/features/trip/data/models/trip_response.dart';
import 'package:yellow_rose/features/trip/data/models/trip_status_enum.dart';
import 'package:yellow_rose/features/trip/presentation/cubit/trip_cubit.dart';
import 'package:yellow_rose/features/trip/presentation/widgets/trip_detail/trip_notes_sheet.dart';

class TripBottomBar extends StatefulWidget {
  final TripResponse trip;
  final Map<String, dynamic> orderDetails;
  final TripApprover? pendingApproval;
  final VoidCallback onApprovalStatusChanged;

  const TripBottomBar({
    super.key,
    required this.trip,
    required this.orderDetails,
    this.pendingApproval,
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
    if (widget.pendingApproval == null) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: EdgeInsets.all(16.w),
      margin: EdgeInsets.only(bottom: 24.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: _isApprovingOrDenying
          ? _buildLoadingIndicator()
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
    var isTripAdmin = context.read<AuthCubit>().isTripAdmin;
    return SizedBox(
      height: 100.h,
      child: BottomButton(
        title: '₹${totalPrice.toStringAsFixed(2)}',
        subtitle: 'Total Trip Cost',
        buttonText: isTripAdmin ? "Book" : 'Send for Approval',
        onClick: () async {
          final tripCubit = context.read<TripCubit>();
          String? notes;
          if (!isTripAdmin) {
            final result = await WidgetUtil.showBottomSheet(
              context,
              const TripNotesSheet(
                title: 'Send for Approval',
                buttonText: 'Send for Approval',
              ),
            );
            if (result == null || result is! String) return;
            notes = result;
          }
          try {
            await tripCubit.sendTripForApproval(notes: notes);
            if (context.mounted) {
              WidgetUtil.showSnackBar(
                  isTripAdmin
                      ? "Trip booked successfully"
                      : 'Trip sent for approval successfully',
                  context,
                  col: AppColors.primaryGreen);
            }
          } catch (e) {
            if (context.mounted) {
              WidgetUtil.showSnackBar(
                  isTripAdmin
                      ? "Failed to book trip"
                      : 'Failed to send trip for approval',
                  context);
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
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: _isApprovingOrDenying
          ? _buildLoadingIndicator()
          : CustomOutlinedButton(
              text: 'Cancel Trip',
              buttonType: OutlinedButtonType.danger,
              onPressed: () => _handleCancelTrip(context),
            ),
    );
  }

  Widget _buildLoadingIndicator() {
    return SizedBox(
      height: 48.h,
      child: const Loader(color: Colors.transparent),
    );
  }

  double _calculateTotalPrice(TripResponse trip) {
    return trip.tripItemList?.fold(
            0.0, (prev, element) => prev! + (element.itineraryCost ?? 0.0)) ??
        0.0;
  }

  Future<void> _handleApproveTrip(BuildContext context) async {
    if (widget.trip.tripUid == null) return;

    final notes = await WidgetUtil.showBottomSheet(
      context,
      const TripNotesSheet(title: 'Approve Trip', buttonText: 'Approve'),
    );
    if (notes == null || notes is! String || !context.mounted) return;

    final tripCubit = context.read<TripCubit>();
    setState(() => _isApprovingOrDenying = true);

    try {
      await tripCubit.approveTrip(
          widget.trip.tripUid!, notes, widget.pendingApproval!);

      widget.onApprovalStatusChanged();
      tripCubit.refereshSelectedTrip();

      if (mounted) {
        WidgetUtil.showSnackBar(
          'Trip approved successfully',
          context,
          col: AppColors.primaryGreen,
        );
      }
    } catch (e, s) {
      log("Error approving trip: $e $s");
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
  }

  Future<void> _handleDenyTrip(BuildContext context) async {
    if (widget.trip.tripUid == null) return;

    final notes = await WidgetUtil.showBottomSheet(
      context,
      const TripNotesSheet(
        title: 'Deny Trip',
        buttonText: 'Deny',
        isRequired: true,
      ),
    );
    if (notes == null || notes is! String || !context.mounted) return;

    final tripCubit = context.read<TripCubit>();
    setState(() => _isApprovingOrDenying = true);

    try {
      await tripCubit.denyTrip(
          widget.trip.tripUid!, notes, widget.pendingApproval!);

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
