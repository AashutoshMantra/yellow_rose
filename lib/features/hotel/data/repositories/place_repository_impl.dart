import 'package:flutter_google_maps_webservices/src/places.dart';
import 'package:yellow_rose/dependncy_injection.dart';
import 'package:yellow_rose/features/hotel/data/datasources/place_service.dart';
import 'package:yellow_rose/features/hotel/data/models/places/places.dart';
import 'package:yellow_rose/features/hotel/domain/repositories/place_repository.dart';

class PlaceRepositoryImpl implements PlaceRepository {
  final _placeService = getIt<PlaceDataSource>();
  @override
  Future<PlaceEntity?> getPlaceDetails(String placeId) {
    return _placeService.getPlaceDetails(placeId);
  }

  @override
  Future<PlacesAutocompleteResponse> getPlaceSuggestions(String query) {
    return _placeService.getPlaceSuggestions(query);
  }
}
