import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yellow_rose/core/common_widgets/base_appbar.dart';
import 'package:yellow_rose/core/common_widgets/bottom_button.dart';
import 'package:yellow_rose/core/common_widgets/button.dart';
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
  final TripResponse trip;

  const TripDetailScreen({super.key, required this.trip});

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

  bool _isServiceInTrip(SupportedService service) {
    final tripItems = widget.trip.tripItemList ?? [];
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
    setState(() {
      _isLoading = true;
      _error = null;
      _orderDetails.clear();
    });

    try {
      final tripItems = widget.trip.tripItemList ?? [];

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

  @override
  Widget build(BuildContext context) {
    return BlocListener<TripCubit, TripState>(
      listener: (context, state) {
        if (state is TripLoaded) {
          _loadTripServices();
        }
      },
      child: Scaffold(
        appBar: BaseAppBar(
          title: widget.trip.tripName ?? 'Trip Details',
        ),
        body: Column(
          children: [
            Expanded(
              child: _isLoading
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
                                if (widget.trip.status != null) ...[
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12.w, vertical: 6.h),
                                    decoration: BoxDecoration(
                                      color: AppColors.primarySwatch[50],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      widget.trip.status!.description,
                                      style:
                                          TextStyles.bodySmallSemiBoldStyle()
                                              .copyWith(
                                                  color: AppColors.primary),
                                    ),
                                  ),
                                  SizedBox(height: 24.h),
                                ],
                                if (_supportedServiceForTrip
                                    .any((s) => !_isServiceInTrip(s))) ...[
                                  Text(
                                    'Add Services',
                                    style: TextStyles.bodyLargeBoldStyle(),
                                  ),
                                  SizedBox(height: 16.h),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: _supportedServiceForTrip
                                        .map((supportedService) {
                                      final isAdded =
                                          _isServiceInTrip(supportedService);
                                      return ImageIconButton(
                                        onClick: isAdded
                                            ? null
                                            : () {
                                                navigateToService(
                                                    context, supportedService);
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
                                _buildTripCart(),
                              ],
                            ),
                          ),
                        ),
            ),
          ],
        ),
        bottomNavigationBar: _buildBottomBar(context),
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

  Widget _buildTripCart() {
    final tripItems = widget.trip.tripItemList ?? [];

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

        return _buildServiceCard(item, order);
      },
    );
  }

  Widget _buildServiceCard(TripAirItem item, OrderStatus order) {
    final productType = item.type;
    final isTerminal = order.status?.isTerminalState() ?? false;

    switch (productType) {
      case ProductTypeEnum.AIR:
        return AirOrderDetailCard(
          orderStatus: order,
          customButtonText: isTerminal ? null : 'Modify',
          onCustomButtonPressed: isTerminal
              ? null
              : () {
                  navigateToService(context, SupportedService.Flights);
                },
        );
      case ProductTypeEnum.HOTEL:
        return HotelOrderDetailCard(
          orderStatus: order,
          customButtonText: isTerminal ? null : 'Modify',
          onCustomButtonPressed: isTerminal
              ? null
              : () {
                  navigateToService(context, SupportedService.Hotels);
                },
        );
      case ProductTypeEnum.BUS:
        return BusOrderDetailCard(
          orderStatus: order,
          customButtonText: isTerminal ? null : 'Modify',
          onCustomButtonPressed: isTerminal ? null : () {},
        );
      default:
        return AirOrderDetailCard(
          orderStatus: order,
          customButtonText: isTerminal ? null : 'Modify',
          onCustomButtonPressed: isTerminal
              ? null
              : () {
                  navigateToService(context, SupportedService.Flights);
                },
        );
    }
  }

  Widget _buildBottomBar(BuildContext context) {
    if (_orderDetails.isEmpty) return const SizedBox.shrink();

    final isNewStatus =
        widget.trip.status == TripStatusEnum.NEW ||
        widget.trip.status?.code == 'N';

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
                      col: AppColors.primary);
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
}
