import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:yellow_rose/features/bus/data/models/order/bus_inventory_item.dart';
import 'package:yellow_rose/features/bus/data/models/order/bus_udpated_fare_response.dart';

class BusBlockTicketResponse {
  String? blockKey;
  String? status;
  int? validity;
  List<BusInventoryItem> inventoryItems;
  BusUpdatedFareRes? updateFareForSpecialOperator;
  String? error;
  BusBlockTicketResponse({
    this.blockKey,
    this.status,
    this.validity,
    required this.inventoryItems,
    this.updateFareForSpecialOperator,
    this.error,
  });

  BusBlockTicketResponse copyWith({
    String? blockKey,
    String? status,
    int? validity,
    List<BusInventoryItem>? inventoryItems,
    BusUpdatedFareRes? updateFareForSpecialOperator,
    String? error,
  }) {
    return BusBlockTicketResponse(
      blockKey: blockKey ?? this.blockKey,
      status: status ?? this.status,
      validity: validity ?? this.validity,
      inventoryItems: inventoryItems ?? this.inventoryItems,
      updateFareForSpecialOperator:
          updateFareForSpecialOperator ?? this.updateFareForSpecialOperator,
      error: error ?? this.error,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (blockKey != null) {
      result.addAll({'blockKey': blockKey});
    }
    if (status != null) {
      result.addAll({'status': status});
    }
    if (validity != null) {
      result.addAll({'validity': validity});
    }
    result.addAll(
        {'inventoryItems': inventoryItems.map((x) => x.toMap()).toList()});
    if (updateFareForSpecialOperator != null) {
      result.addAll({
        'updateFareForSpecialOperator': updateFareForSpecialOperator!.toMap()
      });
    }
    if (error != null) {
      result.addAll({'error': error});
    }

    return result;
  }

  factory BusBlockTicketResponse.fromMap(Map<String, dynamic> map) {
    return BusBlockTicketResponse(
      blockKey: map['blockKey'],
      status: map['status'],
      validity: map['validity']?.toInt(),
      inventoryItems: map['inventoryItems'] != null
          ? List<BusInventoryItem>.from(
              map['inventoryItems']?.map((x) => BusInventoryItem.fromMap(x)))
          : [],
      updateFareForSpecialOperator: map['updateFareForSpecialOperator'] != null
          ? BusUpdatedFareRes.fromMap(map['updateFareForSpecialOperator'])
          : null,
      error: map['error'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BusBlockTicketResponse.fromJson(String source) =>
      BusBlockTicketResponse.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BusBlockTicketRequest(blockKey: $blockKey, status: $status, validity: $validity, inventoryItems: $inventoryItems, updateFareForSpecialOperator: $updateFareForSpecialOperator, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BusBlockTicketResponse &&
        other.blockKey == blockKey &&
        other.status == status &&
        other.validity == validity &&
        listEquals(other.inventoryItems, inventoryItems) &&
        other.updateFareForSpecialOperator == updateFareForSpecialOperator &&
        other.error == error;
  }

  @override
  int get hashCode {
    return blockKey.hashCode ^
        status.hashCode ^
        validity.hashCode ^
        inventoryItems.hashCode ^
        updateFareForSpecialOperator.hashCode ^
        error.hashCode;
  }
}
