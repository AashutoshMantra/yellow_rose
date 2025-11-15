import 'package:yellow_rose/features/bus/data/models/search/bus_search_request.dart';
import 'package:yellow_rose/features/bus/domain/entities/bus_search.dart';

class BusMapperUtility {
  BusMapperUtility._();

  static BusSearchRequest mapBusSearchToBusSearchRequest(BusSearch busSearch) {
    if (busSearch.source == null ||
        busSearch.destination == null ||
        busSearch.dateOfJourney == null) {
      throw Exception("Bus search source, destination and date are required");
    }

    return BusSearchRequest(
      requestId: busSearch.requestId,
      source: busSearch.source!.cityLabel ?? '',
      sourceId: busSearch.source!.id,
      destination: busSearch.destination!.cityLabel ?? '',
      destinationId: busSearch.destination!.id,
      dateOfJourney: busSearch.dateOfJourney!,
    );
  }
}
