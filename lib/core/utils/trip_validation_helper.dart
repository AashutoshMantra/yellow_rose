import 'package:yellow_rose/features/trip/data/models/trip_response.dart';
import 'package:yellow_rose/features/trip/data/models/trip_create_request.dart';

class TripValidationHelper {
  static TripValidationResult validatePassengerCounts({
    required TripResponse? selectedTrip,
    required int currentAdultCount,
    required int currentChildCount,
    required int currentInfantCount,
  }) {
    // No trip selected - allow normal behavior
    if (selectedTrip == null) {
      return TripValidationResult(
        isValid: true,
        allowChanges: true,
        allowedAdultCount: currentAdultCount,
        allowedChildCount: currentChildCount,
        allowedInfantCount: currentInfantCount,
        validationMessage: null,
      );
    }

    if (selectedTrip.tripFor == TripFor.Self.value) {
      return TripValidationResult(
        isValid: currentAdultCount == 1 &&
            currentChildCount == 0 &&
            currentInfantCount == 0,
        allowChanges: false,
        allowedAdultCount: 1,
        allowedChildCount: 0,
        allowedInfantCount: 0,
        validationMessage: currentAdultCount != 1 ||
                currentChildCount != 0 ||
                currentInfantCount != 0
            ? "Self trip allows only 1 adult traveler"
            : null,
      );
    }

    if (selectedTrip.tripFor == TripFor.OnBehalfOf.value) {
      final onBehalfCount = selectedTrip.tripDetails?.onBehalf?.length ?? 0;

      return TripValidationResult(
        isValid: currentAdultCount == onBehalfCount &&
            currentChildCount == 0 &&
            currentInfantCount == 0,
        allowChanges: false,
        allowedAdultCount: onBehalfCount,
        allowedChildCount: 0,
        allowedInfantCount: 0,
        validationMessage: currentAdultCount != onBehalfCount ||
                currentChildCount != 0 ||
                currentInfantCount != 0
            ? "On behalf trip requires exactly $onBehalfCount adult travelers"
            : null,
      );
    }

    return TripValidationResult(
      isValid: true,
      allowChanges: true,
      allowedAdultCount: currentAdultCount,
      allowedChildCount: currentChildCount,
      allowedInfantCount: currentInfantCount,
      validationMessage: null,
    );
  }

  static bool shouldDisablePassengerControls(TripResponse? selectedTrip) {
    if (selectedTrip == null) return false;

    return selectedTrip.tripFor == TripFor.Self.value ||
        selectedTrip.tripFor == TripFor.OnBehalfOf.value;
  }

  static PassengerCountConstraints getRequiredPassengerCounts(
      TripResponse? selectedTrip) {
    if (selectedTrip == null) {
      return PassengerCountConstraints(
        adultCount: null,
        childCount: null,
        infantCount: null,
      );
    }

    if (selectedTrip.tripFor == TripFor.Self.value) {
      return PassengerCountConstraints(
        adultCount: 1,
        childCount: 0,
        infantCount: 0,
      );
    }

    if (selectedTrip.tripFor == TripFor.OnBehalfOf.value) {
      final onBehalfCount = selectedTrip.tripDetails?.onBehalf?.length ?? 0;
      return PassengerCountConstraints(
        adultCount: onBehalfCount,
        childCount: 0,
        infantCount: 0,
      );
    }

    return PassengerCountConstraints(
      adultCount: null,
      childCount: null,
      infantCount: null,
    );
  }
}

class TripValidationResult {
  final bool isValid;
  final bool allowChanges;
  final int allowedAdultCount;
  final int allowedChildCount;
  final int allowedInfantCount;
  final String? validationMessage;

  TripValidationResult({
    required this.isValid,
    required this.allowChanges,
    required this.allowedAdultCount,
    required this.allowedChildCount,
    required this.allowedInfantCount,
    this.validationMessage,
  });
}

class PassengerCountConstraints {
  final int? adultCount;
  final int? childCount;
  final int? infantCount;

  PassengerCountConstraints({
    this.adultCount,
    this.childCount,
    this.infantCount,
  });

  bool get hasConstraints =>
      adultCount != null || childCount != null || infantCount != null;
}
