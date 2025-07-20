import 'dart:convert';

import 'package:yellow_rose/features/flight/data/models/erro_code_handler.dart';

class OrderErrorHandler {

    final ErrorCodeHandler? errorData;

     final DateTime? requestedDate;
    final String? travelType;
    final String? requestedClass;
    final String? fromAirport;
    final String? toAirport;
  OrderErrorHandler({
    this.errorData,
    this.requestedDate,
    this.travelType,
    this.requestedClass,
    this.fromAirport,
    this.toAirport,
  });


  OrderErrorHandler copyWith({
    ErrorCodeHandler? errorData,
    DateTime? requestedDate,
    String? travelType,
    String? requestedClass,
    String? fromAirport,
    String? toAirport,
  }) {
    return OrderErrorHandler(
      errorData: errorData ?? this.errorData,
      requestedDate: requestedDate ?? this.requestedDate,
      travelType: travelType ?? this.travelType,
      requestedClass: requestedClass ?? this.requestedClass,
      fromAirport: fromAirport ?? this.fromAirport,
      toAirport: toAirport ?? this.toAirport,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(errorData != null){
      result.addAll({'errorData': errorData!.toMap()});
    }
    if(requestedDate != null){
      result.addAll({'requestedDate': requestedDate!.millisecondsSinceEpoch});
    }
    if(travelType != null){
      result.addAll({'travelType': travelType});
    }
    if(requestedClass != null){
      result.addAll({'requestedClass': requestedClass});
    }
    if(fromAirport != null){
      result.addAll({'fromAirport': fromAirport});
    }
    if(toAirport != null){
      result.addAll({'toAirport': toAirport});
    }
  
    return result;
  }

  factory OrderErrorHandler.fromMap(Map<String, dynamic> map) {
    return OrderErrorHandler(
      errorData: map['errorData'] != null ? ErrorCodeHandler.fromMap(map['errorData']) : null,
      requestedDate: map['requestedDate'] != null ? DateTime.tryParse(map['requestedDate']) : null,
      travelType: map['travelType'],
      requestedClass: map['requestedClass'],
      fromAirport: map['fromAirport'],
      toAirport: map['toAirport'],
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderErrorHandler.fromJson(String source) => OrderErrorHandler.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OrderErrorHandler(errorData: $errorData, requestedDate: $requestedDate, travelType: $travelType, requestedClass: $requestedClass, fromAirport: $fromAirport, toAirport: $toAirport)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is OrderErrorHandler &&
      other.errorData == errorData &&
      other.requestedDate == requestedDate &&
      other.travelType == travelType &&
      other.requestedClass == requestedClass &&
      other.fromAirport == fromAirport &&
      other.toAirport == toAirport;
  }

  @override
  int get hashCode {
    return errorData.hashCode ^
      requestedDate.hashCode ^
      travelType.hashCode ^
      requestedClass.hashCode ^
      fromAirport.hashCode ^
      toAirport.hashCode;
  }
}
