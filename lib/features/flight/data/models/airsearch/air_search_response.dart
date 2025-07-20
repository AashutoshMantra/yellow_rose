import 'dart:convert';

import 'package:yellow_rose/features/flight/data/models/airsearch/air_response_data.dart';
import 'package:yellow_rose/features/flight/data/models/airsearch/route_request.dart';

class AirSearchResponse {
  final String fromAirport;
   final String toAirport;
   final String? source;
   final RouteRequest? routeRequest;
  final List<AirResponseData> flights;
  
  AirSearchResponse( {
    required this.fromAirport,required this.toAirport, this.source, this.routeRequest,
   List<AirResponseData>?  flights,
  }):flights=flights??[];

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'fromAirport': fromAirport});
    result.addAll({'toAirport': toAirport});
    if(source != null){
      result.addAll({'source': source});
    }
    if(routeRequest != null){
      result.addAll({'routeRequest': routeRequest!.toMap()});
    }
    result.addAll({'flights': flights.map((x) => x.toMap()).toList()});
  
    return result;
  }

  factory AirSearchResponse.fromMap(Map<String, dynamic> map) {
    return AirSearchResponse(
      fromAirport:map['fromAirport'] ?? '',
     toAirport: map['toAirport'] ?? '',
    source:  map['source'],
    routeRequest:  map['routeRequest'] != null ? RouteRequest.fromMap(map['routeRequest']) : null,
     flights: List<AirResponseData>.from(map['flights']?.map((x) => AirResponseData.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory AirSearchResponse.fromJson(String source) => AirSearchResponse.fromMap(json.decode(source));
}
