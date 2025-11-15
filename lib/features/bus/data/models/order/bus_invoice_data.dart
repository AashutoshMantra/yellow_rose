import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:yellow_rose/features/bus/data/models/order/bus_invoice_itinerary.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order/customer_payment.dart';

class BusInvoiceData {
  final String? clientName;
  final String? orderId;
  final String? status;
  final String? bookingId;
  final String? gstNumber;
  final String? gstName;
  final String? gstEmail;
  final String? contactNumber;
  final String? email;
  final String? modeOfPayment;
  final CustomerPayment? priceData;
  final CustomerPayment? customerPayment;
  final String? creationTime;
  final String? bookedBy;
  final String? specialRequest;
  final bool? showTicketPricing;
  final List<Map<String, Object>>? policies;
  final List<BusInvoiceItinerary>? invoiceItinerariesListBus;
  BusInvoiceData({
    this.clientName,
    this.orderId,
    this.status,
    this.bookingId,
    this.gstNumber,
    this.gstName,
    this.gstEmail,
    this.contactNumber,
    this.email,
    this.modeOfPayment,
    this.priceData,
    this.customerPayment,
    this.creationTime,
    this.bookedBy,
    this.specialRequest,
    this.showTicketPricing,
    this.policies,
    this.invoiceItinerariesListBus,
  });

  BusInvoiceData copyWith({
    String? clientName,
    String? orderId,
    String? status,
    String? bookingId,
    String? gstNumber,
    String? gstName,
    String? gstEmail,
    String? contactNumber,
    String? email,
    String? modeOfPayment,
    CustomerPayment? priceData,
    CustomerPayment? customerPayment,
    String? creationTime,
    String? bookedBy,
    String? specialRequest,
    bool? showTicketPricing,
    List<Map<String, Object>>? policies,
    List<BusInvoiceItinerary>? invoiceItinerariesListBus,
  }) {
    return BusInvoiceData(
      clientName: clientName ?? this.clientName,
      orderId: orderId ?? this.orderId,
      status: status ?? this.status,
      bookingId: bookingId ?? this.bookingId,
      gstNumber: gstNumber ?? this.gstNumber,
      gstName: gstName ?? this.gstName,
      gstEmail: gstEmail ?? this.gstEmail,
      contactNumber: contactNumber ?? this.contactNumber,
      email: email ?? this.email,
      modeOfPayment: modeOfPayment ?? this.modeOfPayment,
      priceData: priceData ?? this.priceData,
      customerPayment: customerPayment ?? this.customerPayment,
      creationTime: creationTime ?? this.creationTime,
      bookedBy: bookedBy ?? this.bookedBy,
      specialRequest: specialRequest ?? this.specialRequest,
      showTicketPricing: showTicketPricing ?? this.showTicketPricing,
      policies: policies ?? this.policies,
      invoiceItinerariesListBus: invoiceItinerariesListBus ?? this.invoiceItinerariesListBus,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(clientName != null){
      result.addAll({'clientName': clientName});
    }
    if(orderId != null){
      result.addAll({'orderId': orderId});
    }
    if(status != null){
      result.addAll({'status': status});
    }
    if(bookingId != null){
      result.addAll({'bookingId': bookingId});
    }
    if(gstNumber != null){
      result.addAll({'gstNumber': gstNumber});
    }
    if(gstName != null){
      result.addAll({'gstName': gstName});
    }
    if(gstEmail != null){
      result.addAll({'gstEmail': gstEmail});
    }
    if(contactNumber != null){
      result.addAll({'contactNumber': contactNumber});
    }
    if(email != null){
      result.addAll({'email': email});
    }
    if(modeOfPayment != null){
      result.addAll({'modeOfPayment': modeOfPayment});
    }
    if(priceData != null){
      result.addAll({'priceData': priceData!.toMap()});
    }
    if(customerPayment != null){
      result.addAll({'customerPayment': customerPayment!.toMap()});
    }
    if(creationTime != null){
      result.addAll({'creationTime': creationTime});
    }
    if(bookedBy != null){
      result.addAll({'bookedBy': bookedBy});
    }
    if(specialRequest != null){
      result.addAll({'specialRequest': specialRequest});
    }
    if(showTicketPricing != null){
      result.addAll({'showTicketPricing': showTicketPricing});
    }
    if(policies != null){
      result.addAll({'policies': policies});
    }
    if(invoiceItinerariesListBus != null){
      result.addAll({'invoiceItinerariesListBus': invoiceItinerariesListBus!.map((x) => x?.toMap()).toList()});
    }
  
    return result;
  }

  factory BusInvoiceData.fromMap(Map<String, dynamic> map) {
    return BusInvoiceData(
      clientName: map['clientName'],
      orderId: map['orderId'],
      status: map['status'],
      bookingId: map['bookingId'],
      gstNumber: map['gstNumber'],
      gstName: map['gstName'],
      gstEmail: map['gstEmail'],
      contactNumber: map['contactNumber'],
      email: map['email'],
      modeOfPayment: map['modeOfPayment'],
      priceData: map['priceData'] != null ? CustomerPayment.fromMap(map['priceData']) : null,
      customerPayment: map['customerPayment'] != null ? CustomerPayment.fromMap(map['customerPayment']) : null,
      creationTime: map['creationTime'],
      bookedBy: map['bookedBy'],
      specialRequest: map['specialRequest'],
      showTicketPricing: map['showTicketPricing'],
      policies: map['policies'] != null ? List<Map<String, Object>>.from((map['policies'] as List).map((x) => Map<String, Object>.from(x))) : null,
      invoiceItinerariesListBus: map['invoiceItinerariesListBus'] != null ? List<BusInvoiceItinerary>.from(map['invoiceItinerariesListBus']?.map((x) => BusInvoiceItinerary.fromMap(x))) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BusInvoiceData.fromJson(String source) => BusInvoiceData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BusInvoiceData(clientName: $clientName, orderId: $orderId, status: $status, bookingId: $bookingId, gstNumber: $gstNumber, gstName: $gstName, gstEmail: $gstEmail, contactNumber: $contactNumber, email: $email, modeOfPayment: $modeOfPayment, priceData: $priceData, customerPayment: $customerPayment, creationTime: $creationTime, bookedBy: $bookedBy, specialRequest: $specialRequest, showTicketPricing: $showTicketPricing, policies: $policies, invoiceItinerariesListBus: $invoiceItinerariesListBus)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is BusInvoiceData &&
      other.clientName == clientName &&
      other.orderId == orderId &&
      other.status == status &&
      other.bookingId == bookingId &&
      other.gstNumber == gstNumber &&
      other.gstName == gstName &&
      other.gstEmail == gstEmail &&
      other.contactNumber == contactNumber &&
      other.email == email &&
      other.modeOfPayment == modeOfPayment &&
      other.priceData == priceData &&
      other.customerPayment == customerPayment &&
      other.creationTime == creationTime &&
      other.bookedBy == bookedBy &&
      other.specialRequest == specialRequest &&
      other.showTicketPricing == showTicketPricing &&
      listEquals(other.policies, policies) &&
      listEquals(other.invoiceItinerariesListBus, invoiceItinerariesListBus);
  }

  @override
  int get hashCode {
    return clientName.hashCode ^
      orderId.hashCode ^
      status.hashCode ^
      bookingId.hashCode ^
      gstNumber.hashCode ^
      gstName.hashCode ^
      gstEmail.hashCode ^
      contactNumber.hashCode ^
      email.hashCode ^
      modeOfPayment.hashCode ^
      priceData.hashCode ^
      customerPayment.hashCode ^
      creationTime.hashCode ^
      bookedBy.hashCode ^
      specialRequest.hashCode ^
      showTicketPricing.hashCode ^
      policies.hashCode ^
      invoiceItinerariesListBus.hashCode;
  }
}
