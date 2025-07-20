import 'package:hive_flutter/hive_flutter.dart';
import 'package:yellow_rose/features/flight/data/models/airports.dart';

abstract interface class AirLocalService{
  Future<List<Airport>> getAirports();
   Future<void> cacheAirports(List<Map<String, dynamic>> airports);
}

class AirLocalServiceImpl implements AirLocalService{
   final Box airportBox = Hive.box('airports');
   
  @override
  Future<List<Airport>> getAirports() async{
    return (airportBox.get('airport_list', defaultValue: []) as List)
        .cast<Map<dynamic, dynamic>>().map(Airport.fromMap).toList();
  }
  @override
  Future<void> cacheAirports(List<Map<String, dynamic>> airports) async {
    await airportBox.put('airport_list', airports);
  }

}