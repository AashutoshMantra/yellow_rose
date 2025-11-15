import 'package:yellow_rose/core/app_config.dart';
import 'package:yellow_rose/core/utils/dio_client.dart';
import 'package:yellow_rose/dependncy_injection.dart';
import 'package:yellow_rose/features/bus/data/models/bus_details/bus_detail_request.dart';
import 'package:yellow_rose/features/bus/data/models/bus_details/bus_detail_response.dart';
import 'package:yellow_rose/features/bus/data/models/order/block_bus_ticket.dart';
import 'package:yellow_rose/features/bus/data/models/order/bus_order__create_request.dart';
import 'package:yellow_rose/features/bus/data/models/order/bus_order_book_response.dart';
import 'package:yellow_rose/features/bus/data/models/order/bus_order_res_detail.dart';
import 'package:yellow_rose/features/bus/data/models/order/bus_order_response.dart';
import 'package:yellow_rose/features/bus/data/models/search/base_search_respose_req_pair.dart';
import 'package:yellow_rose/features/bus/data/models/search/bus_city_response.dart';
import 'package:yellow_rose/features/bus/data/models/search/bus_search_request.dart';
import 'package:yellow_rose/features/bus/data/models/search/bus_search_response.dart';

abstract interface class BusService {
  Future<List<BusCityResponse>> getBusCities();
  Future<BusSearchReqResPair> getBusSearchResponse(BusSearchRequest request);
  Future<BusDetailResponse> getBusDetails(BusDetailRequest request);

  Future<BusOrderResponse> createOrder(BusOrderCreateRequest request);
  Future<BusOrderResponse> updateOrder(
      String orderId, BusOrderCreateRequest request);
  Future<BusBlockTicketRequest> blockTicket(
      String orderId, BusBlockTicketRequest request);
  Future<BusOrderBookResponse> bookOrder(String orderId, String tinNumber);

  Future<BusOrderResDetails> getOrderDetails(String orderId);
}

class BusServiceImpl implements BusService {
  final _dioClient = getIt<DioClient>();
  @override
  Future<List<BusCityResponse>> getBusCities() async {
    var response = await _dioClient
        .get('${AppConfig.instance.apiBaseUrl}/product/bus/cities/D');
    var busCities = List<BusCityResponse>.empty(growable: true);
    for (var city in (response.data as List)) {
      busCities.add(BusCityResponse.fromMap(city));
    }
    return busCities;
  }

  @override
  Future<BusSearchReqResPair> getBusSearchResponse(
      BusSearchRequest request) async {
    var response = await _dioClient.post(
        "${AppConfig.instance.apiBaseUrl}/product/bus/bus-search",
        data: request.toMap());

    return BusSearchReqResPair.fromMap(response.data);
  }

  @override
  Future<BusDetailResponse> getBusDetails(BusDetailRequest request) async {
    var response = await _dioClient.post(
        "${AppConfig.instance.apiBaseUrl}/product/bus/bus-details",
        data: request.toMap());

    return BusDetailResponse.fromMap(response.data);
  }

  @override
  Future<BusOrderResponse> createOrder(BusOrderCreateRequest request) async {
    var response = await _dioClient.post(
        "${AppConfig.instance.apiBaseUrl}/order/bus/v1",
        data: request.toMap());

    return BusOrderResponse.fromMap(response.data);
  }

  @override
  Future<BusOrderResponse> updateOrder(
      String orderId, BusOrderCreateRequest request) async {
    var response = await _dioClient.put(
        "${AppConfig.instance.apiBaseUrl}/order/bus/v1/$orderId",
        data: request.toMap());

    return BusOrderResponse.fromMap(response.data);
  }

  @override
  Future<BusBlockTicketRequest> blockTicket(
      String orderId, BusBlockTicketRequest request) async {
    var response = await _dioClient.post(
        "${AppConfig.instance.apiBaseUrl}/order/bus/block/v1/$orderId",
        data: request.toMap());

    return BusBlockTicketRequest.fromMap(response.data);
  }

  @override
  Future<BusOrderBookResponse> bookOrder(
      String orderId, String tinNumber) async {
    var response = await _dioClient.post(
      "${AppConfig.instance.apiBaseUrl}/order/bus/book/v1/$orderId/$tinNumber",
    );

    return BusOrderBookResponse.fromMap(response.data);
  }

  @override
  Future<BusOrderResDetails> getOrderDetails(String orderId) async {
    var response = await _dioClient.get(
      "${AppConfig.instance.apiBaseUrl}/order/bus/v1/$orderId",
    );

    return BusOrderResDetails.fromMap(response.data);
  }
}
