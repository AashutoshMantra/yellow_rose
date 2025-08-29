import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yellow_rose/dependncy_injection.dart';
import 'package:yellow_rose/features/auth/data/models/billing_entity.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order/create_order_response.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order/update_order_detail_response.dart';
import 'package:yellow_rose/features/flight/domain/entities/passenger_details_entity.dart';
import 'package:yellow_rose/features/hotel/data/models/details/hotel_detail_resonse.dart';
import 'package:yellow_rose/features/hotel/data/models/order/hotel_booking_response.dart';
import 'package:yellow_rose/features/hotel/data/models/order/hotel_order_request.dart';
import 'package:yellow_rose/features/hotel/domain/entities/hotel_search.dart';
import 'package:yellow_rose/features/hotel/domain/entities/rooms/hotel_room.dart';
import 'package:yellow_rose/features/hotel/domain/entities/special_request.dart';
import 'package:yellow_rose/features/hotel/domain/usecases/hotel_book_use_case.dart';
import 'package:yellow_rose/features/hotel/domain/usecases/hotel_mapper_utiity.dart';

part 'hotel_book_state.dart';

class HotelBookCubit extends Cubit<HotelBookState> {
  HotelBookCubit() : super(HotelBookInitial());
  final _hotelBookUsecase = getIt<HotelBookUseCase>();
  void createOrderAndUpdate(HotelDetailResponse hotel, HotelRoom selectedRoom,
      HotelSearch hotelSearch) async {
    try {
      emit(HotelBookLoading());
      var createOrderResponse = await _hotelBookUsecase.createHotelOrder(
          hotel, selectedRoom, hotelSearch);

      emit(HotelBookLoaded(
          hotel: hotel,
          selectedRoom: selectedRoom,
          hotelSearch: hotelSearch,
          hotelBookingResponse: createOrderResponse));
    } catch (e) {}
  }

  bool doesPassengerExists(PassengerDetailsEntity passengerDetail) {
    if (state is HotelBookLoaded) {
      var oldPassengerDetails = (state as HotelBookLoaded).passengerDetails;

      var indexForSameName = oldPassengerDetails.indexWhere((pd) =>
          (pd.name + pd.lastName) ==
          passengerDetail.name + passengerDetail.lastName);
      if (indexForSameName != -1) {
        if (oldPassengerDetails[indexForSameName].id != passengerDetail.id) {
          return true;
        }
      }
    }
    return false;
  }

  void onAddUpdatePassenger(PassengerDetailsEntity passengerDetail) {
    if (state is HotelBookLoaded) {
      var passengerWithGivenId = (state as HotelBookLoaded)
          .passengerDetails
          .indexWhere((p) => p.id == passengerDetail.id);
      if (doesPassengerExists(passengerDetail)) {
        return;
      }
      var updatedPassengerDetails = [
        ...(state as HotelBookLoaded).passengerDetails
      ];
      if (passengerWithGivenId != -1) {
        updatedPassengerDetails[passengerWithGivenId] = passengerDetail;
      } else {
        var adultCount = updatedPassengerDetails
            .where((p) => p.passengerType.isAdult())
            .length;
        var childCount = updatedPassengerDetails
            .where((p) => p.passengerType.isChild())
            .length;
        var infantCount = updatedPassengerDetails
            .where((p) => p.passengerType.isInfant())
            .length;
        if ((passengerDetail.passengerType.isAdult() &&
                adultCount <
                    ((state as HotelBookLoaded).hotelSearch).adultCount!) ||
            (passengerDetail.passengerType.isChild() &&
                childCount <
                    ((((state as HotelBookLoaded).hotelSearch)
                            .childAges
                            ?.length) ??
                        0))) {
          updatedPassengerDetails.add(passengerDetail);
        }
      }
      emit((state as HotelBookLoaded)
          .copyWith(passengerDetails: updatedPassengerDetails));
    }
  }

  void onBillingEntityChange(BillingEntity? value) {
    emit((state as HotelBookLoaded).copyWith(billingEntity: value));
  }

  void onSpecialRequestChange(SpecialRequest? value) {
    emit((state as HotelBookLoaded).copyWith(specialRequest: value));
  }

  Future<UpdateOrderDetailResponse> udpatePassengerDetailInorder() async {
    if (state is HotelBookLoaded) {
      var hotelBookUdpateRequest =
          HotelMapperUtiity.createHotelBookingRequest(state as HotelBookLoaded);
      var hotelOrderRequest = HotelOrderRequest(
        hotelBookingRequest: hotelBookUdpateRequest,
        hotelRequest: null,
      );
      var updatedHotelOrder = await _hotelBookUsecase.updateHotelOrder(
          (state as HotelBookLoaded).hotelBookingResponse.orderNumber,
          hotelOrderRequest);
      emit((state as HotelBookLoaded)
          .copyWith(updateOrderDetailResponse: updatedHotelOrder));
      return updatedHotelOrder;
    }
    throw Exception("State not loaded booking hotel");
  }
}
