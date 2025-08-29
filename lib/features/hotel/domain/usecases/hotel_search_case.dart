import 'package:flutter_google_maps_webservices/places.dart';
import 'package:yellow_rose/dependncy_injection.dart';
import 'package:yellow_rose/features/hotel/data/models/places/places.dart';
import 'package:yellow_rose/features/hotel/data/models/search/hotel_response_list.dart';
import 'package:yellow_rose/features/hotel/data/models/search/hotel_search_request.dart';
import 'package:yellow_rose/features/hotel/data/models/search/hotel_search_response.dart';
import 'package:yellow_rose/features/hotel/domain/entities/hotel_search.dart';
import 'package:yellow_rose/features/hotel/domain/repositories/hotel_repository.dart';
import 'package:yellow_rose/features/hotel/domain/repositories/place_repository.dart';
import 'package:yellow_rose/features/hotel/domain/usecases/hotel_mapper_utiity.dart';

abstract class HotelSearchCase {
  Future<HotelResponseList> getHotels(HotelSearch hotelSearchRequest);
  Future<PlacesAutocompleteResponse> getPlaceSuggestions(String query);
  Future<PlaceEntity?> getPlaceDetails(String placeId);
}

class HotelSearchCaseImpl implements HotelSearchCase {
  final _hotelRepository = getIt<HotelRepository>();
  final _placeRepository = getIt<PlaceRepository>();

  @override
  Future<HotelResponseList> getHotels(HotelSearch hotelSearch) {
    var hotelSearchRequest =
        HotelMapperUtiity.mapToHotelSearchRequest(hotelSearch);

    return _hotelRepository.getHotels(hotelSearchRequest);
  }

  @override
  Future<PlacesAutocompleteResponse> getPlaceSuggestions(String query) {
    return _placeRepository.getPlaceSuggestions(query);
  }

  @override
  Future<PlaceEntity?> getPlaceDetails(String placeId) {
    return _placeRepository.getPlaceDetails(placeId);
  }
}
