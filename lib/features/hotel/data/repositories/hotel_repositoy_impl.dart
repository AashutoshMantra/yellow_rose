import 'package:yellow_rose/dependncy_injection.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order/create_order_response.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order/update_order_detail_response.dart';
import 'package:yellow_rose/features/hotel/data/datasources/hotel_service.dart';
import 'package:yellow_rose/features/hotel/data/models/details/hotel_detail_request.dart';
import 'package:yellow_rose/features/hotel/data/models/details/hotel_detail_resonse.dart';
import 'package:yellow_rose/features/hotel/data/models/order/hotel_booking_response.dart';
import 'package:yellow_rose/features/hotel/data/models/order/hotel_order_request.dart';
import 'package:yellow_rose/features/hotel/data/models/search/hotel_response_list.dart';
import 'package:yellow_rose/features/hotel/data/models/search/hotel_search_request.dart';
import 'package:yellow_rose/features/hotel/data/models/search/hotel_search_response.dart';
import 'package:yellow_rose/features/hotel/domain/repositories/hotel_repository.dart';

class HotelRepositoryImpl implements HotelRepository{
  final _hotelService = getIt<HotelService>();
  @override
  Future<HotelBookingResponse> bookHotel(String orderId) {
    return _hotelService.bookHotel(orderId);
  }

  @override
  Future<CreateOrderResponse> createHotelOrder(HotelOrderRequest hotelOrderRequest) {
    return _hotelService.createHotelOrder(hotelOrderRequest);
  }

  @override
  Future<HotelDetailResponse> getHotelDetails(HotelDetailRequest hotelDetailRequest) {
    return _hotelService.getHotelDetails(hotelDetailRequest);
  }

  @override
  Future<HotelResponseList> getHotels(HotelListSearchRequest hotelSearchRequest) {
    return _hotelService.getHotels(hotelSearchRequest);
  }

  @override
  Future<UpdateOrderDetailResponse> updateHotelOrder(String orderId, HotelOrderRequest hotelOrderRequest) {
    return _hotelService.updateHotelOrder(orderId, hotelOrderRequest);
  }

}