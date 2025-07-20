import 'dart:convert';

import 'package:yellow_rose/features/flight/data/models/airsearch/route_request.dart';

class BaseAirSearchResponse {
   final String fromAirport;
   final String toAirport;
   final String? source;
   final RouteRequest? routeRequest;
  BaseAirSearchResponse({
    required this.fromAirport,
    required this.toAirport,
    this.source,
    this.routeRequest,
  });

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
  
    return result;
  }

  factory BaseAirSearchResponse.fromMap(Map<String, dynamic> map) {
    return BaseAirSearchResponse(
      fromAirport: map['fromAirport'] ?? '',
      toAirport: map['toAirport'] ?? '',
      source: map['source'],
      routeRequest: map['routeRequest'] != null ? RouteRequest.fromMap(map['routeRequest']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BaseAirSearchResponse.fromJson(String source) => BaseAirSearchResponse.fromMap(json.decode(source));
}
