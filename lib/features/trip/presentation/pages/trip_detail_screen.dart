import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yellow_rose/core/common_widgets/base_appbar.dart';
import 'package:yellow_rose/core/common_widgets/bottom_button.dart';
import 'package:yellow_rose/core/common_widgets/image_icon_button.dart';
import 'package:yellow_rose/core/common_widgets/loader.dart';
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

  @override
  void initState() {
    super.initState();
    _loadTripServices();
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

  Future<void> _loadTripServices() async {
    var tripState = context.read<TripCubit>().state;
    if (tripState is! TripLoaded) {
      return;
    }
    var trip = tripState.selectedTrip!;
    setState(() {
      _isLoading = true;
      _error = null;
      _orderDetails.clear();
    });

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

      setState(() {
        _isLoading = false;
      });
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
                          : SingleChildScrollView(
                              child: Padding(
                                padding: EdgeInsets.all(24.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if ((state).selectedTrip?.status ==
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
                                                      navigateToService(context,
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

        return _buildServiceCard(item, order, trip);
      },
    );
  }

  Widget _buildServiceCard(
      TripAirItem item, OrderStatus order, TripResponse trip) {
    final productType = item.type;
    final isNewStatus =
        trip.status == TripStatusEnum.NEW || trip.status?.code == 'N';

    switch (productType) {
      case ProductTypeEnum.AIR:
        return AirOrderDetailCard(
          orderStatus: order,
          customButtonText: !isNewStatus ? null : 'Modify',
          onCustomButtonPressed: !isNewStatus
              ? null
              : () {
                  navigateToService(context, SupportedService.Flights);
                },
        );
      case ProductTypeEnum.HOTEL:
        return HotelOrderDetailCard(
          orderStatus: order,
          customButtonText: !isNewStatus ? null : 'Modify',
          onCustomButtonPressed: !isNewStatus
              ? null
              : () {
                  navigateToService(context, SupportedService.Hotels);
                },
        );
      case ProductTypeEnum.BUS:
        return BusOrderDetailCard(
          orderStatus: order,
          customButtonText: !isNewStatus ? null : 'Modify',
          onCustomButtonPressed: !isNewStatus ? null : () {},
        );
      default:
        return AirOrderDetailCard(
          orderStatus: order,
          customButtonText: !isNewStatus ? null : 'Modify',
          onCustomButtonPressed: !isNewStatus
              ? null
              : () {
                  navigateToService(context, SupportedService.Flights);
                },
        );
    }
  }

  Widget _buildBottomBar(BuildContext context, TripResponse trip) {
    if (_orderDetails.isEmpty) return const SizedBox.shrink();

    final isNewStatus =
        trip.status == TripStatusEnum.NEW || trip.status?.code == 'N';
    if (!isNewStatus) return const SizedBox.shrink();

    final totalPrice = _calculateTotalPrice();

    return BlocConsumer<TripCubit, TripState>(
      listener: (context, state) {
        if (state is TripError) {
          WidgetUtil.showSnackBar(state.message, context);
        }
      },
      builder: (context, state) {
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
