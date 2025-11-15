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

abstract interface class BusRepository {
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
