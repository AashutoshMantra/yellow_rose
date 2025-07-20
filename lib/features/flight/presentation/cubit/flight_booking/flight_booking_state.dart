part of 'flight_booking_cubit.dart';

sealed class FlightBookingState extends Equatable {
  const FlightBookingState();

  @override
  List<Object?> get props => [];
}

final class FlightBookingInitial extends FlightBookingState {}

final class FlightBookingLoading extends FlightBookingState {}

class FlightBookingLoaded extends FlightBookingState {
  final List<AirResponseData> selectedItineraries;
  final Map<int, FareDetailsWithType> selectedFares;
  final List<PassengerDetailsEntity> passengerDetails;
  final Map<String, List<SelectedSeat>> selectedSeats;
  final Map<String, Map<String, SsrOption>> selectedSsr;
  final Map<String, AirSeatMapResponse?> seatMaps;
  final Map<String, SsrResponse?> ssrOptions;
  final OrderDetails orderDetails;
  final BillingEntity? billingEntity;
  final AirSearch airSearch;

  FlightBookingLoaded(
      {required this.selectedItineraries,
      required this.orderDetails,
      List<PassengerDetailsEntity>? passengerDetails,
      this.billingEntity,
      Map<int, FareDetailsWithType>? selectedFares,
      Map<String, List<SelectedSeat>>? selectedSeats,
      required this.airSearch,
      Map<String, Map<String, SsrOption>>? selectedSsr,
      Map<String, AirSeatMapResponse?>? seatMaps,
      Map<String, SsrResponse?>? ssrOptions})
      : selectedFares = selectedFares ??
            Map.fromEntries(selectedItineraries.mapIndexed(
                (idx, itinarary) => MapEntry(idx, itinarary.fare.first))),
        passengerDetails = passengerDetails ?? [],
        selectedSeats = selectedSeats ?? <String, List<SelectedSeat>>{},
        selectedSsr = selectedSsr ?? <String, Map<String, SsrOption>>{},
        seatMaps = seatMaps ?? <String, AirSeatMapResponse>{},
        ssrOptions = ssrOptions ?? <String, SsrResponse>{};

  FlightBookingLoaded copyWith({
    List<AirResponseData>? selectedItineraries,
    Map<int, FareDetailsWithType>? selectedFares,
    List<PassengerDetailsEntity>? passengerDetails,
    Map<String, List<SelectedSeat>>? selectedSeats,
    Map<String, Map<String, SsrOption>>? selectedSsr,
    Map<String, AirSeatMapResponse?>? seatMaps,
    Map<String, SsrResponse?>? ssrOptions,
    OrderDetails? orderDetails,
    BillingEntity? billingEntity,
     AirSearch? airSearch
  }) {
    return FlightBookingLoaded(
      selectedItineraries: selectedItineraries ?? this.selectedItineraries,
      selectedFares: selectedFares ?? this.selectedFares,
      passengerDetails: passengerDetails ?? this.passengerDetails,
      selectedSeats: selectedSeats ?? this.selectedSeats,
      selectedSsr: selectedSsr ?? this.selectedSsr,
      seatMaps: seatMaps ?? this.seatMaps,
      ssrOptions: ssrOptions ?? this.ssrOptions,
      orderDetails: orderDetails ?? this.orderDetails,
      billingEntity: billingEntity ?? this.billingEntity,
      airSearch: airSearch??this.airSearch
    );
  }

  @override
  List<Object?> get props => [
        selectedItineraries,
        selectedFares,
        passengerDetails,
        selectedSeats,
        selectedSsr,
        ssrOptions,
        seatMaps,
        orderDetails,
        billingEntity,
        airSearch
      ];
}

class FlightBookingError extends FlightBookingState {
  final String errorMessage;

  const FlightBookingError(
    this.errorMessage,
  );

  @override
  List<Object> get props => [errorMessage];
}
