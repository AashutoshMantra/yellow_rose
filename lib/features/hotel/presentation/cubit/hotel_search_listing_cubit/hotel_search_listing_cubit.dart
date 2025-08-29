import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yellow_rose/dependncy_injection.dart';
import 'package:yellow_rose/features/flight/domain/usecases/air_usecase.dart';
import 'package:yellow_rose/features/hotel/data/models/search/hotel_response_list.dart';
import 'package:yellow_rose/features/hotel/data/models/search/hotel_search_response.dart';
import 'package:yellow_rose/features/hotel/domain/entities/hotel_search.dart';
import 'package:yellow_rose/features/hotel/domain/usecases/hotel_search_case.dart';

part 'hotel_search_listing_state.dart';

class HotelSearchListingCubit extends Cubit<HotelSearchListingState> {
  HotelSearchListingCubit(HotelSearch hotelSearch)
      : super(HotelSearchListingInitial(hotelSearch: hotelSearch));
  final _hotelUsecase = getIt<HotelSearchCase>();

  void searchHotels(HotelSearch hotelSearch) async {
    try {
      emit(HotelSearchListingLoading(hotelSearch: hotelSearch));

      var hotelSearchResponse = await _hotelUsecase.getHotels(hotelSearch);
      if (isClosed) return;
      emit(HotelSearchListingLoaded(
          hotelSearchResponse: hotelSearchResponse, hotelSearch: hotelSearch));
    } catch (e, stackTrace) {
      log("$e $stackTrace");
      if (isClosed) return;
      emit(HotelSearchListinError(e.toString(), hotelSearch: hotelSearch));
    }
  }
}
