part of 'bus_book_cubit.dart';

sealed class BusBookState {
  const BusBookState();
}

final class BusBookInitial extends BusBookState {}

final class BusBookLoading extends BusBookState {}

class BusBookLoaded extends BusBookState with EquatableMixin {
  final BusDetailResponse busDetailResponse;
  final BusSearchResponse busSearchResponse;
  final BusSearch busSearch;
  final Set<String> selectedSeats;
  final BusPoint? selectedBoardingPoint;
  final BusPoint? selectedDroppingPoint;
  final List<PassengerDetailsEntity> passengers;
  final BillingEntity? billingEntity;
  final BusOrderResponse busOrderResponse;
  final BusOrderResponse? updateOrderDetailResponse;

  BusBookLoaded({
    required this.busDetailResponse,
    required this.busSearchResponse,
    required this.busSearch,
    required this.selectedSeats,
    required this.selectedBoardingPoint,
    required this.selectedDroppingPoint,
    this.passengers = const [],
    this.billingEntity,
    required this.busOrderResponse,
    this.updateOrderDetailResponse,
  });

  BusBookLoaded copyWith({
    BusDetailResponse? busDetailResponse,
    BusSearchResponse? busSearchResponse,
    BusSearch? busSearch,
    Set<String>? selectedSeats,
    BusPoint? selectedBoardingPoint,
    BusPoint? selectedDroppingPoint,
    List<PassengerDetailsEntity>? passengers,
    BillingEntity? billingEntity,
    BusOrderResponse? busOrderResponse,
    BusOrderResponse? updateOrderDetailResponse,
  }) {
    return BusBookLoaded(
      busDetailResponse: busDetailResponse ?? this.busDetailResponse,
      busSearchResponse: busSearchResponse ?? this.busSearchResponse,
      busSearch: busSearch ?? this.busSearch,
      selectedSeats: selectedSeats ?? this.selectedSeats,
      selectedBoardingPoint:
          selectedBoardingPoint ?? this.selectedBoardingPoint,
      selectedDroppingPoint:
          selectedDroppingPoint ?? this.selectedDroppingPoint,
      passengers: passengers ?? this.passengers,
      billingEntity: billingEntity ?? this.billingEntity,
      busOrderResponse: busOrderResponse ?? this.busOrderResponse,
      updateOrderDetailResponse:
          updateOrderDetailResponse ?? this.updateOrderDetailResponse,
    );
  }

  @override
  List<Object?> get props => [
        busDetailResponse,
        busSearchResponse,
        busSearch,
        selectedSeats,
        selectedBoardingPoint,
        selectedDroppingPoint,
        passengers,
        billingEntity,
        busOrderResponse,
        updateOrderDetailResponse,
      ];
}

class BusBookError extends BusBookState with EquatableMixin {
  final String errorMessage;

  const BusBookError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
