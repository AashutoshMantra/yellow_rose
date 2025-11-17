import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:yellow_rose/features/bus/data/models/order/bus_inventory_item.dart';
import 'package:yellow_rose/features/bus/data/models/order/bus_invoice_data.dart';
import 'package:yellow_rose/features/bus/data/models/order/bus_reschedule_polcy.dart';

class BusPrintTicketResponse {
  final String? bookingFee;
  final String? busType;
  final String? cancellationCalculationTimestamp;
  final String? cancellationMessage;
  final String? cancellationPolicy;
  final String? cancellationCharges;
  final String? cancellationReason;
  final String? dateOfIssue;
  final String? dateOfCancellation; // new
  final String? destinationCity;
  final String? destinationCityId;
  final String? doj;
  final String? dropLocation;
  final String? dropLocationAddress;
  final String? dropLocationId;
  final String? dropLocationLandmark;
  final String? dropTime;
  final String? firstBoardingPointTime;
  final String? hasRTCBreakup;
  final String? hasSpecialTemplate;
  final String? pickupLatitude;
  final String? pickupLongitude;
  final String? inventoryId;
  final List<BusInventoryItem>? inventoryItems;
  final String? mTicketEnabled;
  // final OtherDetails otherDetails;
  final String? partialCancellationAllowed;
  final String? pickUpContactNo;
  final String? pickUpLocationAddress;
  final String? pickupLocation;
  final String? pickupLocationId;
  final String? pickupLocationLandmark;
  final String? pickupTime;
  final String? pnr;
  final String? primeDepartureTime;
  final String? primoBooking;
  final BusReschedulingPolicy? reschedulingPolicy;
  final String? serviceCharge;
  final String? serviceStartTime;
  final String? sourceCity;
  final String? sourceCityId;
  final String? status;
  final String? tin;
  final String? travels;
  final String? vaccinatedBus;
  final String? vaccinatedStaff;

  final String? refundAmount;
  final String? refundServiceTax;
  final String? serviceTaxOnCancellationCharge;
  final BusInvoiceData? invoiceData;
  BusPrintTicketResponse({
    this.bookingFee,
    this.busType,
    this.cancellationCalculationTimestamp,
    this.cancellationMessage,
    this.cancellationPolicy,
    this.cancellationCharges,
    this.cancellationReason,
    this.dateOfIssue,
    this.dateOfCancellation,
    this.destinationCity,
    this.destinationCityId,
    this.doj,
    this.dropLocation,
    this.dropLocationAddress,
    this.dropLocationId,
    this.dropLocationLandmark,
    this.dropTime,
    this.firstBoardingPointTime,
    this.hasRTCBreakup,
    this.hasSpecialTemplate,
    this.pickupLatitude,
    this.pickupLongitude,
    this.inventoryId,
    this.inventoryItems,
    this.mTicketEnabled,
    this.partialCancellationAllowed,
    this.pickUpContactNo,
    this.pickUpLocationAddress,
    this.pickupLocation,
    this.pickupLocationId,
    this.pickupLocationLandmark,
    this.pickupTime,
    this.pnr,
    this.primeDepartureTime,
    this.primoBooking,
    this.reschedulingPolicy,
    this.serviceCharge,
    this.serviceStartTime,
    this.sourceCity,
    this.sourceCityId,
    this.status,
    this.tin,
    this.travels,
    this.vaccinatedBus,
    this.vaccinatedStaff,
    this.refundAmount,
    this.refundServiceTax,
    this.serviceTaxOnCancellationCharge,
    this.invoiceData,
  });

  BusPrintTicketResponse copyWith({
    String? bookingFee,
    String? busType,
    String? cancellationCalculationTimestamp,
    String? cancellationMessage,
    String? cancellationPolicy,
    String? cancellationCharges,
    String? cancellationReason,
    String? dateOfIssue,
    String? dateOfCancellation,
    String? destinationCity,
    String? destinationCityId,
    String? doj,
    String? dropLocation,
    String? dropLocationAddress,
    String? dropLocationId,
    String? dropLocationLandmark,
    String? dropTime,
    String? firstBoardingPointTime,
    String? hasRTCBreakup,
    String? hasSpecialTemplate,
    String? pickupLatitude,
    String? pickupLongitude,
    String? inventoryId,
    List<BusInventoryItem>? inventoryItems,
    String? mTicketEnabled,
    String? partialCancellationAllowed,
    String? pickUpContactNo,
    String? pickUpLocationAddress,
    String? pickupLocation,
    String? pickupLocationId,
    String? pickupLocationLandmark,
    String? pickupTime,
    String? pnr,
    String? primeDepartureTime,
    String? primoBooking,
    BusReschedulingPolicy? reschedulingPolicy,
    String? serviceCharge,
    String? serviceStartTime,
    String? sourceCity,
    String? sourceCityId,
    String? status,
    String? tin,
    String? travels,
    String? vaccinatedBus,
    String? vaccinatedStaff,
    String? refundAmount,
    String? refundServiceTax,
    String? serviceTaxOnCancellationCharge,
    BusInvoiceData? invoiceData,
  }) {
    return BusPrintTicketResponse(
      bookingFee: bookingFee ?? this.bookingFee,
      busType: busType ?? this.busType,
      cancellationCalculationTimestamp: cancellationCalculationTimestamp ??
          this.cancellationCalculationTimestamp,
      cancellationMessage: cancellationMessage ?? this.cancellationMessage,
      cancellationPolicy: cancellationPolicy ?? this.cancellationPolicy,
      cancellationCharges: cancellationCharges ?? this.cancellationCharges,
      cancellationReason: cancellationReason ?? this.cancellationReason,
      dateOfIssue: dateOfIssue ?? this.dateOfIssue,
      dateOfCancellation: dateOfCancellation ?? this.dateOfCancellation,
      destinationCity: destinationCity ?? this.destinationCity,
      destinationCityId: destinationCityId ?? this.destinationCityId,
      doj: doj ?? this.doj,
      dropLocation: dropLocation ?? this.dropLocation,
      dropLocationAddress: dropLocationAddress ?? this.dropLocationAddress,
      dropLocationId: dropLocationId ?? this.dropLocationId,
      dropLocationLandmark: dropLocationLandmark ?? this.dropLocationLandmark,
      dropTime: dropTime ?? this.dropTime,
      firstBoardingPointTime:
          firstBoardingPointTime ?? this.firstBoardingPointTime,
      hasRTCBreakup: hasRTCBreakup ?? this.hasRTCBreakup,
      hasSpecialTemplate: hasSpecialTemplate ?? this.hasSpecialTemplate,
      pickupLatitude: pickupLatitude ?? this.pickupLatitude,
      pickupLongitude: pickupLongitude ?? this.pickupLongitude,
      inventoryId: inventoryId ?? this.inventoryId,
      inventoryItems: inventoryItems ?? this.inventoryItems,
      mTicketEnabled: mTicketEnabled ?? this.mTicketEnabled,
      partialCancellationAllowed:
          partialCancellationAllowed ?? this.partialCancellationAllowed,
      pickUpContactNo: pickUpContactNo ?? this.pickUpContactNo,
      pickUpLocationAddress:
          pickUpLocationAddress ?? this.pickUpLocationAddress,
      pickupLocation: pickupLocation ?? this.pickupLocation,
      pickupLocationId: pickupLocationId ?? this.pickupLocationId,
      pickupLocationLandmark:
          pickupLocationLandmark ?? this.pickupLocationLandmark,
      pickupTime: pickupTime ?? this.pickupTime,
      pnr: pnr ?? this.pnr,
      primeDepartureTime: primeDepartureTime ?? this.primeDepartureTime,
      primoBooking: primoBooking ?? this.primoBooking,
      reschedulingPolicy: reschedulingPolicy ?? this.reschedulingPolicy,
      serviceCharge: serviceCharge ?? this.serviceCharge,
      serviceStartTime: serviceStartTime ?? this.serviceStartTime,
      sourceCity: sourceCity ?? this.sourceCity,
      sourceCityId: sourceCityId ?? this.sourceCityId,
      status: status ?? this.status,
      tin: tin ?? this.tin,
      travels: travels ?? this.travels,
      vaccinatedBus: vaccinatedBus ?? this.vaccinatedBus,
      vaccinatedStaff: vaccinatedStaff ?? this.vaccinatedStaff,
      refundAmount: refundAmount ?? this.refundAmount,
      refundServiceTax: refundServiceTax ?? this.refundServiceTax,
      serviceTaxOnCancellationCharge:
          serviceTaxOnCancellationCharge ?? this.serviceTaxOnCancellationCharge,
      invoiceData: invoiceData ?? this.invoiceData,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (bookingFee != null) {
      result.addAll({'bookingFee': bookingFee});
    }
    if (busType != null) {
      result.addAll({'busType': busType});
    }
    if (cancellationCalculationTimestamp != null) {
      result.addAll({
        'cancellationCalculationTimestamp': cancellationCalculationTimestamp
      });
    }
    if (cancellationMessage != null) {
      result.addAll({'cancellationMessage': cancellationMessage});
    }
    if (cancellationPolicy != null) {
      result.addAll({'cancellationPolicy': cancellationPolicy});
    }
    if (cancellationCharges != null) {
      result.addAll({'cancellationCharges': cancellationCharges});
    }
    if (cancellationReason != null) {
      result.addAll({'cancellationReason': cancellationReason});
    }
    if (dateOfIssue != null) {
      result.addAll({'dateOfIssue': dateOfIssue});
    }
    if (dateOfCancellation != null) {
      result.addAll({'dateOfCancellation': dateOfCancellation});
    }
    if (destinationCity != null) {
      result.addAll({'destinationCity': destinationCity});
    }
    if (destinationCityId != null) {
      result.addAll({'destinationCityId': destinationCityId});
    }
    if (doj != null) {
      result.addAll({'doj': doj});
    }
    if (dropLocation != null) {
      result.addAll({'dropLocation': dropLocation});
    }
    if (dropLocationAddress != null) {
      result.addAll({'dropLocationAddress': dropLocationAddress});
    }
    if (dropLocationId != null) {
      result.addAll({'dropLocationId': dropLocationId});
    }
    if (dropLocationLandmark != null) {
      result.addAll({'dropLocationLandmark': dropLocationLandmark});
    }
    if (dropTime != null) {
      result.addAll({'dropTime': dropTime});
    }
    if (firstBoardingPointTime != null) {
      result.addAll({'firstBoardingPointTime': firstBoardingPointTime});
    }
    if (hasRTCBreakup != null) {
      result.addAll({'hasRTCBreakup': hasRTCBreakup});
    }
    if (hasSpecialTemplate != null) {
      result.addAll({'hasSpecialTemplate': hasSpecialTemplate});
    }
    if (pickupLatitude != null) {
      result.addAll({'pickupLatitude': pickupLatitude});
    }
    if (pickupLongitude != null) {
      result.addAll({'pickupLongitude': pickupLongitude});
    }
    if (inventoryId != null) {
      result.addAll({'inventoryId': inventoryId});
    }
    if (inventoryItems != null) {
      result.addAll(
          {'inventoryItems': inventoryItems!.map((x) => x.toMap()).toList()});
    }
    if (mTicketEnabled != null) {
      result.addAll({'mTicketEnabled': mTicketEnabled});
    }
    if (partialCancellationAllowed != null) {
      result.addAll({'partialCancellationAllowed': partialCancellationAllowed});
    }
    if (pickUpContactNo != null) {
      result.addAll({'pickUpContactNo': pickUpContactNo});
    }
    if (pickUpLocationAddress != null) {
      result.addAll({'pickUpLocationAddress': pickUpLocationAddress});
    }
    if (pickupLocation != null) {
      result.addAll({'pickupLocation': pickupLocation});
    }
    if (pickupLocationId != null) {
      result.addAll({'pickupLocationId': pickupLocationId});
    }
    if (pickupLocationLandmark != null) {
      result.addAll({'pickupLocationLandmark': pickupLocationLandmark});
    }
    if (pickupTime != null) {
      result.addAll({'pickupTime': pickupTime});
    }
    if (pnr != null) {
      result.addAll({'pnr': pnr});
    }
    if (primeDepartureTime != null) {
      result.addAll({'primeDepartureTime': primeDepartureTime});
    }
    if (primoBooking != null) {
      result.addAll({'primoBooking': primoBooking});
    }
    if (reschedulingPolicy != null) {
      result.addAll({'reschedulingPolicy': reschedulingPolicy!.toMap()});
    }
    if (serviceCharge != null) {
      result.addAll({'serviceCharge': serviceCharge});
    }
    if (serviceStartTime != null) {
      result.addAll({'serviceStartTime': serviceStartTime});
    }
    if (sourceCity != null) {
      result.addAll({'sourceCity': sourceCity});
    }
    if (sourceCityId != null) {
      result.addAll({'sourceCityId': sourceCityId});
    }
    if (status != null) {
      result.addAll({'status': status});
    }
    if (tin != null) {
      result.addAll({'tin': tin});
    }
    if (travels != null) {
      result.addAll({'travels': travels});
    }
    if (vaccinatedBus != null) {
      result.addAll({'vaccinatedBus': vaccinatedBus});
    }
    if (vaccinatedStaff != null) {
      result.addAll({'vaccinatedStaff': vaccinatedStaff});
    }
    if (refundAmount != null) {
      result.addAll({'refundAmount': refundAmount});
    }
    if (refundServiceTax != null) {
      result.addAll({'refundServiceTax': refundServiceTax});
    }
    if (serviceTaxOnCancellationCharge != null) {
      result.addAll(
          {'serviceTaxOnCancellationCharge': serviceTaxOnCancellationCharge});
    }
    if (invoiceData != null) {
      result.addAll({'invoiceData': invoiceData!.toMap()});
    }

    return result;
  }

  factory BusPrintTicketResponse.fromMap(Map<String, dynamic> map) {
    return BusPrintTicketResponse(
      bookingFee: map['bookingFee'],
      busType: map['busType'],
      cancellationCalculationTimestamp: map['cancellationCalculationTimestamp'],
      cancellationMessage: map['cancellationMessage'],
      cancellationPolicy: map['cancellationPolicy'],
      cancellationCharges: map['cancellationCharges'],
      cancellationReason: map['cancellationReason'],
      dateOfIssue: map['dateOfIssue'],
      dateOfCancellation: map['dateOfCancellation'],
      destinationCity: map['destinationCity'],
      destinationCityId: map['destinationCityId'],
      doj: map['doj'],
      dropLocation: map['dropLocation'],
      dropLocationAddress: map['dropLocationAddress'],
      dropLocationId: map['dropLocationId'],
      dropLocationLandmark: map['dropLocationLandmark'],
      dropTime: map['dropTime'],
      firstBoardingPointTime: map['firstBoardingPointTime'],
      hasRTCBreakup: map['hasRTCBreakup'],
      hasSpecialTemplate: map['hasSpecialTemplate'],
      pickupLatitude: map['pickupLatitude'],
      pickupLongitude: map['pickupLongitude'],
      inventoryId: map['inventoryId'],
      inventoryItems: map['inventoryItems'] != null
          ? List<BusInventoryItem>.from(
              map['inventoryItems']?.map((x) => BusInventoryItem.fromMap(x)))
          : null,
      mTicketEnabled: map['mTicketEnabled'],
      partialCancellationAllowed: map['partialCancellationAllowed'],
      pickUpContactNo: map['pickUpContactNo'],
      pickUpLocationAddress: map['pickUpLocationAddress'],
      pickupLocation: map['pickupLocation'],
      pickupLocationId: map['pickupLocationId'],
      pickupLocationLandmark: map['pickupLocationLandmark'],
      pickupTime: map['pickupTime'],
      pnr: map['pnr'],
      primeDepartureTime: map['primeDepartureTime'],
      primoBooking: map['primoBooking'],
      reschedulingPolicy: map['reschedulingPolicy'] != null
          ? BusReschedulingPolicy.fromMap(map['reschedulingPolicy'])
          : null,
      serviceCharge: map['serviceCharge'],
      serviceStartTime: map['serviceStartTime'],
      sourceCity: map['sourceCity'],
      sourceCityId: map['sourceCityId'],
      status: map['status'],
      tin: map['tin'],
      travels: map['travels'],
      vaccinatedBus: map['vaccinatedBus'],
      vaccinatedStaff: map['vaccinatedStaff'],
      refundAmount: map['refundAmount'],
      refundServiceTax: map['refundServiceTax'],
      serviceTaxOnCancellationCharge: map['serviceTaxOnCancellationCharge'],
      invoiceData: map['invoiceData'] != null
          ? BusInvoiceData.fromMap(map['invoiceData'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BusPrintTicketResponse.fromJson(String source) =>
      BusPrintTicketResponse.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BusPrintTicketResponse(bookingFee: $bookingFee, busType: $busType, cancellationCalculationTimestamp: $cancellationCalculationTimestamp, cancellationMessage: $cancellationMessage, cancellationPolicy: $cancellationPolicy, cancellationCharges: $cancellationCharges, cancellationReason: $cancellationReason, dateOfIssue: $dateOfIssue, dateOfCancellation: $dateOfCancellation, destinationCity: $destinationCity, destinationCityId: $destinationCityId, doj: $doj, dropLocation: $dropLocation, dropLocationAddress: $dropLocationAddress, dropLocationId: $dropLocationId, dropLocationLandmark: $dropLocationLandmark, dropTime: $dropTime, firstBoardingPointTime: $firstBoardingPointTime, hasRTCBreakup: $hasRTCBreakup, hasSpecialTemplate: $hasSpecialTemplate, pickupLatitude: $pickupLatitude, pickupLongitude: $pickupLongitude, inventoryId: $inventoryId, inventoryItems: $inventoryItems, mTicketEnabled: $mTicketEnabled, partialCancellationAllowed: $partialCancellationAllowed, pickUpContactNo: $pickUpContactNo, pickUpLocationAddress: $pickUpLocationAddress, pickupLocation: $pickupLocation, pickupLocationId: $pickupLocationId, pickupLocationLandmark: $pickupLocationLandmark, pickupTime: $pickupTime, pnr: $pnr, primeDepartureTime: $primeDepartureTime, primoBooking: $primoBooking, reschedulingPolicy: $reschedulingPolicy, serviceCharge: $serviceCharge, serviceStartTime: $serviceStartTime, sourceCity: $sourceCity, sourceCityId: $sourceCityId, status: $status, tin: $tin, travels: $travels, vaccinatedBus: $vaccinatedBus, vaccinatedStaff: $vaccinatedStaff, refundAmount: $refundAmount, refundServiceTax: $refundServiceTax, serviceTaxOnCancellationCharge: $serviceTaxOnCancellationCharge, invoiceData: $invoiceData)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BusPrintTicketResponse &&
        other.bookingFee == bookingFee &&
        other.busType == busType &&
        other.cancellationCalculationTimestamp ==
            cancellationCalculationTimestamp &&
        other.cancellationMessage == cancellationMessage &&
        other.cancellationPolicy == cancellationPolicy &&
        other.cancellationCharges == cancellationCharges &&
        other.cancellationReason == cancellationReason &&
        other.dateOfIssue == dateOfIssue &&
        other.dateOfCancellation == dateOfCancellation &&
        other.destinationCity == destinationCity &&
        other.destinationCityId == destinationCityId &&
        other.doj == doj &&
        other.dropLocation == dropLocation &&
        other.dropLocationAddress == dropLocationAddress &&
        other.dropLocationId == dropLocationId &&
        other.dropLocationLandmark == dropLocationLandmark &&
        other.dropTime == dropTime &&
        other.firstBoardingPointTime == firstBoardingPointTime &&
        other.hasRTCBreakup == hasRTCBreakup &&
        other.hasSpecialTemplate == hasSpecialTemplate &&
        other.pickupLatitude == pickupLatitude &&
        other.pickupLongitude == pickupLongitude &&
        other.inventoryId == inventoryId &&
        listEquals(other.inventoryItems, inventoryItems) &&
        other.mTicketEnabled == mTicketEnabled &&
        other.partialCancellationAllowed == partialCancellationAllowed &&
        other.pickUpContactNo == pickUpContactNo &&
        other.pickUpLocationAddress == pickUpLocationAddress &&
        other.pickupLocation == pickupLocation &&
        other.pickupLocationId == pickupLocationId &&
        other.pickupLocationLandmark == pickupLocationLandmark &&
        other.pickupTime == pickupTime &&
        other.pnr == pnr &&
        other.primeDepartureTime == primeDepartureTime &&
        other.primoBooking == primoBooking &&
        other.reschedulingPolicy == reschedulingPolicy &&
        other.serviceCharge == serviceCharge &&
        other.serviceStartTime == serviceStartTime &&
        other.sourceCity == sourceCity &&
        other.sourceCityId == sourceCityId &&
        other.status == status &&
        other.tin == tin &&
        other.travels == travels &&
        other.vaccinatedBus == vaccinatedBus &&
        other.vaccinatedStaff == vaccinatedStaff &&
        other.refundAmount == refundAmount &&
        other.refundServiceTax == refundServiceTax &&
        other.serviceTaxOnCancellationCharge ==
            serviceTaxOnCancellationCharge &&
        other.invoiceData == invoiceData;
  }

  @override
  int get hashCode {
    return bookingFee.hashCode ^
        busType.hashCode ^
        cancellationCalculationTimestamp.hashCode ^
        cancellationMessage.hashCode ^
        cancellationPolicy.hashCode ^
        cancellationCharges.hashCode ^
        cancellationReason.hashCode ^
        dateOfIssue.hashCode ^
        dateOfCancellation.hashCode ^
        destinationCity.hashCode ^
        destinationCityId.hashCode ^
        doj.hashCode ^
        dropLocation.hashCode ^
        dropLocationAddress.hashCode ^
        dropLocationId.hashCode ^
        dropLocationLandmark.hashCode ^
        dropTime.hashCode ^
        firstBoardingPointTime.hashCode ^
        hasRTCBreakup.hashCode ^
        hasSpecialTemplate.hashCode ^
        pickupLatitude.hashCode ^
        pickupLongitude.hashCode ^
        inventoryId.hashCode ^
        inventoryItems.hashCode ^
        mTicketEnabled.hashCode ^
        partialCancellationAllowed.hashCode ^
        pickUpContactNo.hashCode ^
        pickUpLocationAddress.hashCode ^
        pickupLocation.hashCode ^
        pickupLocationId.hashCode ^
        pickupLocationLandmark.hashCode ^
        pickupTime.hashCode ^
        pnr.hashCode ^
        primeDepartureTime.hashCode ^
        primoBooking.hashCode ^
        reschedulingPolicy.hashCode ^
        serviceCharge.hashCode ^
        serviceStartTime.hashCode ^
        sourceCity.hashCode ^
        sourceCityId.hashCode ^
        status.hashCode ^
        tin.hashCode ^
        travels.hashCode ^
        vaccinatedBus.hashCode ^
        vaccinatedStaff.hashCode ^
        refundAmount.hashCode ^
        refundServiceTax.hashCode ^
        serviceTaxOnCancellationCharge.hashCode ^
        invoiceData.hashCode;
  }
}
