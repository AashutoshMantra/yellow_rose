import 'package:yellow_rose/dependncy_injection.dart';
import 'package:yellow_rose/features/bus/data/datasources/bus_local_service.dart';
import 'package:yellow_rose/features/bus/data/datasources/bus_service.dart';
import 'package:yellow_rose/features/bus/data/models/bus_details/bus_detail_request.dart';
import 'package:yellow_rose/features/bus/data/models/bus_details/bus_detail_response.dart';
import 'package:yellow_rose/features/bus/data/models/order/block_bus_ticket.dart';
import 'package:yellow_rose/features/bus/data/models/order/bos_block_response.dart';
import 'package:yellow_rose/features/bus/data/models/order/bus_order__create_request.dart';
import 'package:yellow_rose/features/bus/data/models/order/bus_order_book_response.dart';
import 'package:yellow_rose/features/bus/data/models/order/bus_order_cancellation.dart';
import 'package:yellow_rose/features/bus/data/models/order/bus_order_cancellation_response.dart';
import 'package:yellow_rose/features/bus/data/models/order/bus_order_res_detail.dart';
import 'package:yellow_rose/features/bus/data/models/order/bus_order_response.dart';
import 'package:yellow_rose/features/bus/data/models/search/base_search_respose_req_pair.dart';
import 'package:yellow_rose/features/bus/data/models/search/bus_city_response.dart';
import 'package:yellow_rose/features/bus/data/models/search/bus_search_request.dart';
import 'package:yellow_rose/features/bus/domain/repositories/bus_repository.dart';

class BusRepositoryImpl implements BusRepository {
  final _busService = getIt<BusService>();
  final _busLocalService = getIt<BusLocalService>();
  final List<BusCityResponse> _cachedBusCities = [];

  @override
  Future<BusOrderResDetails> getOrderDetails(String orderId) async {
    return await _busService.getOrderDetails(orderId);
  }

  @override
  Future<List<BusCityResponse>> getBusCities() async {
    if (_cachedBusCities.isNotEmpty) {
      return _cachedBusCities;
    }
    List<BusCityResponse> cachedJson = await _busLocalService.getBusCities();

    if (cachedJson.isNotEmpty) {
      _cachedBusCities.addAll(cachedJson);
      return cachedJson;
    }
    final apiResults = await _busService.getBusCities();
    await _busLocalService
        .cacheBusCities(apiResults.map((d) => d.toMap()).toList());
    _cachedBusCities.addAll(apiResults);
    return apiResults;
  }

  @override
  Future<BusSearchReqResPair> getBusSearchResponse(
      BusSearchRequest request) async {
    return await _busService.getBusSearchResponse(request);
  }

  @override
  Future<BusDetailResponse> getBusDetails(BusDetailRequest request) async {
    return await _busService.getBusDetails(request);
  }

  @override
  Future<BusOrderResponse> createOrder(BusOrderCreateRequest request) async {
    return await _busService.createOrder(request);
  }

  @override
  Future<BusOrderResponse> updateOrder(
      String orderId, BusOrderCreateRequest request) async {
    return await _busService.updateOrder(orderId, request);
  }

  @override
  Future<BusBlockTicketResponse> blockTicket(
      String orderId, BusBlockTicketRequest request) async {
    return await _busService.blockTicket(orderId, request);
  }

  @override
  Future<BusOrderBookResponse> bookOrder(
      String orderId, String tinNumber) async {
    return await _busService.bookOrder(orderId, tinNumber);
  }

  @override
  Future<BusOrderCancellationResponse> cancelOrder(
      BusSeatCancellation busCancellationRequest) {
    return _busService.cancelOrder(busCancellationRequest);
  }
}
