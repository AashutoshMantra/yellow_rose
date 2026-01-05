import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yellow_rose/core/common_widgets/base_appbar.dart';
import 'package:yellow_rose/core/common_widgets/bottom_button.dart';
import 'package:yellow_rose/core/common_widgets/button.dart';
import 'package:yellow_rose/core/common_widgets/custom_outline_button.dart';
import 'package:yellow_rose/core/common_widgets/image_icon_button.dart';
import 'package:yellow_rose/core/common_widgets/loader.dart';
import 'package:yellow_rose/core/common_widgets/popup.dart';
import 'package:yellow_rose/core/constants/supported_service.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/core/utils/WidgetUtils.dart';
import 'package:yellow_rose/dependncy_injection.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order_status/order_status.dart';
import 'package:yellow_rose/features/flight/data/models/product_type.dart';
import 'package:yellow_rose/features/flight/domain/usecases/air_usecase.dart';
import 'package:yellow_rose/features/home_screen/presentation/pages/home_screen.dart';
import 'package:yellow_rose/features/home_screen/presentation/widgets/air/air_order_detail_card.dart';
import 'package:yellow_rose/features/home_screen/presentation/widgets/bus/bus_order_detail_card.dart';
import 'package:yellow_rose/features/home_screen/presentation/widgets/hotel/hotel_order_detail_card.dart';
import 'package:yellow_rose/features/trip/data/models/trip_item.dart';
import 'package:yellow_rose/features/trip/data/models/trip_response.dart';
import 'package:yellow_rose/features/trip/data/models/trip_status_enum.dart';
import 'package:yellow_rose/features/trip/domain/entities/trip_approval_response_status.dart';
import 'package:yellow_rose/features/trip/presentation/cubit/trip_cubit.dart';

class TripDetailScreen extends StatefulWidget {
  static const String routeName = '/trip-detail';

  const TripDetailScreen({super.key});

  @override
  State<TripDetailScreen> createState() => _TripDetailScreenState();
}

class _TripDetailScreenState extends State<TripDetailScreen> {
  final _airUseCase = getIt<AirUseCase>();

  final Map<String, OrderStatus> _orderDetails = {};
  bool _isLoading = true;
  String? _error;
  Timer? _refreshTimer;
  TripApprovalResponseStatus? _approvalStatus;
  bool _isApprovingOrDenying = false;

  @override
  void initState() {
    super.initState();
    _loadTripServices();
    _startAutoRefresh();
    _loadApprovalStatusIfTeamTrip();
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }

  void _startAutoRefresh() {
    _refreshTimer = Timer.periodic(const Duration(seconds: 30), (timer) {
      _refreshTrip();
    });
  }

  Future<void> _refreshTrip() async {
    context.read<TripCubit>().refereshSelectedTrip();
    await Future.delayed(const Duration(milliseconds: 500));
    await _loadTripServices(showLoading: false);
    await _loadApprovalStatusIfTeamTrip();
  }

  Future<void> _loadApprovalStatusIfTeamTrip() async {
    final isTeamTrip = context.read<TripCubit>().isViewingTeamTrip;
    if (!isTeamTrip) return;

    final tripState = context.read<TripCubit>().state;
    if (tripState is! TripLoaded) return;

    final trip = tripState.selectedTrip;
    if (trip?.tripUid == null) return;

    try {
      final response =
          await context.read<TripCubit>().getTripApprovalStatus(trip!.tripUid!);
      if (mounted) {
        setState(() {
          _approvalStatus = response.status;
        });
      }
    } catch (e) {
      debugPrint('Error loading approval status: $e');
    }
  }

  final _supportedServiceForTrip = [
    SupportedService.Flights,
    SupportedService.Hotels
  ];

  bool _isServiceInTrip(TripResponse trip, SupportedService service) {
    final tripItems = trip.tripItemList ?? [];
    return tripItems.any((item) {
      if (service == SupportedService.Flights) {
        return item.type == ProductTypeEnum.AIR;
      } else if (service == SupportedService.Hotels) {
        return item.type == ProductTypeEnum.HOTEL;
      }
      return false;
    });
  }

  Future<void> _loadTripServices({bool showLoading = true}) async {
    var tripState = context.read<TripCubit>().state;
    if (tripState is! TripLoaded) {
      return;
    }
    var trip = tripState.selectedTrip!;
    if (showLoading) {
      setState(() {
        _isLoading = true;
        _error = null;
        _orderDetails.clear();
      });
    }

    try {
      final tripItems = trip.tripItemList ?? [];

      for (var item in tripItems) {
        if (item.cartId != null) {
          try {
            final orderStatus =
                await _airUseCase.getDetailedOrderStauts(item.cartId!);
            _orderDetails[item.cartId!] = orderStatus;
          } catch (e) {
            debugPrint('Error loading order ${item.cartId}: $e');
          }
        }
      }

      if (showLoading) {
        setState(() {
          _isLoading = false;
        });
      } else {
        setState(() {});
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _error = 'Failed to load trip services';
      });
    }
  }

  Widget _buildStatusBanner(TripResponse trip) {
    final status = trip.status;
    if (status == null) return const SizedBox.shrink();

    final statusColor = _getStatusColor(status);
    final statusIcon = _getStatusIcon(status);

    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            statusColor.withOpacity(0.15),
            statusColor.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: statusColor.withOpacity(0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: statusColor.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: statusColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: statusColor.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                statusIcon,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Current Status',
                    style: TextStyles.bodySmallStyle().copyWith(
                      color: AppColors.primaryTextSwatch[500],
                      fontSize: 11,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    status.description,
                    style: TextStyles.bodyLargeBoldStyle().copyWith(
                      color: statusColor,
                      fontSize: 18,
                      height: 1.2,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: statusColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                status.code,
                style: TextStyles.bodySmallBoldStyle().copyWith(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TripCubit, TripState>(
      listener: (context, state) {
        if (state is TripLoaded) {
          _loadTripServices();
        }
      },
      child: BlocBuilder<TripCubit, TripState>(
        builder: (context, state) {
          return Scaffold(
            appBar: BaseAppBar(
              title: (state is TripLoaded)
                  ? state.selectedTrip?.tripName ?? 'Trip Details'
                  : 'Trip Details',
            ),
            body: Column(
              children: [
                if (state is TripLoaded)
                  _buildStatusBanner(state.selectedTrip!),
                Expanded(
                  child: (state is! TripLoaded || _isLoading)
                      ? const Center(
                          child: Loader(color: Colors.transparent),
                        )
                      : _error != null
                          ? _buildError()
                          : RefreshIndicator(
                              onRefresh: _refreshTrip,
                              child: SingleChildScrollView(
                                physics: const AlwaysScrollableScrollPhysics(),
                                child: Padding(
                                  padding: EdgeInsets.all(24.h),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (!state.isViewingTeamTrip &&
                                          (state).selectedTrip?.status ==
                                              TripStatusEnum.NEW)
                                        if (_supportedServiceForTrip.any((s) =>
                                            !_isServiceInTrip(
                                                state.selectedTrip!, s))) ...[
                                          Text(
                                            'Add Services',
                                            style:
                                                TextStyles.bodyLargeBoldStyle(),
                                          ),
                                          SizedBox(height: 16.h),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: _supportedServiceForTrip
                                                .map((supportedService) {
                                              final isAdded = _isServiceInTrip(
                                                  (state).selectedTrip!,
                                                  supportedService);
                                              return ImageIconButton(
                                                onClick: isAdded
                                                    ? null
                                                    : () {
                                                        navigateToService(
                                                            context,
                                                            supportedService);
                                                      },
                                                image: AssetImage(
                                                    "assets/images/icons/${supportedService.getImagePath()}.png"),
                                                title: supportedService.name,
                                              );
                                            }).toList(),
                                          ),
                                          SizedBox(height: 24.h),
                                        ],
                                      Text(
                                        'Trip Cart',
                                        style: TextStyles.bodyLargeBoldStyle(),
                                      ),
                                      SizedBox(height: 16.h),
                                      _buildTripCart(state.selectedTrip!),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                )
              ],
            ),
            bottomNavigationBar: state is TripLoaded
                ? _buildBottomBar(context, state.selectedTrip!)
                : null,
          );
        },
      ),
    );
  }

  Widget _buildError() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Error loading trip services',
              style: TextStyles.bodyLargeMediumStyle(),
            ),
            SizedBox(height: 8.h),
            Text(
              _error!,
              style: TextStyles.bodySmallMediumStyle().copyWith(
                color: AppColors.primaryTextSwatch[500],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTripCart(TripResponse trip) {
    final tripItems = trip.tripItemList ?? [];

    if (tripItems.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 32.h),
          child: Column(
            children: [
              Icon(
                Icons.luggage_outlined,
                size: 64.h,
                color: AppColors.primaryTextSwatch[300],
              ),
              SizedBox(height: 16.h),
              Text(
                'No services in this trip',
                style: TextStyles.bodyLargeBoldStyle(),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: tripItems.length,
      separatorBuilder: (context, index) => SizedBox(height: 16.h),
      itemBuilder: (context, index) {
        final item = tripItems[index];
        final order = item.cartId != null ? _orderDetails[item.cartId!] : null;

        if (order == null) {
          return const SizedBox.shrink();
        }

        final isTeamTrip = context.read<TripCubit>().isViewingTeamTrip;

        return _buildServiceCard(item, order, trip, isTeamTrip: isTeamTrip);
      },
    );
  }

  Widget _buildServiceCard(
      TripAirItem item, OrderStatus order, TripResponse trip,
      {bool isTeamTrip = false}) {
    final productType = item.type;
    final isNewStatus =
        trip.status == TripStatusEnum.NEW || trip.status?.code == 'N';

    final showModifyButton = !isTeamTrip && isNewStatus;

    switch (productType) {
      case ProductTypeEnum.AIR:
        return AirOrderDetailCard(
          orderStatus: order,
          customButtonText: !showModifyButton ? null : 'Modify',
          onCustomButtonPressed: !showModifyButton
              ? null
              : () {
                  navigateToService(context, SupportedService.Flights);
                },
          readonly: isTeamTrip,
        );
      case ProductTypeEnum.HOTEL:
        return HotelOrderDetailCard(
          orderStatus: order,
          customButtonText: !showModifyButton ? null : 'Modify',
          onCustomButtonPressed: !showModifyButton
              ? null
              : () {
                  navigateToService(context, SupportedService.Hotels);
                },
          readonly: isTeamTrip,
        );
      case ProductTypeEnum.BUS:
        return BusOrderDetailCard(
          orderStatus: order,
          customButtonText: !showModifyButton ? null : 'Modify',
          onCustomButtonPressed: !showModifyButton ? null : () {},
          readonly: isTeamTrip,
        );
      default:
        return AirOrderDetailCard(
          orderStatus: order,
          customButtonText: !showModifyButton ? null : 'Modify',
          onCustomButtonPressed: !showModifyButton
              ? null
              : () {
                  navigateToService(context, SupportedService.Flights);
                },
          readonly: isTeamTrip,
        );
    }
  }

  Widget _buildBottomBar(BuildContext context, TripResponse trip) {
    if (_orderDetails.isEmpty) return const SizedBox.shrink();

    final isNewStatus =
        trip.status == TripStatusEnum.NEW || trip.status?.code == 'N';

    final totalPrice = _calculateTotalPrice();

    return BlocConsumer<TripCubit, TripState>(
      listener: (context, state) {
        if (state is TripError) {
          WidgetUtil.showSnackBar(state.message, context);
        }
      },
      builder: (context, state) {
        final isTeamTrip = state is TripLoaded && state.isViewingTeamTrip;

        if (isTeamTrip) {
          final showApprovalButtons =
              _approvalStatus == TripApprovalResponseStatus.REVIEW;

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
                          onPressed: () => _handleApproveTrip(context, trip),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: CustomOutlinedButton(
                          text: 'Deny',
                          buttonType: OutlinedButtonType.danger,
                          onPressed: () => _handleDenyTrip(context, trip),
                        ),
                      ),
                    ],
                  ),
          );
        }
        if (isNewStatus) {
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
        return const SizedBox.shrink();
      },
    );
  }

  double _calculateTotalPrice() {
    double total = 0.0;

    for (final order in _orderDetails.values) {
      if (order.airItineraries != null && order.airItineraries!.isNotEmpty) {
        final primary = order.airItineraries!.first;
        final fareEntries = primary.flightDetails?.fare;

        if (fareEntries != null && fareEntries.isNotEmpty) {
          final cost = fareEntries.first.totalCost;
          if (cost > 0) {
            total += cost;
            continue;
          }
        }

        for (final pax in primary.orderPassengerDetails) {
          final bookingClasses = pax.fareDetails?.passengerBookingClasses;
          if (bookingClasses != null && bookingClasses.isNotEmpty) {
            final fareDetails =
                bookingClasses.first.fareDetailsPerPassengerType;
            total += fareDetails.baseFare + fareDetails.finalTax;
          }
        }
      } else if (order.hotelBooking != null) {
        final amount = order.hotelBooking!.payment?.amount;
        if (amount != null && amount > 0) {
          total += amount;
        }
      } else if (order.busOrderItineraries != null &&
          order.busOrderItineraries!.isNotEmpty) {
        final itinerary = order.busOrderItineraries!.first;
        final amount = itinerary.customerPayment.totalBookingAmount;
        if (amount > 0) {
          total += amount;
        }
      }
    }

    return total;
  }

  Future<void> _handleApproveTrip(
      BuildContext context, TripResponse trip) async {
    if (trip.tripUid == null) return;

    WidgetUtil.showPopup(
      context,
      icon: Image.asset(
        "assets/images/order_success.png",
        height: 100.h,
      ),
      title: "Are you sure you want to approve this trip?",
      buttons: [
        PopupButton(
          text: "No",
          type: PopupButtonType.secondary,
          onPressed: () {},
        ),
        PopupButton(
          text: "Yes",
          onPressed: () async {
            setState(() {
              _isApprovingOrDenying = true;
            });

            try {
              await context.read<TripCubit>().approveTrip(trip.tripUid!, '');

              await _loadApprovalStatusIfTeamTrip();
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
                setState(() {
                  _isApprovingOrDenying = false;
                });
              }
            }
          },
        ),
      ],
    );
  }

  Future<void> _handleDenyTrip(BuildContext context, TripResponse trip) async {
    if (trip.tripUid == null) return;

    WidgetUtil.showPopup(
      context,
      icon: Image.asset(
        "assets/images/cacel_icon.png",
        height: 40.h,
      ),
      title: "Are you sure you want to deny this trip?",
      buttons: [
        PopupButton(
          text: "No",
          type: PopupButtonType.secondary,
          onPressed: () {},
        ),
        PopupButton(
          text: "Yes",
          onPressed: () async {
            setState(() {
              _isApprovingOrDenying = true;
            });

            try {
              await context.read<TripCubit>().denyTrip(trip.tripUid!, '');

              await _loadApprovalStatusIfTeamTrip();

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
                setState(() {
                  _isApprovingOrDenying = false;
                });
              }
            }
          },
        ),
      ],
    );
  }

  Color _getStatusColor(TripStatusEnum status) {
    switch (status.code) {
      case 'A':
      case 'B':
      case 'C':
        return Colors.green;
      case 'P':
      case 'I':
      case 'R':
        return Colors.orange;
      case 'D':
      case 'F':
        return Colors.red;
      case 'N':
      case 'G':
        return AppColors.primary;
      default:
        return AppColors.primaryTextSwatch[400]!;
    }
  }

  IconData _getStatusIcon(TripStatusEnum status) {
    switch (status.code) {
      case 'A':
        return Icons.check_circle;
      case 'B':
        return Icons.flight;
      case 'C':
        return Icons.done_all;
      case 'P':
      case 'I':
      case 'R':
        return Icons.pending;
      case 'D':
        return Icons.cancel;
      case 'F':
        return Icons.error;
      case 'N':
        return Icons.fiber_new;
      case 'G':
        return Icons.edit_note;
      default:
        return Icons.info;
    }
  }
}
