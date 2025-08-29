import 'package:flutter_google_maps_webservices/places.dart';
import 'package:yellow_rose/features/hotel/data/models/places/places.dart';

abstract class PlaceRepository {
  Future<PlacesAutocompleteResponse> getPlaceSuggestions(String query);
  Future<PlaceEntity?> getPlaceDetails(String placeId);
}
