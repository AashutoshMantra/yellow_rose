import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:yellow_rose/features/bus/data/models/bus_order_passenger_detail.dart';
import 'package:yellow_rose/features/bus/data/models/search/bus_operator_detail.dart';

class BusInvoiceItinerary {
  final String? busName;
  final String? droppingPoint;
  final String? dropTime;
  final String? doj;
  final String? fare;
  final String? boardingDate;
  final String? droppingDate;
  final String? seatNumber;
  final String? contactNumber;
  final String? boardingPoint;
  final String? boardingTime;
  final String? droppingTime;
  final String? busType;
  final String? duration;
  final String? busNumber;
  final String? pickUpTime;
  final String? pickUpPoint;
  final String? totalSeats;
  final String? passengerName;
  final String? source;
  final String? destination;
  final BusOperatorDetail? operatorDetails;
  final String? age;
  final String? departureDate;
  final bool? sleeper;
  final bool? seater;
  final String? address;
  final String? city;
  final String? country;
  final String? itineraryBookingId;
  final String? fareType;
  final String? fareBasis;
  final String? dealCode;
  final String? tourCode;
  final String? status;
  final List<BusOrderPassengerDetails>? passengerDetails;
  BusInvoiceItinerary({
    this.busName,
    this.droppingPoint,
    this.dropTime,
    this.doj,
    this.fare,
    this.boardingDate,
    this.droppingDate,
    this.seatNumber,
    this.contactNumber,
    this.boardingPoint,
    this.boardingTime,
    this.droppingTime,
    this.busType,
    this.duration,
    this.busNumber,
    this.pickUpTime,
    this.pickUpPoint,
    this.totalSeats,
    this.passengerName,
    this.source,
    this.destination,
    this.operatorDetails,
    this.age,
    this.departureDate,
    this.sleeper,
    this.seater,
    this.address,
    this.city,
    this.country,
    this.itineraryBookingId,
    this.fareType,
    this.fareBasis,
    this.dealCode,
    this.tourCode,
    this.status,
    this.passengerDetails,
  });

  BusInvoiceItinerary copyWith({
    String? busName,
    String? droppingPoint,
    String? dropTime,
    String? doj,
    String? fare,
    String? boardingDate,
    String? droppingDate,
    String? seatNumber,
    String? contactNumber,
    String? boardingPoint,
    String? boardingTime,
    String? droppingTime,
    String? busType,
    String? duration,
    String? busNumber,
    String? pickUpTime,
    String? pickUpPoint,
    String? totalSeats,
    String? passengerName,
    String? source,
    String? destination,
    BusOperatorDetail? operatorDetails,
    String? age,
    String? departureDate,
    bool? sleeper,
    bool? seater,
    String? address,
    String? city,
    String? country,
    String? itineraryBookingId,
    String? fareType,
    String? fareBasis,
    String? dealCode,
    String? tourCode,
    String? status,
    List<BusOrderPassengerDetails>? passengerDetails,
  }) {
    return BusInvoiceItinerary(
      busName: busName ?? this.busName,
      droppingPoint: droppingPoint ?? this.droppingPoint,
      dropTime: dropTime ?? this.dropTime,
      doj: doj ?? this.doj,
      fare: fare ?? this.fare,
      boardingDate: boardingDate ?? this.boardingDate,
      droppingDate: droppingDate ?? this.droppingDate,
      seatNumber: seatNumber ?? this.seatNumber,
      contactNumber: contactNumber ?? this.contactNumber,
      boardingPoint: boardingPoint ?? this.boardingPoint,
      boardingTime: boardingTime ?? this.boardingTime,
      droppingTime: droppingTime ?? this.droppingTime,
      busType: busType ?? this.busType,
      duration: duration ?? this.duration,
      busNumber: busNumber ?? this.busNumber,
      pickUpTime: pickUpTime ?? this.pickUpTime,
      pickUpPoint: pickUpPoint ?? this.pickUpPoint,
      totalSeats: totalSeats ?? this.totalSeats,
      passengerName: passengerName ?? this.passengerName,
      source: source ?? this.source,
      destination: destination ?? this.destination,
      operatorDetails: operatorDetails ?? this.operatorDetails,
      age: age ?? this.age,
      departureDate: departureDate ?? this.departureDate,
      sleeper: sleeper ?? this.sleeper,
      seater: seater ?? this.seater,
      address: address ?? this.address,
      city: city ?? this.city,
      country: country ?? this.country,
      itineraryBookingId: itineraryBookingId ?? this.itineraryBookingId,
      fareType: fareType ?? this.fareType,
      fareBasis: fareBasis ?? this.fareBasis,
      dealCode: dealCode ?? this.dealCode,
      tourCode: tourCode ?? this.tourCode,
      status: status ?? this.status,
      passengerDetails: passengerDetails ?? this.passengerDetails,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(busName != null){
      result.addAll({'busName': busName});
    }
    if(droppingPoint != null){
      result.addAll({'droppingPoint': droppingPoint});
    }
    if(dropTime != null){
      result.addAll({'dropTime': dropTime});
    }
    if(doj != null){
      result.addAll({'doj': doj});
    }
    if(fare != null){
      result.addAll({'fare': fare});
    }
    if(boardingDate != null){
      result.addAll({'boardingDate': boardingDate});
    }
    if(droppingDate != null){
      result.addAll({'droppingDate': droppingDate});
    }
    if(seatNumber != null){
      result.addAll({'seatNumber': seatNumber});
    }
    if(contactNumber != null){
      result.addAll({'contactNumber': contactNumber});
    }
    if(boardingPoint != null){
      result.addAll({'boardingPoint': boardingPoint});
    }
    if(boardingTime != null){
      result.addAll({'boardingTime': boardingTime});
    }
    if(droppingTime != null){
      result.addAll({'droppingTime': droppingTime});
    }
    if(busType != null){
      result.addAll({'busType': busType});
    }
    if(duration != null){
      result.addAll({'duration': duration});
    }
    if(busNumber != null){
      result.addAll({'busNumber': busNumber});
    }
    if(pickUpTime != null){
      result.addAll({'pickUpTime': pickUpTime});
    }
    if(pickUpPoint != null){
      result.addAll({'pickUpPoint': pickUpPoint});
    }
    if(totalSeats != null){
      result.addAll({'totalSeats': totalSeats});
    }
    if(passengerName != null){
      result.addAll({'passengerName': passengerName});
    }
    if(source != null){
      result.addAll({'source': source});
    }
    if(destination != null){
      result.addAll({'destination': destination});
    }
    if(operatorDetails != null){
      result.addAll({'operatorDetails': operatorDetails!.toMap()});
    }
    if(age != null){
      result.addAll({'age': age});
    }
    if(departureDate != null){
      result.addAll({'departureDate': departureDate});
    }
    if(sleeper != null){
      result.addAll({'sleeper': sleeper});
    }
    if(seater != null){
      result.addAll({'seater': seater});
    }
    if(address != null){
      result.addAll({'address': address});
    }
    if(city != null){
      result.addAll({'city': city});
    }
    if(country != null){
      result.addAll({'country': country});
    }
    if(itineraryBookingId != null){
      result.addAll({'itineraryBookingId': itineraryBookingId});
    }
    if(fareType != null){
      result.addAll({'fareType': fareType});
    }
    if(fareBasis != null){
      result.addAll({'fareBasis': fareBasis});
    }
    if(dealCode != null){
      result.addAll({'dealCode': dealCode});
    }
    if(tourCode != null){
      result.addAll({'tourCode': tourCode});
    }
    if(status != null){
      result.addAll({'status': status});
    }
    if(passengerDetails != null){
      result.addAll({'passengerDetails': passengerDetails!.map((x) => x?.toMap()).toList()});
    }
  
    return result;
  }

  factory BusInvoiceItinerary.fromMap(Map<String, dynamic> map) {
    return BusInvoiceItinerary(
      busName: map['busName'],
      droppingPoint: map['droppingPoint'],
      dropTime: map['dropTime'],
      doj: map['doj'],
      fare: map['fare'],
      boardingDate: map['boardingDate'],
      droppingDate: map['droppingDate'],
      seatNumber: map['seatNumber'],
      contactNumber: map['contactNumber'],
      boardingPoint: map['boardingPoint'],
      boardingTime: map['boardingTime'],
      droppingTime: map['droppingTime'],
      busType: map['busType'],
      duration: map['duration'],
      busNumber: map['busNumber'],
      pickUpTime: map['pickUpTime'],
      pickUpPoint: map['pickUpPoint'],
      totalSeats: map['totalSeats'],
      passengerName: map['passengerName'],
      source: map['source'],
      destination: map['destination'],
      operatorDetails: map['operatorDetails'] != null ? BusOperatorDetail.fromMap(map['operatorDetails']) : null,
      age: map['age'],
      departureDate: map['departureDate'],
      sleeper: map['sleeper'],
      seater: map['seater'],
      address: map['address'],
      city: map['city'],
      country: map['country'],
      itineraryBookingId: map['itineraryBookingId'],
      fareType: map['fareType'],
      fareBasis: map['fareBasis'],
      dealCode: map['dealCode'],
      tourCode: map['tourCode'],
      status: map['status'],
      passengerDetails: map['passengerDetails'] != null ? List<BusOrderPassengerDetails>.from(map['passengerDetails']?.map((x) => BusOrderPassengerDetails.fromMap(x))) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BusInvoiceItinerary.fromJson(String source) => BusInvoiceItinerary.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BusInvoiceItinerary(busName: $busName, droppingPoint: $droppingPoint, dropTime: $dropTime, doj: $doj, fare: $fare, boardingDate: $boardingDate, droppingDate: $droppingDate, seatNumber: $seatNumber, contactNumber: $contactNumber, boardingPoint: $boardingPoint, boardingTime: $boardingTime, droppingTime: $droppingTime, busType: $busType, duration: $duration, busNumber: $busNumber, pickUpTime: $pickUpTime, pickUpPoint: $pickUpPoint, totalSeats: $totalSeats, passengerName: $passengerName, source: $source, destination: $destination, operatorDetails: $operatorDetails, age: $age, departureDate: $departureDate, sleeper: $sleeper, seater: $seater, address: $address, city: $city, country: $country, itineraryBookingId: $itineraryBookingId, fareType: $fareType, fareBasis: $fareBasis, dealCode: $dealCode, tourCode: $tourCode, status: $status, passengerDetails: $passengerDetails)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is BusInvoiceItinerary &&
      other.busName == busName &&
      other.droppingPoint == droppingPoint &&
      other.dropTime == dropTime &&
      other.doj == doj &&
      other.fare == fare &&
      other.boardingDate == boardingDate &&
      other.droppingDate == droppingDate &&
      other.seatNumber == seatNumber &&
      other.contactNumber == contactNumber &&
      other.boardingPoint == boardingPoint &&
      other.boardingTime == boardingTime &&
      other.droppingTime == droppingTime &&
      other.busType == busType &&
      other.duration == duration &&
      other.busNumber == busNumber &&
      other.pickUpTime == pickUpTime &&
      other.pickUpPoint == pickUpPoint &&
      other.totalSeats == totalSeats &&
      other.passengerName == passengerName &&
      other.source == source &&
      other.destination == destination &&
      other.operatorDetails == operatorDetails &&
      other.age == age &&
      other.departureDate == departureDate &&
      other.sleeper == sleeper &&
      other.seater == seater &&
      other.address == address &&
      other.city == city &&
      other.country == country &&
      other.itineraryBookingId == itineraryBookingId &&
      other.fareType == fareType &&
      other.fareBasis == fareBasis &&
      other.dealCode == dealCode &&
      other.tourCode == tourCode &&
      other.status == status &&
      listEquals(other.passengerDetails, passengerDetails);
  }

  @override
  int get hashCode {
    return busName.hashCode ^
      droppingPoint.hashCode ^
      dropTime.hashCode ^
      doj.hashCode ^
      fare.hashCode ^
      boardingDate.hashCode ^
      droppingDate.hashCode ^
      seatNumber.hashCode ^
      contactNumber.hashCode ^
      boardingPoint.hashCode ^
      boardingTime.hashCode ^
      droppingTime.hashCode ^
      busType.hashCode ^
      duration.hashCode ^
      busNumber.hashCode ^
      pickUpTime.hashCode ^
      pickUpPoint.hashCode ^
      totalSeats.hashCode ^
      passengerName.hashCode ^
      source.hashCode ^
      destination.hashCode ^
      operatorDetails.hashCode ^
      age.hashCode ^
      departureDate.hashCode ^
      sleeper.hashCode ^
      seater.hashCode ^
      address.hashCode ^
      city.hashCode ^
      country.hashCode ^
      itineraryBookingId.hashCode ^
      fareType.hashCode ^
      fareBasis.hashCode ^
      dealCode.hashCode ^
      tourCode.hashCode ^
      status.hashCode ^
      passengerDetails.hashCode;
  }
}
