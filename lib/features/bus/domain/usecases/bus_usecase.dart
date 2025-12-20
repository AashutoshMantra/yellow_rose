import 'package:yellow_rose/dependncy_injection.dart';
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
import 'package:yellow_rose/features/bus/domain/entities/bus_search.dart';
import 'package:yellow_rose/features/bus/domain/repositories/bus_repository.dart';
import 'package:yellow_rose/features/bus/domain/usecases/bus_mapper_utility.dart';

abstract interface class BusUseCase {
  Future<List<BusCityResponse>> getBusCities();
  Future<BusSearchReqResPair> getBusSearchResponse(BusSearch request);
  Future<BusDetailResponse> getBusDetails(BusDetailRequest request);

  Future<BusOrderResponse> createOrder(BusOrderCreateRequest request);
  Future<BusOrderResponse> updateOrder(
      String orderId, BusOrderCreateRequest request);
  Future<BusBlockTicketResponse> blockTicket(
      String orderId, BusBlockTicketRequest request);
  Future<BusOrderBookResponse> bookOrder(String orderId, String tinNumber);

  Future<BusOrderResDetails> getOrderDetails(String orderId);
  Future<BusOrderCancellationResponse> cancelOrder(
      BusSeatCancellation busCancellationRequest);
}

class BusUseCaseImpl implements BusUseCase {
  final _busRepository = getIt<BusRepository>();

  @override
  Future<BusOrderResDetails> getOrderDetails(String orderId) async {
    return await _busRepository.getOrderDetails(orderId);
  }

  @override
  Future<List<BusCityResponse>> getBusCities() async {
    return await _busRepository.getBusCities();
  }

  @override
  Future<BusSearchReqResPair> getBusSearchResponse(BusSearch request) async {
    var busSearchRequest =
        BusMapperUtility.mapBusSearchToBusSearchRequest(request);
    return await _busRepository.getBusSearchResponse(busSearchRequest);
  }

  @override
  Future<BusDetailResponse> getBusDetails(BusDetailRequest request) async {
    return await _busRepository.getBusDetails(request);
  }

  @override
  Future<BusOrderResponse> createOrder(BusOrderCreateRequest request) async {
    return await _busRepository.createOrder(request);
  }

  @override
  Future<BusOrderResponse> updateOrder(
      String orderId, BusOrderCreateRequest request) async {
    return await _busRepository.updateOrder(orderId, request);
  }

  @override
  Future<BusBlockTicketResponse> blockTicket(
      String orderId, BusBlockTicketRequest request) async {
    return await _busRepository.blockTicket(orderId, request);
  }

  @override
  Future<BusOrderBookResponse> bookOrder(
      String orderId, String tinNumber) async {
    return await _busRepository.bookOrder(orderId, tinNumber);
  }

  @override
  Future<BusOrderCancellationResponse> cancelOrder(
      BusSeatCancellation busCancellationRequest) {
    return _busRepository.cancelOrder(busCancellationRequest);
  }
}
