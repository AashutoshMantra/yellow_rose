part of 'hotel_search_cubit.dart';

class HotelSearchState extends Equatable {
  final DateTime? checkInDate;
  final DateTime? checkOutDate;
  final int roomCount;
  final int adultCount;
  final List<int> childAges;
  final PlaceEntity? place;
  final String? error;
  final bool isLoading;
  const HotelSearchState({
    this.checkInDate,
    this.checkOutDate,
    this.roomCount = 1,
    this.adultCount = 1,
    List<int>? childAges,
    this.place,
    this.error,
    this.isLoading = false,
  }) : childAges = childAges ?? const [];

  factory HotelSearchState.initial({HotelSearch? hotelSearch}) {
    return HotelSearchState(
      checkInDate: hotelSearch?.checkInDate ??
          DateTime.now().add(const Duration(days: 1)),
      checkOutDate: hotelSearch?.checkOutDate ??
          DateTime.now().add(const Duration(days: 2)),
      roomCount: 1,
      adultCount: 1,
      childAges: const [],
      place: hotelSearch?.place,
      error: null,
    );
  }

  @override
  List<Object?> get props {
    return [
      checkInDate,
      checkOutDate,
      roomCount,
      adultCount,
      childAges,
      place,
      error,
      isLoading,
    ];
  }

  HotelSearchState copyWith({
    DateTime? checkInDate,
    DateTime? checkOutDate,
    int? roomCount,
    int? adultCount,
    List<int>? childAges,
    String? country,
    PlaceEntity? place,
    String? error,
    bool? isLoading,
  }) {
    return HotelSearchState(
      checkInDate: checkInDate ?? this.checkInDate,
      checkOutDate: checkOutDate ?? this.checkOutDate,
      roomCount: roomCount ?? this.roomCount,
      adultCount: adultCount ?? this.adultCount,
      childAges: childAges ?? this.childAges,
      place: place ?? this.place,
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
