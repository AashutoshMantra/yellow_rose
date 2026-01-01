import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yellow_rose/core/common_widgets/button.dart';
import 'package:yellow_rose/core/common_widgets/loader.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
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
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => const CreateTripBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TripCubit, TripState>(
      builder: (context, state) {
        return Scaffold(
          body: _buildBody(state),
        );
      },
    );
  }

  Widget _buildBody(TripState state) {
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
      if (state.trips.isEmpty) {
        return _buildEmptyState();
      }
      return _buildTripList(state.trips);
    }

    return const SizedBox.shrink();
  }

  Widget _buildEmptyState() {
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
              'No trips yet',
              style: TextStyles.bodyLargeBoldStyle(),
            ),
            SizedBox(height: 8.h),
            Text(
              'Create your first trip to get started',
              style: TextStyles.bodyMediumMediumStyle().copyWith(
                color: AppColors.primaryTextSwatch[500],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            CustomButton(
              text: 'Create Trip',
              onPressed: _showCreateTripSheet,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTripList(List<TripResponse> trips) {
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
                    context.read<TripCubit>().selectTrip(trip);
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
