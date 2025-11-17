import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yellow_rose/core/common_widgets/base_appbar.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/features/bus/data/models/search/bus_search_response.dart';
import 'package:yellow_rose/features/bus/domain/entities/bus_search.dart';
import 'package:yellow_rose/features/bus/presentation/cubit/bus_detail/bus_detail_cubit.dart';
import 'package:yellow_rose/features/bus/presentation/pages/bus_book/bus_book_form_screen.dart';
import 'package:yellow_rose/features/bus/presentation/widgets/point_card.dart';

class BusBoardingDroppingScreen extends StatefulWidget {
  final BusSearchResponse busSearchResponse;
  final BusSearch busSearch;

  const BusBoardingDroppingScreen({
    super.key,
    required this.busSearchResponse,
    required this.busSearch,
  });

  @override
  State<BusBoardingDroppingScreen> createState() =>
      _BusBoardingDroppingScreenState();
}

class _BusBoardingDroppingScreenState extends State<BusBoardingDroppingScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabChange);
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabChange() {
    // Allow free navigation between tabs
    // The auto-switch logic will only trigger once when boarding point is selected
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: "Select Points",
        subTitle: "",
        shouldHaveRadius: false,
        height: 35.h,
      ),
      body: Column(
        children: [
          // Tab Bar
          Container(
            color: AppColors.primary,
            child: TabBar(
              controller: _tabController,
              indicatorColor: Colors.white,
              indicatorWeight: 3.h,
              labelStyle: TextStyles.bodyMediumBoldStyle().copyWith(
                color: Colors.white,
              ),
              unselectedLabelStyle: TextStyles.bodyMediumStyle().copyWith(
                color: Colors.white.withOpacity(0.7),
              ),
              tabs: const [
                Tab(text: "Boarding Point"),
                Tab(text: "Dropping Point"),
              ],
            ),
          ),

          // Tab Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _BoardingPointTab(
                  busSearchResponse: widget.busSearchResponse,
                  busSearch: widget.busSearch,
                  onPointSelected: () => _tabController.animateTo(1),
                ),
                _DroppingPointTab(
                  busSearchResponse: widget.busSearchResponse,
                  busSearch: widget.busSearch,
                  onPointSelected: () {
                    // Navigate to booking form - the cubit will be created in the route
                    final busDetailCubit = context.read<BusDetailCubit>();
                    final state = busDetailCubit.state as BusDetailLoaded;

                    Navigator.of(context).pushNamed(
                      BusBookFormScreen.routeName,
                      arguments: {
                        'busSearchResponse': widget.busSearchResponse,
                        'busSearch': widget.busSearch,
                        'busDetailResponse': state.busDetailResponse,
                        'selectedSeats': state.selectedSeats,
                        'selectedBoardingPoint': state.selectedBoardingPoint,
                        'selectedDroppingPoint': state.selectedDroppingPoint,
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BoardingPointTab extends StatelessWidget {
  final BusSearchResponse busSearchResponse;
  final BusSearch busSearch;
  final VoidCallback onPointSelected;

  const _BoardingPointTab({
    required this.busSearchResponse,
    required this.busSearch,
    required this.onPointSelected,
  });

  @override
  Widget build(BuildContext context) {
    final boardingPoints = busSearchResponse.boardingPoint ?? [];

    if (boardingPoints.isEmpty) {
      return Center(
        child: Text(
          'No boarding points available',
          style: TextStyles.bodyMediumBoldStyle(),
        ),
      );
    }

    return BlocBuilder<BusDetailCubit, BusDetailState>(
      builder: (context, state) {
        final selectedBoardingPoint =
            state is BusDetailLoaded ? state.selectedBoardingPoint : null;

        return ListView.builder(
          padding: EdgeInsets.all(16.w),
          itemCount: boardingPoints.length,
          itemBuilder: (context, index) {
            final point = boardingPoints[index];
            final isSelected = selectedBoardingPoint?.id == point.id;

            return PointCard(
              point: point,
              isSelected: isSelected,
              onTap: () {
                context.read<BusDetailCubit>().selectBoardingPoint(point);
                onPointSelected();
              },
            );
          },
        );
      },
    );
  }
}

class _DroppingPointTab extends StatelessWidget {
  final BusSearchResponse busSearchResponse;
  final BusSearch busSearch;
  final VoidCallback onPointSelected;

  const _DroppingPointTab({
    required this.busSearchResponse,
    required this.busSearch,
    required this.onPointSelected,
  });

  @override
  Widget build(BuildContext context) {
    final droppingPoints = busSearchResponse.droppingPoint ?? [];

    if (droppingPoints.isEmpty) {
      return Center(
        child: Text(
          'No dropping points available',
          style: TextStyles.bodyMediumBoldStyle(),
        ),
      );
    }

    return BlocBuilder<BusDetailCubit, BusDetailState>(
      builder: (context, state) {
        final selectedDroppingPoint =
            state is BusDetailLoaded ? state.selectedDroppingPoint : null;

        return ListView.builder(
          padding: EdgeInsets.all(16.w),
          itemCount: droppingPoints.length,
          itemBuilder: (context, index) {
            final point = droppingPoints[index];
            final isSelected = selectedDroppingPoint?.id == point.id;

            return PointCard(
              point: point,
              isSelected: isSelected,
              onTap: () {
                context.read<BusDetailCubit>().selectDroppingPoint(point);
                onPointSelected();
              },
            );
          },
        );
      },
    );
  }
}

// PointCard has been moved to
// lib/features/bus/presentation/widgets/point_card.dart
