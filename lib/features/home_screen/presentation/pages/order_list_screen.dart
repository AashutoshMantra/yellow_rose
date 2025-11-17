import 'dart:developer';

import 'package:flutter/material.dart';
// ...existing imports
import 'package:yellow_rose/core/common_widgets/loader.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/WidgetUtils.dart';
import 'package:yellow_rose/core/utils/extensions.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/dependncy_injection.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order_status/order_status.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order_status/order_status_list.dart';
import 'package:yellow_rose/features/flight/domain/usecases/air_usecase.dart';
import 'package:yellow_rose/features/home_screen/presentation/widgets/air/air_order_detail_card.dart';
import 'package:yellow_rose/features/home_screen/presentation/widgets/hotel/hotel_order_detail_card.dart';
import 'package:yellow_rose/features/home_screen/presentation/widgets/bus/bus_order_detail_card.dart';
import 'package:yellow_rose/core/constants/supported_service.dart';
import 'package:yellow_rose/core/common_widgets/pill.dart';

class OrderListScreen extends StatefulWidget {
  const OrderListScreen({super.key});

  @override
  State<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen>
    with WidgetsBindingObserver {
  final _airUseCase = getIt<AirUseCase>();

  // Services shown on this screen. To add a new product, add it here.
  final List<SupportedService> _services = [
    SupportedService.Flights,
    SupportedService.Hotels,
    SupportedService.Buses,
  ];

  // Generic storage keyed by service so adding more products is easy
  final Map<SupportedService, List<OrderStatus>> _bookings = {};
  final Map<SupportedService, bool> _loading = {};
  final Map<SupportedService, int> _pages = {};
  final Map<SupportedService, bool> _hasMore = {};
  final Map<SupportedService, ScrollController> _scrollControllers = {};

  // Page controller to animate between product pages
  final PageController _pageController = PageController();

  // Selected index
  int _selectedIndex = 0;

  Future<void> _fetchForProduct(
    SupportedService product, {
    bool refresh = false,
  }) async {
    if (_loading[product] == true) return;
    setState(() => _loading[product] = true);

    final int nextPage = refresh ? 0 : (_pages[product] ?? 0);
    const int pageSize = 50;
    try {
      log('Fetching orders for product: \\${product.name}, page: \\$nextPage');
      final req = OrderStatusListRequest(
        product: _productCodeFor(product),
        strPage: nextPage,
        size: pageSize,
      );
      final orders = await _airUseCase.getOrders(req);
      log('Fetched \\${orders.length} orders for \\${product.name}');
      if (mounted) {
        setState(() {
          if (refresh || (_bookings[product]?.isEmpty ?? true)) {
            _bookings[product] = orders;
          } else {
            _bookings[product] = [...?_bookings[product], ...orders];
          }
          _pages[product] = nextPage + 1;
          _hasMore[product] = orders.length == pageSize;
        });
      }
    } catch (e, s) {
      log('Error fetching orders for \\${product.name}: \\$e');
      log('\\$s');
      if (mounted) {
        setState(() {
          if (refresh) {
            _bookings[product] = [];
          }
          _hasMore[product] = false;
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
    WidgetsBinding.instance.addObserver(this);
    for (final service in _services) {
      _scrollControllers[service] = ScrollController();
      _scrollControllers[service]!.addListener(() => _onScroll(service));
    }
    _refreshAllData();
  }

  void _onScroll(SupportedService service) {
    final controller = _scrollControllers[service];
    if (controller == null ||
        _loading[service] == true ||
        !(_hasMore[service] ?? true)) return;
    if (controller.position.pixels >=
        controller.position.maxScrollExtent - 200) {
      _fetchForProduct(service);
    }
  }

  /// Refresh data for all services
  void _refreshAllData() {
    for (final service in _services) {
      _pages[service] = 0;
      _hasMore[service] = true;
      _fetchForProduct(service, refresh: true);
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    // Refresh data when app comes to foreground
    if (state == AppLifecycleState.resumed && mounted) {
      log('App resumed, refreshing order data');
      _refreshAllData();
    }
  }

  String _productCodeFor(SupportedService s) {
    switch (s) {
      case SupportedService.Flights:
        return 'AIR';
      case SupportedService.Hotels:
        return 'HOTEL';
      case SupportedService.Buses:
        return 'BUS';
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
            service.name.toTitleCase(),
            style: TextStyles.bodyMediumSemiBoldStyle()
                .copyWith(color: isSelected ? AppColors.primary : Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _pageController.dispose();
    for (final controller in _scrollControllers.values) {
      controller.dispose();
    }
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
                          final hasMore = _hasMore[service] ?? true;
                          final controller = _scrollControllers[service];

                          Widget emptyWidget(String label) => Center(
                                  child: Text(
                                'No $label Booking Found',
                                style: TextStyles.h4Style(),
                              ));

                          if (loading && bookings.isEmpty) {
                            return const Center(
                                child: Loader(color: Colors.transparent));
                          }

                          Widget loaderBottom = hasMore && bookings.isNotEmpty
                              ? Padding(
                                  padding: EdgeInsets.symmetric(vertical: 16.h),
                                  child:
                                      const Loader(color: Colors.transparent),
                                )
                              : const SizedBox.shrink();

                          if (service == SupportedService.Flights) {
                            if (bookings.isEmpty) {
                              return RefreshIndicator(
                                onRefresh: () async =>
                                    _fetchForProduct(service, refresh: true),
                                child: ListView(
                                  controller: controller,
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  children: [
                                    SizedBox(height: 200.h),
                                    emptyWidget('Flight'),
                                  ],
                                ),
                              );
                            }
                            return RefreshIndicator(
                              onRefresh: () async =>
                                  _fetchForProduct(service, refresh: true),
                              child: ListView.separated(
                                controller: controller,
                                physics: const AlwaysScrollableScrollPhysics(),
                                padding:
                                    EdgeInsets.only(top: 8.h, bottom: 24.h),
                                itemCount: bookings.length + 1,
                                itemBuilder: (ctx, idx) {
                                  if (idx == bookings.length)
                                    return loaderBottom;
                                  return AirOrderDetailCard(
                                      orderStatus: bookings[idx]);
                                },
                                separatorBuilder: (_, __) =>
                                    SizedBox(height: 16.h),
                              ),
                            );
                          }

                          if (service == SupportedService.Hotels) {
                            if (bookings.isEmpty) {
                              return RefreshIndicator(
                                onRefresh: () async =>
                                    _fetchForProduct(service, refresh: true),
                                child: ListView(
                                  controller: controller,
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  children: [
                                    SizedBox(height: 200.h),
                                    emptyWidget('Hotel'),
                                  ],
                                ),
                              );
                            }
                            return RefreshIndicator(
                              onRefresh: () async =>
                                  _fetchForProduct(service, refresh: true),
                              child: ListView.separated(
                                controller: controller,
                                physics: const AlwaysScrollableScrollPhysics(),
                                padding:
                                    EdgeInsets.only(top: 8.h, bottom: 24.h),
                                itemCount: bookings.length + 1,
                                itemBuilder: (ctx, idx) {
                                  if (idx == bookings.length)
                                    return loaderBottom;
                                  return HotelOrderDetailCard(
                                      orderStatus: bookings[idx]);
                                },
                                separatorBuilder: (_, __) =>
                                    SizedBox(height: 16.h),
                              ),
                            );
                          }

                          if (service == SupportedService.Buses) {
                            if (bookings.isEmpty) {
                              return RefreshIndicator(
                                onRefresh: () async =>
                                    _fetchForProduct(service, refresh: true),
                                child: ListView(
                                  controller: controller,
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  children: [
                                    SizedBox(height: 200.h),
                                    emptyWidget('Bus'),
                                  ],
                                ),
                              );
                            }
                            return RefreshIndicator(
                              onRefresh: () async =>
                                  _fetchForProduct(service, refresh: true),
                              child: ListView.separated(
                                controller: controller,
                                physics: const AlwaysScrollableScrollPhysics(),
                                padding:
                                    EdgeInsets.only(top: 8.h, bottom: 24.h),
                                itemCount: bookings.length + 1,
                                itemBuilder: (ctx, idx) {
                                  if (idx == bookings.length)
                                    return loaderBottom;
                                  return BusOrderDetailCard(
                                      orderStatus: bookings[idx]);
                                },
                                separatorBuilder: (_, __) =>
                                    SizedBox(height: 16.h),
                              ),
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
