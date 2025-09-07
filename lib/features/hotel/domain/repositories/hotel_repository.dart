import 'package:yellow_rose/features/flight/data/models/booking/order/create_order_response.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order/update_order_detail_response.dart';
import 'package:yellow_rose/features/hotel/data/models/details/hotel_detail_request.dart';
import 'package:yellow_rose/features/hotel/data/models/details/hotel_detail_resonse.dart';
import 'package:yellow_rose/features/hotel/data/models/order/hotel_booking_response.dart';
import 'package:yellow_rose/features/hotel/data/models/order/hotel_order_request.dart';
import 'package:yellow_rose/features/hotel/data/models/search/hotel_response_list.dart';
import 'package:yellow_rose/features/hotel/data/models/search/hotel_search_request.dart';
import 'package:yellow_rose/features/hotel/data/models/search/hotel_search_response.dart';

abstract class HotelRepository {
  Future<HotelResponseList> getHotels(
      HotelListSearchRequest hotelSearchRequest);
  Future<HotelDetailResponse> getHotelDetails(
      HotelDetailRequest hotelDetailRequest);
  Future<CreateOrderResponse> createHotelOrder(
      HotelOrderRequest hotelOrderRequest);
  Future<UpdateOrderDetailResponse> updateHotelOrder(
      String orderId, HotelOrderRequest hotelOrderRequest);
  Future<HotelBookingResponse> bookHotel(String orderId);
    Future<dynamic> udpateHotelPriceDetail(String orderId);

  
}