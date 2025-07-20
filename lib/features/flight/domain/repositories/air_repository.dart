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
import 'package:yellow_rose/features/flight/presentation/pages/order_status_screen.dart';

abstract interface class AirRepository {
  Future<List<Airport>> getAirports();
  Future<List<AirSearchResponse>> getAirSearchResponse(
      AirSearchRequest request);
  Airport? getAirportByIata(String iataCode);
  Future<AirSeatMapResponse> getSeatMap(
      String orderId, AirSeatMapRequest request);
  Future<SsrResponse> getSsr(String orderId, AirSeatMapRequest request);
   Future<CreateOrderResponse> createOrder(OrderDetails request);
  Future<UpdateOrderDetailResponse> updateOrder(String orderId, OrderDetails request);

  Future<OrderDetails> getOrderDetails(String orderId);
    Future<List<PNR_RetrieveResponseData>> bookOrder(String orderId);
  Future<CreateOrderResponse> updateOrderPayment(
      String orderId, UpdatePaymentRequest request);

      Future<List<OrderStatus>> getOrders(
      OrderStatusListRequest orderStatusListRequest);

  Future<OrderStatus> getDetailedOrderStauts(String orderId);
  
}
