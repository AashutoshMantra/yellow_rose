import 'dart:convert';

import 'package:yellow_rose/features/bus/data/models/bus_error_responsed.dart';
import 'package:yellow_rose/features/bus/data/models/order/bus_print_ticket_response.dart';

class BusOrderBookResponse {
  final String? orderId;
  final String? ticketNumber;
  final BusPrintTicketResponse? printTicketResponse;
  final BusErrorResponse? error;
  BusOrderBookResponse({
    this.orderId,
    this.ticketNumber,
    this.printTicketResponse,
    this.error,
  });

  BusOrderBookResponse copyWith({
    String? orderId,
    String? ticketNumber,
    BusPrintTicketResponse? printTicketResponse,
    BusErrorResponse? error,
  }) {
    return BusOrderBookResponse(
      orderId: orderId ?? this.orderId,
      ticketNumber: ticketNumber ?? this.ticketNumber,
      printTicketResponse: printTicketResponse ?? this.printTicketResponse,
      error: error ?? this.error,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (orderId != null) {
      result.addAll({'orderId': orderId});
    }
    if (ticketNumber != null) {
      result.addAll({'ticketNumber': ticketNumber});
    }
    if (printTicketResponse != null) {
      result.addAll({'printTicketResponse': printTicketResponse!.toMap()});
    }
    if (error != null) {
      result.addAll({'error': error!.toMap()});
    }

    return result;
  }

  factory BusOrderBookResponse.fromMap(Map<String, dynamic> map) {
    return BusOrderBookResponse(
      orderId: map['orderId'],
      ticketNumber: map['ticketNumber'],
      printTicketResponse: map['printTicketResponse'] != null
          ? BusPrintTicketResponse.fromMap(map['printTicketResponse'])
          : null,
      error:
          map['error'] != null ? BusErrorResponse.fromMap(map['error']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BusOrderBookResponse.fromJson(String source) =>
      BusOrderBookResponse.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BusOrderBookResponse(orderId: $orderId, ticketNumber: $ticketNumber, printTicketResponse: $printTicketResponse, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BusOrderBookResponse &&
        other.orderId == orderId &&
        other.ticketNumber == ticketNumber &&
        other.printTicketResponse == printTicketResponse &&
        other.error == error;
  }

  @override
  int get hashCode {
    return orderId.hashCode ^
        ticketNumber.hashCode ^
        printTicketResponse.hashCode ^
        error.hashCode;
  }
}
