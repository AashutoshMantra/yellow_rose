import 'dart:developer';

import 'package:flutter/material.dart';
// ...existing imports
import 'package:yellow_rose/core/common_widgets/loader.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/WidgetUtils.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/dependncy_injection.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order_status/order_status.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order_status/order_status_list.dart';
import 'package:yellow_rose/features/flight/domain/usecases/air_usecase.dart';
import 'package:yellow_rose/features/home_screen/presentation/widgets/air/air_order_detail_card.dart';
import 'package:yellow_rose/features/home_screen/presentation/widgets/hotel/hotel_order_detail_card.dart';
import 'package:yellow_rose/core/constants/supported_service.dart';
import 'package:yellow_rose/core/common_widgets/pill.dart';

class OrderListScreen extends StatefulWidget {
  const OrderListScreen({super.key});

  @override
  State<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  final _airUseCase = getIt<AirUseCase>();

  // Services shown on this screen. To add a new product, add it here.
  final List<SupportedService> _services = [
    SupportedService.Flights,
    SupportedService.Hotels,
  ];

  // Generic storage keyed by service so adding more products is easy
  final Map<SupportedService, List<OrderStatus>> _bookings = {};
  final Map<SupportedService, bool> _loading = {};

  // Page controller to animate between product pages
  final PageController _pageController = PageController();

  // Selected index
  int _selectedIndex = 0;

  Future<void> _fetchForProduct(SupportedService product) async {
    // mark loader for this product
    setState(() => _loading[product] = true);

    try {
      log('Fetching orders for product: ${product.name}');
      final req = OrderStatusListRequest(product: _productCodeFor(product));
      final orders = await _airUseCase.getOrders(req);

      log('Fetched ${orders.length} orders for ${product.name}');

      if (mounted) {
        setState(() {
          _bookings[product] = orders;
        });
      } else {
        log('Widget not mounted after fetching ${product.name}');
      }
    } catch (e, s) {
      log('Error fetching orders for ${product.name}: $e');
      log('$s');
      if (mounted) {
        setState(() {
          _bookings[product] = [];
        });
        WidgetUtil.showSnackBar('Error fetching booking details', context);
      }
    } finally {
      if (mounted) {
        setState(() {
          _loading[product] = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    // default load both product lists concurrently so users can switch instantly
    _fetchForProduct(SupportedService.Flights);
    _fetchForProduct(SupportedService.Hotels);
  }

  String _productCodeFor(SupportedService s) {
    switch (s) {
      case SupportedService.Flights:
        return 'AIR';
      case SupportedService.Hotels:
        return 'HOTEL';
      default:
        return 'AIR';
    }
  }

  Widget _servicePill(SupportedService service, int index) {
    final isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () {
        if (_selectedIndex == index) return;
        setState(() {
          _selectedIndex = index;
        });
        // lazy fetch if list empty
        if ((_bookings[service] ?? []).isEmpty) {
          _fetchForProduct(service);
        }
        _pageController.animateToPage(index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.h),
          // Selected pill: white background with primary border; Unselected: filled primary
          border: Border.all(
              color: isSelected ? AppColors.primary : Colors.transparent),
        ),
        child: Pill(
          backgroundColor: isSelected ? Colors.white : AppColors.primary,
          child: Text(
            service == SupportedService.Flights ? 'Flight' : 'Hotel',
            style: TextStyles.bodyMediumSemiBoldStyle()
                .copyWith(color: isSelected ? AppColors.primary : Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Top blue header background
    return Stack(
      children: [
        Column(
          children: [
            Container(
              height: 150.h,
              decoration: const BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(8),
                      bottomLeft: Radius.circular(8))),
            ),
          ],
        ),

        // Main content
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 16.h),
          child: Column(
            children: [
              // Pills for Flight / Hotel - left aligned
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: _services
                    .asMap()
                    .entries
                    .map((e) => Padding(
                          padding: EdgeInsets.only(right: 12.w),
                          child: _servicePill(e.value, e.key),
                        ))
                    .toList(),
              ),

              SizedBox(height: 12.h),

              // Content area with PageView to animate between flight/hotel lists
              Expanded(
                child: Stack(
                  children: [
                    PageView(
                      controller: _pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        // generate pages for configured services
                        ..._services.map((service) {
                          final loading = _loading[service] ?? true;
                          final bookings = _bookings[service] ?? [];

                          Widget emptyWidget(String label) => Center(
                                  child: Text(
                                'No $label Booking Found',
                                style: TextStyles.h4Style(),
                              ));

                          if (loading)
                            return const Center(
                                child: Loader(color: Colors.transparent));

                          if (service == SupportedService.Flights) {
                            if (bookings.isEmpty) return emptyWidget('Flight');
                            return ListView.separated(
                              padding: EdgeInsets.only(top: 8.h, bottom: 24.h),
                              itemCount: bookings.length,
                              itemBuilder: (ctx, idx) {
                                return AirOrderDetailCard(
                                    orderStatus: bookings[idx]);
                              },
                              separatorBuilder: (_, __) =>
                                  SizedBox(height: 16.h),
                            );
                          }

                          if (service == SupportedService.Hotels) {
                            if (bookings.isEmpty) return emptyWidget('Hotel');
                            return ListView.separated(
                              padding: EdgeInsets.only(top: 8.h, bottom: 24.h),
                              itemCount: bookings.length,
                              itemBuilder: (ctx, idx) {
                                return HotelOrderDetailCard(
                                    orderStatus: bookings[idx]);
                              },
                              separatorBuilder: (_, __) =>
                                  SizedBox(height: 16.h),
                            );
                          }

                          return emptyWidget(service.name);
                        }),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
