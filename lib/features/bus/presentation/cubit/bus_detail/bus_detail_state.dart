part of 'bus_detail_cubit.dart';

abstract class BusDetailState {}

class BusDetailInitial extends BusDetailState {}

class BusDetailLoading extends BusDetailState {}

class BusDetailLoaded extends BusDetailState {
  final BusDetailResponse busDetailResponse;
  final Set<String> selectedSeats;
  final BusPoint? selectedBoardingPoint;
  final BusPoint? selectedDroppingPoint;

  BusDetailLoaded({
    required this.busDetailResponse,
    this.selectedSeats = const {},
    this.selectedBoardingPoint,
    this.selectedDroppingPoint,
  });

  BusDetailLoaded copyWith({
    BusDetailResponse? busDetailResponse,
    Set<String>? selectedSeats,
    Nullable<BusPoint>? selectedBoardingPoint,
    Nullable<BusPoint>? selectedDroppingPoint,
  }) {
    return BusDetailLoaded(
      busDetailResponse: busDetailResponse ?? this.busDetailResponse,
      selectedSeats: selectedSeats ?? this.selectedSeats,
      selectedBoardingPoint: selectedBoardingPoint == null
          ? this.selectedBoardingPoint
          : selectedBoardingPoint.value,
      selectedDroppingPoint: selectedDroppingPoint == null
          ? this.selectedDroppingPoint
          : selectedDroppingPoint.value,
    );
  }
}

class BusDetailError extends BusDetailState {
  final String error;

  BusDetailError(this.error);
}
