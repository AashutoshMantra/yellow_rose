import 'dart:convert';

import 'package:yellow_rose/core/constants/supported_service.dart';
import 'package:yellow_rose/core/utils/shared_pref_repository.dart';
import 'package:yellow_rose/features/bus/domain/entities/bus_search.dart';
import 'package:yellow_rose/features/flight/domain/entities/flight_recent_search.dart';
import 'package:yellow_rose/features/hotel/domain/entities/hotel_search.dart';

abstract class RecentSearchLocalService {
  Future<List<T>> getRecentSearches<T>(SupportedService service);
  Future saveRecentSearches<T>(SupportedService service, List<T> data);
}

class RecentSearchLocalServiceImpl implements RecentSearchLocalService {
  @override
  Future<List<T>> getRecentSearches<T>(SupportedService service) async {
    var recentSearches =
        SharedPreferencesRepository.getString("${service.name}_recent");
    if (recentSearches.isEmpty) {
      return List<T>.empty();
    }
    var recentSearchList = (jsonDecode(recentSearches)) as List<dynamic>;
    var response = List<T>.empty(growable: true);
    for (var recentSearch in recentSearchList) {
      if (T == AirSearch) {
        var decodedData = jsonDecode(recentSearch) as Map<String, dynamic>;
        response.add(AirSearch.fromMap(decodedData) as T);
      } else if (T == HotelSearch) {
        var decodedData = jsonDecode(recentSearch) as Map<String, dynamic>;
        response.add(HotelSearch.fromMap(decodedData) as T);
      } else if (T == BusSearch) {
        var decodedData = jsonDecode(recentSearch) as Map<String, dynamic>;
        response.add(BusSearch.fromMap(decodedData) as T);
      }
    }
    return response;
  }

  @override
  Future saveRecentSearches<T>(SupportedService service, List<T> data) async {
    var encodedData = jsonEncode(data);
    var key = "${service.name}_recent";
    SharedPreferencesRepository.putString(key, encodedData);
  }
}
