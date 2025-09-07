part of 'flight_order_modify_cubit.dart';

class FlightOrderModifyState extends Equatable {
  final String errorMessage;
  final bool isLoading;
  final AirOrderItinerary airOrderItinerary;
  final OrderStatus? orderStatus;
  final String orderId;
  final bool done;
  final List<int> selectedPassenger;
  const FlightOrderModifyState({
    this.errorMessage = "",
    this.isLoading = false,
    required this.airOrderItinerary,
    this.orderStatus,
    this.done = false,
    required this.orderId,
    List<int>? selectedPassenger,
  }) : selectedPassenger = selectedPassenger ?? const [];

  factory FlightOrderModifyState.initial(
      {required AirOrderItinerary airOrderItinerary,
      OrderStatus? orderStatus,
      required String orderId}) {
    return FlightOrderModifyState(
      airOrderItinerary: airOrderItinerary,
      orderStatus: orderStatus,
      orderId: orderId,
    );
  }

  @override
  List<Object?> get props => [
        errorMessage,
        isLoading,
        airOrderItinerary,
        orderStatus,
        orderId,
        selectedPassenger,
        done
      ];

  FlightOrderModifyState copyWith({
    String? errorMessage,
    bool? isLoading,
    AirOrderItinerary? airOrderItinerary,
    OrderStatus? orderStatus,
    String? orderId,
    bool? done,
    List<int>? selectedPassenger,
  }) {
    return FlightOrderModifyState(
      errorMessage: errorMessage ?? this.errorMessage,
      isLoading: isLoading ?? this.isLoading,
      airOrderItinerary: airOrderItinerary ?? this.airOrderItinerary,
      orderStatus: orderStatus ?? this.orderStatus,
      orderId: orderId ?? this.orderId,
      done: done ?? this.done,
      selectedPassenger: selectedPassenger ?? this.selectedPassenger,
    );
  }
}
