import 'dart:convert';
import 'dart:developer';

import 'package:yellow_rose/core/app_config.dart';
import 'package:yellow_rose/core/utils/dio_client.dart';
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

abstract interface class AirService {
  Future<List<Airport>> getAirports();
  Future<List<AirSearchResponse>> getAirSearchResponse(
      AirSearchRequest request);
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

class AirServiceImpl implements AirService {
  final _dioClient = getIt<DioClient>();
  @override
  Future<List<Airport>> getAirports() async {
    var response = await _dioClient
        .post('${AppConfig.instance.apiBaseUrl}/crm/staticdata/airports');
    var airports = List<Airport>.empty(growable: true);
    for (var airport in (response.data as List)) {
      airports.add(Airport.fromMap(airport));
    }
    return airports;
  }

  @override
  Future<List<AirSearchResponse>> getAirSearchResponse(
      AirSearchRequest request) async {
    var response = await _dioClient.post(
        "${AppConfig.instance.apiBaseUrl}/product/air/_search/v1",
        data: request.toMap());

    var searchResponse = List<AirSearchResponse>.empty(growable: true);
    for (var airport in (response.data as List)) {
      searchResponse.add(AirSearchResponse.fromMap(airport));
    }
    return searchResponse;
  }

  @override
  Future<AirSeatMapResponse> getSeatMap(
      String orderId, AirSeatMapRequest request) async {
    var response = await _dioClient.post(
        "${AppConfig.instance.apiBaseUrl}/product/air/seatMap/v1/$orderId",
        data: request.toMap());

    return AirSeatMapResponse.fromMap(response.data);
  }

  @override
  Future<SsrResponse> getSsr(String orderId, AirSeatMapRequest request) async {
    var response = await _dioClient.post(
        "${AppConfig.instance.apiBaseUrl}/product/air/ssrMap/v1/$orderId",
        data: request.toMap());
    
    return SsrResponse.fromMap(response.data);
  }

  @override
  Future<CreateOrderResponse> createOrder(OrderDetails request) async {
    var response = await _dioClient.post(
        '${AppConfig.instance.apiBaseUrl}/order/v1',
        data: request.toMap());
    // log(jsonEncode(request.toMap()));

    return CreateOrderResponse.fromMap(response.data);
  }

  @override
  Future<OrderDetails> getOrderDetails(String orderId) async {
    var response = await _dioClient.post(
      '${AppConfig.instance.apiBaseUrl}/order/details/v1/$orderId',
    );

    return OrderDetails.fromMap(response.data);
  }

  @override
  Future<UpdateOrderDetailResponse> updateOrder(
      String orderId, OrderDetails request) async {
    var response = await _dioClient.post(
        '${AppConfig.instance.apiBaseUrl}/order/v1/$orderId',
        data: request.toMap());

    return UpdateOrderDetailResponse.fromMap(response.data);
  }

  @override
  Future<List<PNR_RetrieveResponseData>> bookOrder(String orderId) async {
    var response = await _dioClient.post(
      '${AppConfig.instance.apiBaseUrl}/order/book/v1/$orderId',
    );

    return List<PNR_RetrieveResponseData>.from(
        ((response.data?["result"]) ?? [])
            .map<PNR_RetrieveResponseData>(
                (data) => PNR_RetrieveResponseData.fromMap(data))
            .toList());
  }

  @override
  Future<CreateOrderResponse> updateOrderPayment(
      String orderId, UpdatePaymentRequest request) async {
    var response = await _dioClient.post(
      '${AppConfig.instance.apiBaseUrl}/order/v1/$orderId',
      data: request.toMap(),
    );
    return CreateOrderResponse.fromMap(response.data);
  }

  @override
  Future<List<OrderStatus>> getOrders(
      OrderStatusListRequest orderStatusListRequest) async {
    var response = await _dioClient.post(
      '${AppConfig.instance.apiBaseUrl}/order/orders',
      data: orderStatusListRequest.toJson(),
    );
    var data = response.data;

    return List<OrderStatus>.from(
        data["content"].map((d) => OrderStatus.fromMap(d)));
  }

  @override
  Future<OrderStatus> getDetailedOrderStauts(String orderId) async {
    var response = await _dioClient.get(
      '${AppConfig.instance.apiBaseUrl}/orders/findOrderByOrderId/$orderId',
    );

    return OrderStatus.fromMap(response.data);
  }
}
