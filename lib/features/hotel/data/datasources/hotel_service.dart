import 'dart:developer';

import 'package:yellow_rose/core/app_config.dart';
import 'package:yellow_rose/core/utils/dio_client.dart';
import 'package:yellow_rose/dependncy_injection.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order/create_order_response.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order/update_order_detail_response.dart';
import 'package:yellow_rose/features/hotel/data/models/details/hotel_detail_request.dart';
import 'package:yellow_rose/features/hotel/data/models/details/hotel_detail_resonse.dart';
import 'package:yellow_rose/features/hotel/data/models/order/hotel_booking_response.dart';
import 'package:yellow_rose/features/hotel/data/models/order/hotel_order_request.dart';
import 'package:yellow_rose/features/hotel/data/models/search/hotel_response_list.dart';
import 'package:yellow_rose/features/hotel/data/models/search/hotel_search_request.dart';
import 'package:yellow_rose/features/hotel/data/models/search/hotel_search_response.dart';

abstract class HotelService {
  Future<HotelResponseList> getHotels(
      HotelListSearchRequest hotelSearchRequest);
  Future<HotelDetailResponse> getHotelDetails(
      HotelDetailRequest hotelSearchRequest);
  Future<CreateOrderResponse> createHotelOrder(
      HotelOrderRequest hotelOrderRequest);
  Future<UpdateOrderDetailResponse> updateHotelOrder(
      String orderId, HotelOrderRequest hotelOrderRequest);
  Future<dynamic> udpateHotelPriceDetail(String orderId);
  Future<HotelBookingResponse> bookHotel(String orderId);
}

class HotelServiceImpl implements HotelService {
  final _dioClient = getIt<DioClient>();

  @override
  Future<HotelResponseList> getHotels(
      HotelListSearchRequest hotelSearchRequest) async {
    var response = await _dioClient.post(
        "${AppConfig.instance.apiBaseUrl}/product/hotel/_search",
        data: hotelSearchRequest.toMap());
    if (response.data == null || response.data.isEmpty) {
      return HotelResponseList(hotels: []);
    }

    return HotelResponseList.fromMap(response.data[0]);
  }

  @override
  Future<HotelDetailResponse> getHotelDetails(
      HotelDetailRequest hotelDetailRequest) async {
    var response = await _dioClient.post(
        "${AppConfig.instance.apiBaseUrl}/product/hotel/_hotelDetails",
        data: hotelDetailRequest.toMap());
    return HotelDetailResponse.fromMap(response.data);
  }

  @override
  Future<CreateOrderResponse> createHotelOrder(
      HotelOrderRequest hotelOrderRequest) async {
    var response = await _dioClient.post(
        "${AppConfig.instance.apiBaseUrl}/order/hotel/v1",
        data: hotelOrderRequest.toMap());
    return CreateOrderResponse.fromMap(response.data);
  }

  @override
  Future<UpdateOrderDetailResponse> updateHotelOrder(
      String orderId, HotelOrderRequest hotelOrderRequest) async {
    var response = await _dioClient.post(
        "${AppConfig.instance.apiBaseUrl}/order/hotel/v1/$orderId",
        data: hotelOrderRequest.toMap());
    // log(hotelOrderRequest.toJson());
    return UpdateOrderDetailResponse.fromMap(response.data);
  }

  @override
  Future<HotelBookingResponse> bookHotel(String orderId) async {
    var response = await _dioClient
        .post("${AppConfig.instance.apiBaseUrl}/order/hotel/book/v1/$orderId");

    if (response.data["resStatus"] != "OK") {
      throw Exception(response.data["message"] ?? "Something went wrong");
    }
    return HotelBookingResponse.fromMap(response.data?["result"]);
  }

  @override
  Future udpateHotelPriceDetail(String orderId) async {
    var response = await _dioClient.post(
        "${AppConfig.instance.apiBaseUrl}/order/hotel/details/v1/$orderId",
        data: {});
    return response.data;
  }
}
