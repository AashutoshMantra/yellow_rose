import 'package:yellow_rose/dependncy_injection.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order/create_order_response.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order/update_order_detail_response.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order/update_payment.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order_status/order_status.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order_status/order_status_list.dart';
import 'package:yellow_rose/features/flight/domain/usecases/air_usecase.dart';
import 'package:yellow_rose/features/hotel/data/models/details/hotel_detail_request.dart';
import 'package:yellow_rose/features/hotel/data/models/details/hotel_detail_resonse.dart';
import 'package:yellow_rose/features/hotel/data/models/order/hotel_booking_response.dart';
import 'package:yellow_rose/features/hotel/data/models/order/hotel_order_request.dart';
import 'package:yellow_rose/features/hotel/data/models/search/hotel_search_response.dart';
import 'package:yellow_rose/features/hotel/domain/entities/hotel_search.dart';
import 'package:yellow_rose/features/hotel/domain/entities/rooms/hotel_room.dart';
import 'package:yellow_rose/features/hotel/domain/repositories/hotel_repository.dart';
import 'package:yellow_rose/features/hotel/domain/usecases/hotel_mapper_utiity.dart';
import 'package:yellow_rose/features/trip/data/models/trip_response.dart';

abstract class HotelBookUseCase {
  Future<HotelDetailResponse> getHotelDetails(
      HotelSearch hotelSearch, HotelSearchResponse hotelSearchResponse);
  Future<CreateOrderResponse> createHotelOrder(HotelDetailResponse hotel,
      HotelRoom selectedRoom, HotelSearch hotelSearch,{TripResponse? trip});
  Future<UpdateOrderDetailResponse> updateHotelOrder(
      String orderId, HotelOrderRequest hotelOrderRequest);
  Future<HotelBookingResponse> bookHotel(String orderId);
  Future<CreateOrderResponse> updateOrderPayment(
      String orderId, UpdatePaymentRequest paymentRequest);

  Future<List<OrderStatus>> getOrders(
      OrderStatusListRequest orderStatusListRequest);
  Future<dynamic> udpateHotelPriceDetail(String orderId);

  Future<OrderStatus> getDetailedOrderStauts(String orderId);
}

class HotelBookUseCaseImpl implements HotelBookUseCase {
  final _hotelRepository = getIt<HotelRepository>();
  final _airUseCase = getIt<AirUseCase>();

  @override
  Future<HotelDetailResponse> getHotelDetails(
      HotelSearch hotelSearch, HotelSearchResponse hotelSearchResponse) {
    var hotelDetailRequest = HotelMapperUtiity.mapToHotelDetailRequest(
      hotelSearch,
      hotelSearchResponse,
    );
    return _hotelRepository.getHotelDetails(hotelDetailRequest);
  }

  @override
  Future<CreateOrderResponse> createHotelOrder(HotelDetailResponse hotel,
      HotelRoom selectedRoom, HotelSearch hotelSearch,{TripResponse? trip}) async {
    var orderRequest = HotelMapperUtiity.createHotelOrderRequest(
        hotel, selectedRoom, hotelSearch,trip: trip);
    var response = await _hotelRepository.createHotelOrder(orderRequest);
    var repriceResponse = await udpateHotelPriceDetail(response.orderNumber);
    return response;
  }

  @override
  Future<UpdateOrderDetailResponse> updateHotelOrder(
      String orderId, HotelOrderRequest hotelOrderRequest) {
    return _hotelRepository.updateHotelOrder(orderId, hotelOrderRequest);
  }

  @override
  Future<HotelBookingResponse> bookHotel(String orderId) {
    return _hotelRepository.bookHotel(orderId);
  }

  @override
  Future<CreateOrderResponse> updateOrderPayment(
      String orderId, UpdatePaymentRequest paymentRequest) {
    return _airUseCase.updateOrderPayment(orderId, paymentRequest);
  }

  @override
  Future<OrderStatus> getDetailedOrderStauts(String orderId) {
    return _airUseCase.getDetailedOrderStauts(orderId);
  }

  @override
  Future<List<OrderStatus>> getOrders(
      OrderStatusListRequest orderStatusListRequest) {
    return _airUseCase.getOrders(orderStatusListRequest);
  }

  @override
  Future udpateHotelPriceDetail(String orderId) {
    return _hotelRepository.udpateHotelPriceDetail(
      orderId,
    );
  }
}
