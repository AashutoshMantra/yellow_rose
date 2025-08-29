part of 'hotel_book_cubit.dart';

sealed class HotelBookState extends Equatable {
  const HotelBookState();

  @override
  List<Object?> get props => [];
}

final class HotelBookInitial extends HotelBookState {}

final class HotelBookLoading extends HotelBookState {}

class HotelBookLoaded extends HotelBookState {
  final HotelDetailResponse hotel;
  final HotelRoom selectedRoom;
  final HotelSearch hotelSearch;
  final List<PassengerDetailsEntity> passengerDetails;
  final BillingEntity? billingEntity;
  final CreateOrderResponse hotelBookingResponse;
  final SpecialRequest? specialRequest;
  final UpdateOrderDetailResponse? updateOrderDetailResponse;
  HotelBookLoaded({
    required this.hotel,
    required this.selectedRoom,
    required this.hotelSearch,
    this.specialRequest,
    List<PassengerDetailsEntity>? passengerDetails,
    this.updateOrderDetailResponse,
    this.billingEntity,
    required this.hotelBookingResponse,
  }) : passengerDetails = passengerDetails ?? [];

  HotelBookLoaded copyWith(
      {HotelDetailResponse? hotel,
      HotelRoom? selectedRoom,
      HotelSearch? hotelSearch,
      List<PassengerDetailsEntity>? passengerDetails,
      BillingEntity? billingEntity,
      CreateOrderResponse? hotelBookingResponse,
      SpecialRequest? specialRequest,
      UpdateOrderDetailResponse? updateOrderDetailResponse}) {
    return HotelBookLoaded(
        hotel: hotel ?? this.hotel,
        selectedRoom: selectedRoom ?? this.selectedRoom,
        hotelSearch: hotelSearch ?? this.hotelSearch,
        passengerDetails: passengerDetails ?? this.passengerDetails,
        billingEntity: billingEntity ?? this.billingEntity,
        hotelBookingResponse: hotelBookingResponse ?? this.hotelBookingResponse,
        specialRequest: specialRequest ?? this.specialRequest,
        updateOrderDetailResponse:
            updateOrderDetailResponse ?? this.updateOrderDetailResponse);
  }

  @override
  List<Object?> get props => [
        hotel,
        selectedRoom,
        passengerDetails,
        billingEntity,
        hotelBookingResponse,
        specialRequest,
        updateOrderDetailResponse
      ];
}

class HotelBookError extends HotelBookState {
  final String errorMessage;

  const HotelBookError(
    this.errorMessage,
  );

  @override
  List<Object> get props => [errorMessage];
}
