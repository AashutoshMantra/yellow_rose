part of 'hotel_search_listing_cubit.dart';

sealed class HotelSearchListingState extends Equatable {
  final HotelSearch? hotelSearch;
  const HotelSearchListingState({
    this.hotelSearch,
  });

  @override
  List<Object?> get props => [];
}

final class HotelSearchListingInitial extends HotelSearchListingState {
  const HotelSearchListingInitial({required super.hotelSearch});
}

final class HotelSearchListingLoading extends HotelSearchListingState {
  const HotelSearchListingLoading({required super.hotelSearch});
}

final class HotelSearchListingLoaded extends HotelSearchListingState {
  final HotelResponseList hotelSearchResponse;
  const HotelSearchListingLoaded({
    required super.hotelSearch,
    required this.hotelSearchResponse,
  });
  HotelSearchListingLoaded copyWith({
    HotelResponseList? hotelSearchResponse,
    HotelSearch? hotelSearch,
  }) {
    return HotelSearchListingLoaded(
      hotelSearch: hotelSearch ?? this.hotelSearch,
      hotelSearchResponse: hotelSearchResponse ?? this.hotelSearchResponse,
    );
  }

  @override
  List<Object?> get props => [hotelSearchResponse, hotelSearch];
}

final class HotelSearchListinError extends HotelSearchListingState {
  final String errorMessage;
  const HotelSearchListinError(this.errorMessage, {required super.hotelSearch});
  @override
  List<Object> get props => [errorMessage];
}
