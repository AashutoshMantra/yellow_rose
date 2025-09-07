import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:yellow_rose/features/flight/data/models/booking/order/order_passenger_details.dart';

class OrderCancelRequest {
  final String? createdBy;
  final String? orderId;
  final String? itineraryId;
  final String? itinerary;
  final String? bookingId;
  final String? cancellationMode;
  // final String? cancellationType= OrderCancellationTypeEnum.AUTO.getCode();
  final String? travelRoute;
  final String? intlTravelRoute;
  final bool? preview;
  final String? pnr;
  // final PnrNumbers pnrNumbers;
  final String? amdSource = "A";
  final String? comment;
  final List<OrdersPassengersDetails?>? passengerDetails;
  OrderCancelRequest({
    this.createdBy,
    this.orderId,
    this.itineraryId,
    this.itinerary,
    this.bookingId,
    this.cancellationMode,
    this.travelRoute,
    this.intlTravelRoute,
    this.preview,
    this.pnr,
    this.comment,
    this.passengerDetails,
  });

  OrderCancelRequest copyWith({
    String? createdBy,
    String? orderId,
    String? itineraryId,
    String? itinerary,
    String? bookingId,
    String? cancellationMode,
    String? travelRoute,
    String? intlTravelRoute,
    bool? preview,
    String? pnr,
    String? comment,
    List<OrdersPassengersDetails?>? passengerDetails,
  }) {
    return OrderCancelRequest(
      createdBy: createdBy ?? this.createdBy,
      orderId: orderId ?? this.orderId,
      itineraryId: itineraryId ?? this.itineraryId,
      itinerary: itinerary ?? this.itinerary,
      bookingId: bookingId ?? this.bookingId,
      cancellationMode: cancellationMode ?? this.cancellationMode,
      travelRoute: travelRoute ?? this.travelRoute,
      intlTravelRoute: intlTravelRoute ?? this.intlTravelRoute,
      preview: preview ?? this.preview,
      pnr: pnr ?? this.pnr,
      comment: comment ?? this.comment,
      passengerDetails: passengerDetails ?? this.passengerDetails,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(createdBy != null){
      result.addAll({'createdBy': createdBy});
    }
    if(orderId != null){
      result.addAll({'orderId': orderId});
    }
    if(itineraryId != null){
      result.addAll({'itineraryId': itineraryId});
    }
    if(itinerary != null){
      result.addAll({'itinerary': itinerary});
    }
    if(bookingId != null){
      result.addAll({'bookingId': bookingId});
    }
    if(cancellationMode != null){
      result.addAll({'cancellationMode': cancellationMode});
    }
    if(travelRoute != null){
      result.addAll({'travelRoute': travelRoute});
    }
    if(intlTravelRoute != null){
      result.addAll({'intlTravelRoute': intlTravelRoute});
    }
    if(preview != null){
      result.addAll({'preview': preview});
    }
    if(pnr != null){
      result.addAll({'pnr': pnr});
    }
    if(comment != null){
      result.addAll({'comment': comment});
    }
    if(passengerDetails != null){
      result.addAll({'passengerDetails': passengerDetails!.map((x) => x?.toMap()).toList()});
    }
  
    return result;
  }

  factory OrderCancelRequest.fromMap(Map<String, dynamic> map) {
    return OrderCancelRequest(
      createdBy: map['createdBy'],
      orderId: map['orderId'],
      itineraryId: map['itineraryId'],
      itinerary: map['itinerary'],
      bookingId: map['bookingId'],
      cancellationMode: map['cancellationMode'],
      travelRoute: map['travelRoute'],
      intlTravelRoute: map['intlTravelRoute'],
      preview: map['preview'],
      pnr: map['pnr'],
      comment: map['comment'],
      passengerDetails: map['passengerDetails'] != null ? List<OrdersPassengersDetails?>.from(map['passengerDetails']?.map((x) => OrdersPassengersDetails?.fromMap(x))) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderCancelRequest.fromJson(String source) => OrderCancelRequest.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OrderCancelRequest(createdBy: $createdBy, orderId: $orderId, itineraryId: $itineraryId, itinerary: $itinerary, bookingId: $bookingId, cancellationMode: $cancellationMode, travelRoute: $travelRoute, intlTravelRoute: $intlTravelRoute, preview: $preview, pnr: $pnr, comment: $comment, passengerDetails: $passengerDetails)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is OrderCancelRequest &&
      other.createdBy == createdBy &&
      other.orderId == orderId &&
      other.itineraryId == itineraryId &&
      other.itinerary == itinerary &&
      other.bookingId == bookingId &&
      other.cancellationMode == cancellationMode &&
      other.travelRoute == travelRoute &&
      other.intlTravelRoute == intlTravelRoute &&
      other.preview == preview &&
      other.pnr == pnr &&
      other.comment == comment &&
      listEquals(other.passengerDetails, passengerDetails);
  }

  @override
  int get hashCode {
    return createdBy.hashCode ^
      orderId.hashCode ^
      itineraryId.hashCode ^
      itinerary.hashCode ^
      bookingId.hashCode ^
      cancellationMode.hashCode ^
      travelRoute.hashCode ^
      intlTravelRoute.hashCode ^
      preview.hashCode ^
      pnr.hashCode ^
      comment.hashCode ^
      passengerDetails.hashCode;
  }
}
