import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yellow_rose/core/common_widgets/button.dart';
import 'package:yellow_rose/core/common_widgets/loader.dart';
import 'package:yellow_rose/core/common_widgets/rounded_tab_bar.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/core/utils/WidgetUtils.dart';
import 'package:yellow_rose/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:yellow_rose/features/trip/presentation/cubit/trip_cubit.dart';
import 'package:yellow_rose/features/trip/presentation/pages/trip_detail_screen.dart';
import 'package:yellow_rose/features/trip/presentation/widgets/create_trip_bottom_sheet.dart';
import 'package:yellow_rose/features/trip/presentation/widgets/trip_card.dart';
import 'package:yellow_rose/features/trip/data/models/trip_response.dart';

class TripHomeScreen extends StatefulWidget {
  static const String routeName = '/trip-home';

  const TripHomeScreen({super.key});

  @override
  State<TripHomeScreen> createState() => _TripHomeScreenState();
}

class _TripHomeScreenState extends State<TripHomeScreen> {
  @override
  void initState() {
    super.initState();
    _loadTrips();
  }

  void _loadTrips() {
    final authState = context.read<AuthCubit>().state;
    if (authState is Authenticated) {
      final userId = authState.userDetails.userUid;
      context.read<TripCubit>().loadTrips(userId!);
    }
  }

  void _showCreateTripSheet() {
    WidgetUtil.showBottomSheet(
      context,
      const CreateTripBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TripCubit, TripState>(
      builder: (context, state) {
        if (state is! TripLoaded) {
          return Scaffold(
            body: _buildBody(state, isTeamTrips: false),
          );
        }

        return DefaultTabController(
          length: 2,
          child: Scaffold(
            body: Column(
              children: [
                Container(
                  color: AppColors.primary,
                  child: SafeArea(
                    bottom: false,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 16.h),
                          child: RoundedTabBars(
                            onTap: (index) {},
                            tabBarHeight: 48.h,
                            tabChildrens: const [
                              Tab(
                                child: Center(
                                  child: Text('My Trips'),
                                ),
                              ),
                              Tab(
                                child: Center(
                                  child: Text('Team Trips'),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 8.h),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      _buildBody(state, isTeamTrips: false),
                      _buildBody(state, isTeamTrips: true),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBody(TripState state, {required bool isTeamTrips}) {
    if (state is TripLoading) {
      return const Center(
        child: Loader(color: Colors.transparent),
      );
    }

    if (state is TripError) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64.h,
                color: AppColors.primaryTextSwatch[400],
              ),
              SizedBox(height: 16.h),
              Text(
                'Unable to load trips',
                style: TextStyles.bodyLargeBoldStyle(),
              ),
              SizedBox(height: 8.h),
              Text(
                'Please try again',
                style: TextStyles.bodyMediumMediumStyle().copyWith(
                  color: AppColors.primaryTextSwatch[500],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.h),
              CustomButton(
                text: 'Retry',
                onPressed: _loadTrips,
              ),
            ],
          ),
        ),
      );
    }

    if (state is TripLoaded) {
      final trips = isTeamTrips ? state.teamTrips : state.trips;
      if (trips.isEmpty) {
        return _buildEmptyState(isTeamTrips);
      }
      return _buildTripList(trips, isTeamTrips);
    }

    return const SizedBox.shrink();
  }

  Widget _buildEmptyState(bool isTeamTrips) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.luggage_outlined,
              size: 64.h,
              color: AppColors.primaryTextSwatch[300],
            ),
            SizedBox(height: 16.h),
            Text(
              isTeamTrips ? 'No team trips yet' : 'No trips yet',
              style: TextStyles.bodyLargeBoldStyle(),
            ),
            SizedBox(height: 8.h),
            Text(
              isTeamTrips
                  ? 'Team trips will appear here when available'
                  : 'Create your first trip to get started',
              style: TextStyles.bodyMediumMediumStyle().copyWith(
                color: AppColors.primaryTextSwatch[500],
              ),
              textAlign: TextAlign.center,
            ),
            if (!isTeamTrips) ...[
              SizedBox(height: 24.h),
              CustomButton(
                text: 'Create Trip',
                onPressed: _showCreateTripSheet,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTripList(List<TripResponse> trips, bool isTeamTrips) {
    return Column(
      children: [
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async => _loadTrips(),
            child: ListView.separated(
              padding: EdgeInsets.all(16.w),
              itemCount: trips.length,
              separatorBuilder: (context, index) => SizedBox(height: 12.h),
              itemBuilder: (context, index) {
                final trip = trips[index];
                return TripCard(
                  trip: trip,
                  onTap: () {
                    context
                        .read<TripCubit>()
                        .selectTrip(trip, isTeamTrip: isTeamTrips);
                    Navigator.pushNamed(
                      context,
                      TripDetailScreen.routeName,
                      arguments: {'trip': trip},
                    );
                  },
                );
              },
            ),
          ),
        ),
        if (!isTeamTrips)
          Container(
            padding: EdgeInsets.all(16.w),
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
            child: Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: 'Create Trip',
                    onPressed: _showCreateTripSheet,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
