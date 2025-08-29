import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yellow_rose/dependncy_injection.dart';
import 'package:yellow_rose/features/hotel/data/models/details/hotel_detail_resonse.dart';
import 'package:yellow_rose/features/hotel/data/models/search/hotel_search_response.dart';
import 'package:yellow_rose/features/hotel/domain/entities/hotel_search.dart';
import 'package:yellow_rose/features/hotel/domain/entities/rooms/hotel_room.dart';
import 'package:yellow_rose/features/hotel/domain/usecases/hotel_book_use_case.dart';
import 'package:yellow_rose/features/hotel/domain/usecases/hotel_mapper_utiity.dart';

part 'hotel_detail_cubit_state.dart';

class HotelDetailCubitCubit extends Cubit<HotelDetailCubitState> {
  HotelDetailCubitCubit() : super(HotelDetailCubitInitial());
  final _hotelBookUsecase = getIt<HotelBookUseCase>();

  void loadInitial(
      HotelSearch hotelSearch, HotelSearchResponse hotelSearchResponse) async {
    try {
      emit(HotelDetailCubitLoading());
      var hotelDetails = await _hotelBookUsecase.getHotelDetails(
        hotelSearch,
        hotelSearchResponse,
      );
      var rooms = HotelMapperUtiity.getHotelRooms(hotelDetails);
      rooms.sort((a, b) =>
          a.hotelRooms.first.totalcost.compareTo(b.hotelRooms.first.totalcost));

      emit(HotelDetailCubitLoaded(
          hotelDetailResponse: hotelDetails, rooms: rooms));
    } catch (e) {
      emit(HotelDetailCubitError(e.toString()));
    }
  }
}
