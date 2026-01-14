import 'package:flutter/material.dart';
import 'package:yellow_rose/core/common_widgets/custom_banner.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/features/trip/data/models/trip_response.dart';
import 'package:yellow_rose/features/trip/data/models/trip_create_request.dart';

/// Helper class providing pre-configured banner instances for common use cases
/// This makes it easy to create consistent banners across the app
class BannerFactory {
  /// Trip-related banners
  static CustomBanner tripConstraint({
    required TripResponse trip,
    String? customSelfMessage,
    String? customOnBehalfMessage,
  }) {
    final isSelfTrip = trip.tripFor == TripFor.Self.value;
    final onBehalfCount = trip.tripDetails?.onBehalf?.length ?? 0;

    String message;
    if (isSelfTrip) {
      message = customSelfMessage ?? "Trip is for self - only 1 adult allowed";
    } else {
      message =
          customOnBehalfMessage ?? "Trip is on behalf of $onBehalfCount people";
    }

    return CustomBanner(
      message: message,
      type: BannerType.info,
      icon: Icons.info_outline,
      backgroundColor: AppColors.primary.withOpacity(0.1),
      borderColor: AppColors.primary.withOpacity(0.3),
      textColor: AppColors.primary,
      iconColor: AppColors.primary,
    );
  }

  static CustomBanner tripLocked({required String message}) {
    return CustomBanner(
      message: message,
      type: BannerType.info,
      icon: Icons.lock,
      backgroundColor: AppColors.primaryTextSwatch[50]!,
      borderColor: AppColors.primary,
      iconColor: AppColors.primary,
      textColor: AppColors.primary,
    );
  }

  /// Booking-related banners
  static CustomBanner bookingSuccess(String message) {
    return CustomBanner(
      message: message,
      type: BannerType.success,
      icon: Icons.check_circle_outline,
    );
  }

  static CustomBanner bookingError(String message) {
    return CustomBanner(
      message: message,
      type: BannerType.error,
      icon: Icons.error_outline,
    );
  }

  static CustomBanner paymentPending(String message) {
    return CustomBanner(
      message: message,
      type: BannerType.warning,
      icon: Icons.payment,
    );
  }

  /// Validation banners
  static CustomBanner validationError(String message) {
    return CustomBanner(
      message: message,
      type: BannerType.error,
      icon: Icons.warning,
    );
  }

  static CustomBanner validationWarning(String message) {
    return CustomBanner(
      message: message,
      type: BannerType.warning,
      icon: Icons.info,
    );
  }

  /// Network/connectivity banners
  static CustomBanner networkError() {
    return const CustomBanner(
      message: "No internet connection. Please check your network settings.",
      type: BannerType.error,
      icon: Icons.wifi_off,
    );
  }

  static CustomBanner networkSlow() {
    return const CustomBanner(
      message: "Slow network detected. This may affect your experience.",
      type: BannerType.warning,
      icon: Icons.signal_wifi_statusbar_connected_no_internet_4,
    );
  }

  /// Information banners
  static CustomBanner announcement(String message, {IconData? icon}) {
    return CustomBanner(
      message: message,
      type: BannerType.info,
      icon: icon ?? Icons.announcement,
      backgroundColor: Colors.blue[50],
      borderColor: Colors.blue[200],
      textColor: Colors.blue[800],
      iconColor: Colors.blue,
    );
  }

  static CustomBanner maintenance(String message) {
    return CustomBanner(
      message: message,
      type: BannerType.warning,
      icon: Icons.construction,
      backgroundColor: Colors.orange[50],
      borderColor: Colors.orange[200],
      textColor: Colors.orange[800],
      iconColor: Colors.orange,
    );
  }

  /// Flight-specific banners
  static CustomBanner flightDelay(String message) {
    return CustomBanner(
      message: message,
      type: BannerType.warning,
      icon: Icons.flight_takeoff,
      backgroundColor: Colors.amber[50],
      borderColor: Colors.amber[200],
      textColor: Colors.amber[800],
      iconColor: Colors.amber[700],
    );
  }

  static CustomBanner flightCancellation(String message) {
    return CustomBanner(
      message: message,
      type: BannerType.error,
      icon: Icons.cancel,
    );
  }

  static CustomBanner seatSelection(String message) {
    return CustomBanner(
      message: message,
      type: BannerType.info,
      icon: Icons.airline_seat_recline_normal,
    );
  }

  /// Hotel-specific banners
  static CustomBanner hotelBooking(String message) {
    return CustomBanner(
      message: message,
      type: BannerType.success,
      icon: Icons.hotel,
    );
  }

  static CustomBanner roomAvailability(String message) {
    return CustomBanner(
      message: message,
      type: BannerType.warning,
      icon: Icons.bed,
    );
  }

  /// Bus-specific banners
  static CustomBanner busDelay(String message) {
    return CustomBanner(
      message: message,
      type: BannerType.warning,
      icon: Icons.directions_bus,
    );
  }

  static CustomBanner busBookingConfirm(String message) {
    return CustomBanner(
      message: message,
      type: BannerType.success,
      icon: Icons.confirmation_number,
    );
  }

  /// Promotional banners
  static CustomBanner discount(String message) {
    return CustomBanner(
      message: message,
      type: BannerType.custom,
      icon: Icons.local_offer,
      backgroundColor: Colors.green[50],
      borderColor: Colors.green[200],
      textColor: Colors.green[800],
      iconColor: Colors.green,
    );
  }

  static CustomBanner limitedOffer(String message) {
    return CustomBanner(
      message: message,
      type: BannerType.custom,
      icon: Icons.timer,
      backgroundColor: Colors.purple[50],
      borderColor: Colors.purple[200],
      textColor: Colors.purple[800],
      iconColor: Colors.purple,
    );
  }

  /// Custom banner with action button
  static CustomBanner withAction({
    required String message,
    required String actionLabel,
    required VoidCallback onAction,
    BannerType type = BannerType.info,
    IconData? icon,
  }) {
    return CustomBanner(
      message: message,
      type: type,
      icon: icon,
      trailing: TextButton(
        onPressed: onAction,
        child: Text(actionLabel),
      ),
    );
  }
}
