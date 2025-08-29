import 'package:flutter_google_maps_webservices/places.dart';
import 'package:yellow_rose/core/app_config.dart';
import 'package:yellow_rose/dependncy_injection.dart';
import 'package:yellow_rose/features/hotel/data/models/places/places.dart';

abstract class PlaceDataSource {
  Future<PlacesAutocompleteResponse> getPlaceSuggestions(String query);
  Future<PlaceEntity?> getPlaceDetails(String placeId);
}

class PlaceDataSourceImpl implements PlaceDataSource {
  final GoogleMapsPlaces _places = getIt<GoogleMapsPlaces>();

  @override
  Future<PlacesAutocompleteResponse> getPlaceSuggestions(String query) async {
    final response = await _places.autocomplete(query);

    if (response.isOkay) {
      return response;
    } else {
      throw Exception(response.errorMessage ?? 'Error fetching suggestions');
    }
  }

  @override
  Future<PlaceEntity?> getPlaceDetails(String placeId) async {
    final detailResponse = await _places.getDetailsByPlaceId(placeId);

    if (!detailResponse.isOkay) {
      return null;
    }

    final result = detailResponse.result;
    final location = result.geometry?.location;
    final formattedAddress = result.formattedAddress;

    String? city, state, county, country, countryCode;

    for (var c in result.addressComponents) {
      if (c.types.contains('locality')) city = c.longName;
      if (c.types.contains('administrative_area_level_1')) state = c.longName;
      if (c.types.contains('administrative_area_level_2')) county = c.longName;
      if (c.types.contains('country')) country = c.longName;
      if (c.types.contains('country')) countryCode = c.shortName;
    }

    return PlaceEntity(
        placeId: placeId,
        address: formattedAddress,
        latitude: location?.lat ?? 0,
        longitude: location?.lng ?? 0,
        city: city ?? state,
        state: state,
        county: county,
        country: country,
        countryCode: countryCode);
  }
}
