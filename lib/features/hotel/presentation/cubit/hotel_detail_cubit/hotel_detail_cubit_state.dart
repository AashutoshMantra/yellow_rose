part of 'hotel_detail_cubit_cubit.dart';

sealed class HotelDetailCubitState extends Equatable {
  const HotelDetailCubitState();

  @override
  List<Object> get props => [];
}

final class HotelDetailCubitInitial extends HotelDetailCubitState {}

final class HotelDetailCubitLoading extends HotelDetailCubitState {}

final class HotelDetailCubitLoaded extends HotelDetailCubitState {
  final HotelDetailResponse hotelDetailResponse;
  final List<HotelRoom> rooms;

  const HotelDetailCubitLoaded({
    required this.hotelDetailResponse,
    required this.rooms,
  });

  @override
  List<Object> get props => [hotelDetailResponse, rooms];
}

final class HotelDetailCubitError extends HotelDetailCubitState {
  final String errorMessage;
  const HotelDetailCubitError(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}
