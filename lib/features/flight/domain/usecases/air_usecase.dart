import 'package:yellow_rose/dependncy_injection.dart';
import 'package:yellow_rose/features/flight/data/models/airports.dart';
import 'package:yellow_rose/features/flight/data/models/airsearch/air_search_request.dart';
import 'package:yellow_rose/features/flight/data/models/airsearch/air_search_response.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order/create_order_response.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order/order_details.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order/update_order_detail_response.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order/update_payment.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order_status/order_status.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order_status/order_status_list.dart';
import 'package:yellow_rose/features/flight/data/models/booking/ssr_response.dart';
import 'package:yellow_rose/features/flight/data/models/pnr/pnr_retrieve_response.dart';
import 'package:yellow_rose/features/flight/data/models/seat_map/air_seat_map_request.dart';
import 'package:yellow_rose/features/flight/data/models/seat_map/air_seat_map_response.dart';
import 'package:yellow_rose/features/flight/domain/repositories/air_repository.dart';

abstract interface class AirUseCase {
  Future<List<Airport>> getAirports();
  Future<List<AirSearchResponse>> getAirSearchResponse(
      AirSearchRequest request);
  Airport? getAirportByIata(String iataCode);
  Future<AirSeatMapResponse> getSeatMap(
      String orderId, AirSeatMapRequest request);
  Future<SsrResponse> getSsr(String orderId, AirSeatMapRequest request);
  Future<CreateOrderResponse> createOrder(OrderDetails request);
  Future<UpdateOrderDetailResponse> updateOrder(
      String orderId, OrderDetails request);

  Future<OrderDetails> getOrderDetails(String orderId);
  Future<List<PNR_RetrieveResponseData>> bookOrder(String orderId);
  Future<CreateOrderResponse> updateOrderPayment(
      String orderId, UpdatePaymentRequest request);
  Future<List<OrderStatus>> getOrders(
      OrderStatusListRequest orderStatusListRequest);

  Future<OrderStatus> getDetailedOrderStauts(String orderId);
}

class AirUseCaseImpl implements AirUseCase {
  final _airRepo = getIt<AirRepository>();
  @override
  Future<List<Airport>> getAirports() async {
    return await _airRepo.getAirports();
  }

  @override
  Future<List<AirSearchResponse>> getAirSearchResponse(
      AirSearchRequest request) async {
    return await _airRepo.getAirSearchResponse(request);
  }

  @override
  Airport? getAirportByIata(String iataCode) {
    return _airRepo.getAirportByIata(iataCode);
  }

  @override
  Future<AirSeatMapResponse> getSeatMap(
      String orderId, AirSeatMapRequest request) async {
    return await _airRepo.getSeatMap(orderId, request);
  }

  @override
  Future<SsrResponse> getSsr(String orderId, AirSeatMapRequest request) async {
    return await _airRepo.getSsr(orderId, request);
  }

  @override
  Future<CreateOrderResponse> createOrder(OrderDetails request) async {
    return await _airRepo.createOrder(request);
  }

  @override
  Future<OrderDetails> getOrderDetails(String orderId) async {
    return await _airRepo.getOrderDetails(orderId);
  }

  @override
  Future<UpdateOrderDetailResponse> updateOrder(
      String orderId, OrderDetails request) async {
    return await _airRepo.updateOrder(orderId, request);
  }

  @override
  Future<List<PNR_RetrieveResponseData>> bookOrder(String orderId) async {
    return await _airRepo.bookOrder(orderId);
  }

  @override
  Future<CreateOrderResponse> updateOrderPayment(
      String orderId, UpdatePaymentRequest request) async {
    return await _airRepo.updateOrderPayment(orderId, request);
  }

  @override
  Future<OrderStatus> getDetailedOrderStauts(String orderId) {
    return _airRepo.getDetailedOrderStauts(orderId);
  }

  @override
  Future<List<OrderStatus>> getOrders(
      OrderStatusListRequest orderStatusListRequest) async {
    return await _airRepo.getOrders(orderStatusListRequest);
  }
}
