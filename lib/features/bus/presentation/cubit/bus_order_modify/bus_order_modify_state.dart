part of 'bus_order_modify_cubit.dart';

class BusOrderModifyState extends Equatable {
  final BusOrderItinerary busOrderItinerary;
  final OrderStatus? orderStatus;
  final String orderId;
  final List<int> selectedPassenger;
  final bool isLoading;
  final String errorMessage;
  final bool done;

  const BusOrderModifyState({
    required this.busOrderItinerary,
    this.orderStatus,
    required this.orderId,
    required this.selectedPassenger,
    required this.isLoading,
    required this.errorMessage,
    required this.done,
  });

  factory BusOrderModifyState.initial({
    required BusOrderItinerary busOrderItinerary,
    OrderStatus? orderStatus,
    required String orderId,
  }) {
    return BusOrderModifyState(
      busOrderItinerary: busOrderItinerary,
      orderStatus: orderStatus,
      orderId: orderId,
      selectedPassenger: const [],
      isLoading: false,
      errorMessage: "",
      done: false,
    );
  }

  BusOrderModifyState copyWith({
    BusOrderItinerary? busOrderItinerary,
    OrderStatus? orderStatus,
    String? orderId,
    List<int>? selectedPassenger,
    bool? isLoading,
    String? errorMessage,
    bool? done,
  }) {
    return BusOrderModifyState(
      busOrderItinerary: busOrderItinerary ?? this.busOrderItinerary,
      orderStatus: orderStatus ?? this.orderStatus,
      orderId: orderId ?? this.orderId,
      selectedPassenger: selectedPassenger ?? this.selectedPassenger,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      done: done ?? this.done,
    );
  }

  @override
  List<Object?> get props => [
        busOrderItinerary,
        orderStatus,
        orderId,
        selectedPassenger,
        isLoading,
        errorMessage,
        done,
      ];
}
