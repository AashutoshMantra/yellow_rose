import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yellow_rose/core/common_widgets/base_appbar.dart';
import 'package:yellow_rose/core/common_widgets/loader.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/dependncy_injection.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order_status/order_status.dart';
import 'package:yellow_rose/features/flight/domain/usecases/air_usecase.dart';
import 'package:yellow_rose/features/home_screen/presentation/pages/home_screen.dart';
import 'package:yellow_rose/features/trip/data/models/trip_status_enum.dart';
import 'package:yellow_rose/features/trip/domain/entities/trip_approval_response_status.dart';
import 'package:yellow_rose/features/trip/presentation/cubit/trip_cubit.dart';
import 'package:yellow_rose/features/trip/presentation/widgets/trip_detail/trip_status_banner.dart';
import 'package:yellow_rose/features/trip/presentation/widgets/trip_detail/trip_bottom_bar.dart';
import 'package:yellow_rose/features/trip/presentation/widgets/trip_detail/trip_service_selector.dart';
import 'package:yellow_rose/features/trip/presentation/widgets/trip_detail/trip_cart_list.dart';

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
          } catch (e, s) {
            log("$e, $s");
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
                  TripStatusBanner(trip: state.selectedTrip!),
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
                                          state.selectedTrip?.status ==
                                              TripStatusEnum.NEW)
                                        TripServiceSelector(
                                          trip: state.selectedTrip!,
                                          onServiceSelected: (service) =>
                                              navigateToService(
                                                  context, service),
                                        ),
                                      Text(
                                        'Trip Cart',
                                        style: TextStyles.bodyLargeBoldStyle(),
                                      ),
                                      SizedBox(height: 16.h),
                                      TripCartList(
                                        trip: state.selectedTrip!,
                                        orderDetails: _orderDetails,
                                        isTeamTrip: state.isViewingTeamTrip,
                                        onModifyService: (service) =>
                                            navigateToService(context, service),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                ),
              ],
            ),
            bottomNavigationBar: state is TripLoaded
                ? TripBottomBar(
                    trip: state.selectedTrip!,
                    orderDetails: _orderDetails,
                    approvalStatus: _approvalStatus,
                    onApprovalStatusChanged: _loadApprovalStatusIfTeamTrip,
                  )
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
}
