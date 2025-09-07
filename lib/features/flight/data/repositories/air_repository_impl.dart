import 'package:collection/collection.dart';
import 'package:yellow_rose/dependncy_injection.dart';
import 'package:yellow_rose/features/flight/data/datasources/air_local_service.dart';
import 'package:yellow_rose/features/flight/data/datasources/air_searvice.dart';
import 'package:yellow_rose/features/flight/data/models/airports.dart';
import 'package:yellow_rose/features/flight/data/models/airsearch/air_search_request.dart';
import 'package:yellow_rose/features/flight/data/models/airsearch/air_search_response.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order/create_order_response.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order/order_cancel.dart';
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
import 'package:yellow_rose/features/flight/presentation/pages/order_status_screen.dart';

class AirRepositoryImpl implements AirRepository {
  final _airService = getIt<AirService>();
  final _airLocalService = getIt<AirLocalService>();
  List<Airport>? _cachedAirports; // Local cache

  @override
  Future<List<Airport>> getAirports() async {
    if (_cachedAirports != null) {
      return _cachedAirports!; // Return from memory if already loaded
    }
    List<Airport> cachedJson = await _airLocalService.getAirports();

    if (cachedJson.isNotEmpty) {
      _cachedAirports = cachedJson;
      return cachedJson;
    }
    final apiResults = await _airService.getAirports();
    // await _airLocalService
    //     .cacheAirports(apiResults.map((d) => d.toMap()).toList());
    _cachedAirports = apiResults;
    return apiResults;
  }

  @override
  Future<List<AirSearchResponse>> getAirSearchResponse(
      AirSearchRequest request) async {
    return await _airService.getAirSearchResponse(request);
  }

  @override
  Airport? getAirportByIata(String iataCode) {
    return _cachedAirports?.firstWhereOrNull(
      (airport) => airport.iataCode?.toLowerCase() == iataCode.toLowerCase(),
    );
  }

  @override
  Future<AirSeatMapResponse> getSeatMap(
      String orderId, AirSeatMapRequest request) async {
    return await _airService.getSeatMap(orderId, request);
  }

  @override
  Future<SsrResponse> getSsr(String orderId, AirSeatMapRequest request) async {
    return await _airService.getSsr(orderId, request);
  }

  @override
  Future<CreateOrderResponse> createOrder(OrderDetails request) async {
    return await _airService.createOrder(request);
  }

  @override
  Future<OrderDetails> getOrderDetails(String orderId) async {
    return await _airService.getOrderDetails(orderId);
  }

  @override
  Future<UpdateOrderDetailResponse> updateOrder(
      String orderId, OrderDetails request) async {
    return await _airService.updateOrder(orderId, request);
  }

  @override
  Future<List<PNR_RetrieveResponseData>> bookOrder(String orderId) async {
    return await _airService.bookOrder(orderId);
  }

  @override
  Future<CreateOrderResponse> updateOrderPayment(
      String orderId, UpdatePaymentRequest request) async {
    return await _airService.updateOrderPayment(orderId, request);
  }

  @override
  Future<OrderStatus> getDetailedOrderStauts(String orderId) {
    return _airService.getDetailedOrderStauts(orderId);
  }

  @override
  Future<List<OrderStatus>> getOrders(
      OrderStatusListRequest orderStatusListRequest) async {
    return await _airService.getOrders(orderStatusListRequest);
  }

  @override
  Future<List<PNR_RetrieveResponseData>> cancelOrder(
      OrderCancelRequest cancelRequest, String orderId) {
    return _airService.cancelOrder(cancelRequest, orderId);
  }
}
