import 'package:yellow_rose/features/hotel/data/models/order/hotel_booking_response.dart';
import 'package:yellow_rose/features/hotel/data/models/order/hummingbird/hummingbird_booking_response.dart';

bool _isHummingbirdFailed(HummingbirdBookingResponse response) {
  final room = response.rooms?.firstOrNull;
  return response.errorData != null ||
      room == null ||
      !(room.isConfirmed || room.isPending);
}

extension HotelBookingResponseExtension on HotelBookingResponse {
  bool get isBookingFailed {
    if (error?.errorData != null) {
      return true;
    }
    final hummingbirdResponses = hummingBirdBookingResponses ?? [];
    if (hummingbirdResponses.isNotEmpty) {
      return hummingbirdResponses.every(_isHummingbirdFailed);
    }
    return (mmtBookingResponse ?? []).isEmpty &&
        (expediaBookingResponse ?? []).isEmpty;
  }

  bool get isBookingPending {
    final hummingbirdResponses = hummingBirdBookingResponses ?? [];
    if (isBookingFailed || hummingbirdResponses.isEmpty) {
      return false;
    }
    return hummingbirdResponses.any((response) =>
        _isHummingbirdFailed(response) || response.rooms!.first.isPending);
  }
}
