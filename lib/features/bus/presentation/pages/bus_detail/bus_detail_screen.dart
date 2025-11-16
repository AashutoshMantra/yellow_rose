import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yellow_rose/core/common_widgets/base_appbar.dart';
import 'package:yellow_rose/core/common_widgets/loader.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/WidgetUtils.dart';
import 'package:yellow_rose/core/utils/date_utils.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/features/bus/data/models/search/bus_search_response.dart';
import 'package:yellow_rose/features/bus/presentation/cubit/bus_detail/bus_detail_cubit.dart';
import 'package:yellow_rose/features/bus/presentation/widgets/seat/seat_selection_widget.dart';
import 'package:yellow_rose/features/bus/data/models/bus_details/bus_seats.dart';
import 'package:yellow_rose/features/flight/presentation/widgets/bottom_button.dart';
import 'package:yellow_rose/features/bus/presentation/pages/bus_boarding_dropping/bus_boarding_dropping_screen.dart';

String getBusDetailTitle(BusSearchResponse busSearchResponse) {
  return "${busSearchResponse.source ?? ''} → ${busSearchResponse.destination ?? ''}";
}

String getBusDetailSubtitle(BusSearchResponse busSearchResponse) {
  if (busSearchResponse.departureTime != null &&
      busSearchResponse.arrivalTime != null) {
    final departure =
        CustomDateUtils.timeInAmPm(busSearchResponse.departureTime!);
    final arrival = CustomDateUtils.timeInAmPm(busSearchResponse.arrivalTime!);
    return "$departure - $arrival";
  }
  return "";
}

class BusDetailScreen extends StatelessWidget {
  static const String routeName = "/busDetailScreen";

  final BusSearchResponse busSearchResponse;

  const BusDetailScreen({
    super.key,
    required this.busSearchResponse,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BusDetailCubit()..loadBusDetails(busSearchResponse),
      child: _BusDetailScreenContent(busSearchResponse: busSearchResponse),
    );
  }
}

class _BusDetailScreenContent extends StatefulWidget {
  final BusSearchResponse busSearchResponse;

  const _BusDetailScreenContent({required this.busSearchResponse});

  @override
  State<_BusDetailScreenContent> createState() =>
      _BusDetailScreenContentState();
}

class _BusDetailScreenContentState extends State<_BusDetailScreenContent> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: "Select Seats",
        subTitle: "",
        shouldHaveRadius: false,
        height: 35.h,
      ),
      body: BlocListener<BusDetailCubit, BusDetailState>(
        listener: (context, state) {
          if (state is BusDetailError) {
            WidgetUtil.showSnackBar("Error fetching bus details", context);
            Navigator.of(context).pop();
          }
        },
        child: BlocBuilder<BusDetailCubit, BusDetailState>(
          builder: (context, state) {
            if (state is BusDetailLoaded) {
              return SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                        ),
                      ),
                      padding: EdgeInsets.only(
                          left: 24.w, right: 24.w, bottom: 24.h, top: 24.h),
                      child: BusItineraryCard(
                        busSearchResponse: widget.busSearchResponse,
                        busDetailResponse: state.busDetailResponse,
                        scrollController: _scrollController,
                      ),
                    ),
                    // Seat canvas placeholder: converts dynamic seat list to Seat models
                    Padding(
                      padding: EdgeInsets.all(12.w),
                      child: Builder(builder: (context) {
                        final List<BusSeats> rawSeats =
                            state.busDetailResponse.seats;

                        if (rawSeats.isEmpty) {
                          return Center(
                            child: Text(
                              'No seat map available',
                              style: TextStyles.bodyMediumBoldStyle(),
                            ),
                          );
                        }

                        // Responsive height for the seat map: half the screen or min 300
                        return SizedBox(
                          child: Center(
                            child: SeatSelectionWidget(
                              allSeats: rawSeats,
                              selectedSeats: state.selectedSeats,
                              onToggleSeat: (seatId) => context
                                  .read<BusDetailCubit>()
                                  .toggleSeat(seatId),
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              );
            }
            return const Loader();
          },
        ),
      ),
      bottomNavigationBar: BlocBuilder<BusDetailCubit, BusDetailState>(
        builder: (context, state) {
          if (state is BusDetailLoaded && state.selectedSeats.isNotEmpty) {
            final totalPrice = context.read<BusDetailCubit>().getTotalPrice();
            return SizedBox(
              height: 95.h,
              width: double.infinity,
              child: BottomButton(
                buttonText: "Continue",
                title: "₹ ${totalPrice.toStringAsFixed(1)}",
                subtitle:
                    "${state.selectedSeats.length} seat${state.selectedSeats.length > 1 ? 's' : ''} selected",
                onClick: () {
                  final busCubit = context.read<BusDetailCubit>();

                  // Clear any previous boarding/dropping selections before navigating
                  busCubit.clearBoardingPoint();
                  busCubit.clearDroppingPoint();

                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => BlocProvider.value(
                        value: busCubit,
                        child: BusBoardingDroppingScreen(
                          busSearchResponse: widget.busSearchResponse,
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class BusItineraryCard extends StatefulWidget {
  final BusSearchResponse busSearchResponse;
  final dynamic busDetailResponse;
  final ScrollController scrollController;

  const BusItineraryCard({
    super.key,
    required this.busSearchResponse,
    required this.busDetailResponse,
    required this.scrollController,
  });

  @override
  State<BusItineraryCard> createState() => _BusItineraryCardState();
}

class _BusItineraryCardState extends State<BusItineraryCard>
    with TickerProviderStateMixin {
  bool _expanded = true; // Start expanded by default
  bool _userManuallyToggled = false; // Track if user manually toggled
  double _lastScrollPosition = 0.0;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    if (_userManuallyToggled)
      return; // Don't auto-toggle if user manually toggled

    final currentPosition = widget.scrollController.position.pixels;
    final delta = currentPosition - _lastScrollPosition;

    // If scrolling down and expanded, collapse
    if (delta > 0 && _expanded && currentPosition > 50) {
      setState(() {
        _expanded = false;
      });
    }
    // If scrolling up and collapsed, expand
    else if (delta < 0 && !_expanded && currentPosition < 50) {
      setState(() {
        _expanded = true;
      });
    }

    _lastScrollPosition = currentPosition;
  }

  void _toggle() {
    setState(() {
      _expanded = !_expanded;
      _userManuallyToggled = true; // Mark as manually toggled
    });

    // Reset manual toggle flag after a delay to allow scroll behavior again
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _userManuallyToggled = false;
        });
      }
    });
  }

  Widget _buildCollapsed() {
    final b = widget.busSearchResponse;
    return Row(
      children: [
        ImageIcon(
          const AssetImage("assets/images/icons/bus.png"),
          size: 22.h,
          color: Colors.white,
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${b.source ?? ''} → ${b.destination ?? ''}",
                style: TextStyles.bodyLargeBoldStyle().copyWith(
                  color: Colors.white,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 4.h),
              Row(
                children: [
                  Text(
                    CustomDateUtils.dayDateMonthFormat(
                        b.departureTime ?? DateTime.now()),
                    style: TextStyles.bodySmallMediumStyle().copyWith(
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    CustomDateUtils.timeInAmPm(
                        b.departureTime ?? DateTime.now()),
                    style: TextStyles.bodySmallMediumStyle().copyWith(
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(width: 8.w),
        Icon(
          _expanded ? Icons.expand_less : Icons.expand_more,
          color: Colors.white,
        ),
      ],
    );
  }

  Widget _buildExpanded() {
    final b = widget.busSearchResponse;
    // final d = widget.busDetailResponse;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Main route and operator row
        Row(
          children: [
            ImageIcon(
              const AssetImage("assets/images/icons/bus.png"),
              size: 24.h,
              color: Colors.white,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Route
                  Text(
                    "${b.source ?? ''} → ${b.destination ?? ''}",
                    style: TextStyles.bodyLargeBoldStyle().copyWith(
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  // Operator and bus type
                  Text(
                    b.operatorDetails?.operatorName ?? 'Unknown Operator',
                    style: TextStyles.bodyMediumBoldStyle().copyWith(
                      color: Colors.white.withOpacity(0.95),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            GestureDetector(
              onTap: _toggle,
              child: Icon(
                Icons.close,
                color: Colors.white.withOpacity(0.9),
              ),
            )
          ],
        ),
        SizedBox(height: 12.h),
        // Time and details row
        Row(
          children: [
            // Departure time and date
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Departure',
                    style: TextStyles.bodySmallStyle().copyWith(
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    CustomDateUtils.dayDateMonthFormat(
                        b.departureTime ?? DateTime.now()),
                    style: TextStyles.bodySmallMediumStyle().copyWith(
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    CustomDateUtils.timeInAmPm(
                        b.departureTime ?? DateTime.now()),
                    style: TextStyles.bodyMediumBoldStyle().copyWith(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            // Duration
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(16.h),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.access_time,
                    size: 16.h,
                    color: Colors.white,
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    b.duration ?? "Duration N/A",
                    style: TextStyles.bodySmallBoldStyle().copyWith(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            // Arrival time and date
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Arrival',
                    style: TextStyles.bodySmallStyle().copyWith(
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    CustomDateUtils.dayDateMonthFormat(
                        b.arrivalTime ?? DateTime.now()),
                    style: TextStyles.bodySmallMediumStyle().copyWith(
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    CustomDateUtils.timeInAmPm(b.arrivalTime ?? DateTime.now()),
                    style: TextStyles.bodyMediumBoldStyle().copyWith(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 4.h),
        // Additional info row
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggle,
      behavior: HitTestBehavior.opaque,
      child: AnimatedSize(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        child: _expanded ? _buildExpanded() : _buildCollapsed(),
      ),
    );
  }
}
