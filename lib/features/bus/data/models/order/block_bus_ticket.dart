import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:yellow_rose/features/bus/data/models/order/bus_inventory_item.dart';

class BusBlockTicketRequest {
  final String? availableTripId;
  final int? boardingPointId;
  final int? droppingPointId;
  final int? destination;
  final int? source;
  final List<BusInventoryItem>? inventoryItems;
  final String? callFareBreakUpAPI;
  final String? requestId;
  BusBlockTicketRequest({
    this.availableTripId,
    this.boardingPointId,
    this.droppingPointId,
    this.destination,
    this.source,
    this.inventoryItems,
    this.callFareBreakUpAPI,
    this.requestId,
  });

  BusBlockTicketRequest copyWith({
    String? availableTripId,
    int? boardingPointId,
    int? droppingPointId,
    int? destination,
    int? source,
    List<BusInventoryItem>? inventoryItems,
    String? callFareBreakUpAPI,
    String? requestId,
  }) {
    return BusBlockTicketRequest(
      availableTripId: availableTripId ?? this.availableTripId,
      boardingPointId: boardingPointId ?? this.boardingPointId,
      droppingPointId: droppingPointId ?? this.droppingPointId,
      destination: destination ?? this.destination,
      source: source ?? this.source,
      inventoryItems: inventoryItems ?? this.inventoryItems,
      callFareBreakUpAPI: callFareBreakUpAPI ?? this.callFareBreakUpAPI,
      requestId: requestId ?? this.requestId,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (availableTripId != null) {
      result.addAll({'availableTripId': availableTripId});
    }
    if (boardingPointId != null) {
      result.addAll({'boardingPointId': boardingPointId});
    }
    if (droppingPointId != null) {
      result.addAll({'droppingPointId': droppingPointId});
    }
    if (destination != null) {
      result.addAll({'destination': destination});
    }
    if (source != null) {
      result.addAll({'source': source});
    }
    if (inventoryItems != null) {
      result.addAll(
          {'inventoryItems': inventoryItems!.map((x) => x.toMap()).toList()});
    }
    if (callFareBreakUpAPI != null) {
      result.addAll({'callFareBreakUpAPI': callFareBreakUpAPI});
    }
    if (requestId != null) {
      result.addAll({'requestId': requestId});
    }

    return result;
  }

  factory BusBlockTicketRequest.fromMap(Map<String, dynamic> map) {
    return BusBlockTicketRequest(
      availableTripId: map['availableTripId'],
      boardingPointId: map['boardingPointId']?.toInt(),
      droppingPointId: map['droppingPointId']?.toInt(),
      destination: map['destination']?.toInt(),
      source: map['source']?.toInt(),
      inventoryItems: map['inventoryItems'] != null
          ? List<BusInventoryItem>.from(
              map['inventoryItems']?.map((x) => BusInventoryItem.fromMap(x)))
          : null,
      callFareBreakUpAPI: map['callFareBreakUpAPI'],
      requestId: map['requestId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BusBlockTicketRequest.fromJson(String source) =>
      BusBlockTicketRequest.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BlockTicketRequest(availableTripId: $availableTripId, boardingPointId: $boardingPointId, droppingPointId: $droppingPointId, destination: $destination, source: $source, inventoryItems: $inventoryItems, callFareBreakUpAPI: $callFareBreakUpAPI, requestId: $requestId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BusBlockTicketRequest &&
        other.availableTripId == availableTripId &&
        other.boardingPointId == boardingPointId &&
        other.droppingPointId == droppingPointId &&
        other.destination == destination &&
        other.source == source &&
        listEquals(other.inventoryItems, inventoryItems) &&
        other.callFareBreakUpAPI == callFareBreakUpAPI &&
        other.requestId == requestId;
  }

  @override
  int get hashCode {
    return availableTripId.hashCode ^
        boardingPointId.hashCode ^
        droppingPointId.hashCode ^
        destination.hashCode ^
        source.hashCode ^
        inventoryItems.hashCode ^
        callFareBreakUpAPI.hashCode ^
        requestId.hashCode;
  }
}
