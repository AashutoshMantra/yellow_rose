import 'package:hive_flutter/hive_flutter.dart';
import 'package:yellow_rose/features/bus/data/models/search/bus_city_response.dart';

abstract interface class BusLocalService {
  Future<List<BusCityResponse>> getBusCities();
  Future<void> cacheBusCities(List<Map<String, dynamic>> cities);
}

class BusLocalServiceImpl implements BusLocalService {
  final Box busCityBox = Hive.box('bus_cities');

  @override
  Future<List<BusCityResponse>> getBusCities() async {
    return (busCityBox.get('bus_city_list', defaultValue: []) as List)
        .cast<Map<dynamic, dynamic>>()
        .map(BusCityResponse.fromMap)
        .toList();
  }

  @override
  Future<void> cacheBusCities(List<Map<String, dynamic>> cities) async {
    await busCityBox.put('bus_city_list', cities);
  }
}
