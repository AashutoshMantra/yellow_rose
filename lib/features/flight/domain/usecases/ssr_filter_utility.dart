import 'package:yellow_rose/features/flight/data/models/booking/ssor_options.dart';
import 'package:yellow_rose/features/flight/data/models/booking/ssr_response.dart';
import 'package:yellow_rose/features/flight/domain/entities/ssr_restriction_config.dart';

/// Utility class for filtering SSR options based on flight-specific restrictions
class SsrFilterUtility {
  SsrFilterUtility._();

  /// Filter SSR response to remove restricted options for a specific flight
  ///
  /// [ssrResponse] - The full SSR response from the API
  /// [flightIndex] - The 0-based index of the flight in the itinerary (0 = first, 1 = second, etc.)
  /// [carrierCode] - The airline code for this flight (e.g., "6E" for IndiGo)
  ///
  /// Returns a new SsrResponse with restricted SSR options removed
  static SsrResponse filterSsrResponseForFlight({
    required SsrResponse ssrResponse,
    required int flightIndex,
    required String carrierCode,
  }) {
    return ssrResponse.copyWith(
      ssrMeals: _filterSsrList(
        ssrList: ssrResponse.ssrMeals,
        flightIndex: flightIndex,
        carrierCode: carrierCode,
      ),
      ssrBaggage: _filterSsrList(
        ssrList: ssrResponse.ssrBaggage,
        flightIndex: flightIndex,
        carrierCode: carrierCode,
      ),
      ssrSpecial: _filterSsrList(
        ssrList: ssrResponse.ssrSpecial,
        flightIndex: flightIndex,
        carrierCode: carrierCode,
      ),
      miscSSR: _filterSsrList(
        ssrList: ssrResponse.miscSSR,
        flightIndex: flightIndex,
        carrierCode: carrierCode,
      ),
    );
  }

  /// Filter a list of SSR options based on restrictions
  ///
  /// [ssrList] - List of SSR options to filter
  /// [flightIndex] - The 0-based flight index
  /// [carrierCode] - The airline code
  ///
  /// Returns filtered list with restricted SSRs removed
  static List<SsrOption> _filterSsrList({
    required List<SsrOption> ssrList,
    required int flightIndex,
    required String carrierCode,
  }) {
    return ssrList.where((ssr) {
      // Check if this SSR should be restricted for this flight
      final shouldRestrict = SsrRestrictionRepository.shouldRestrictSsr(
        ssrCode: ssr.code,
        flightIndex: flightIndex,
        carrierCode: carrierCode,
      );

      // Return true (keep) if NOT restricted, false (filter out) if restricted
      return !shouldRestrict;
    }).toList();
  }

  /// Check if a specific SSR option should be shown for a flight
  ///
  /// This is a convenience method for UI components
  ///
  /// [ssrCode] - The SSR code to check
  /// [flightIndex] - The flight index (0-based)
  /// [carrierCode] - The airline code
  ///
  /// Returns true if the SSR should be shown, false if it should be hidden
  static bool shouldShowSsr({
    required String ssrCode,
    required int flightIndex,
    required String carrierCode,
  }) {
    return !SsrRestrictionRepository.shouldRestrictSsr(
      ssrCode: ssrCode,
      flightIndex: flightIndex,
      carrierCode: carrierCode,
    );
  }

  /// Get a filtered SSR response for multiple flights
  ///
  /// Returns a map of flight keys to filtered SSR responses
  ///
  /// [ssrResponses] - Map of flight keys to SSR responses
  /// [flightDetails] - List of flight carrier codes in order
  ///
  /// Example:
  /// ```dart
  /// final filtered = SsrFilterUtility.filterSsrResponsesForItinerary(
  ///   ssrResponses: {'6E-123#DEL#BOM': ssrResponse1, '6E-456#BOM#GOA': ssrResponse2},
  ///   flightDetails: ['6E', '6E'],
  /// );
  /// ```
  static Map<String, SsrResponse?> filterSsrResponsesForItinerary({
    required Map<String, SsrResponse?> ssrResponses,
    required List<String> flightCarrierCodes,
  }) {
    final filteredResponses = <String, SsrResponse?>{};

    // Track which flight index we're on across the itinerary
    int globalFlightIndex = 0;

    ssrResponses.forEach((flightKey, ssrResponse) {
      if (ssrResponse == null) {
        filteredResponses[flightKey] = null;
        return;
      }

      // Determine which flight this is (0-based index)
      // Use the globalFlightIndex to track position across itinerary
      final carrierCode = flightCarrierCodes.length > globalFlightIndex
          ? flightCarrierCodes[globalFlightIndex]
          : _extractCarrierCodeFromKey(flightKey);

      // Filter this flight's SSR options
      filteredResponses[flightKey] = filterSsrResponseForFlight(
        ssrResponse: ssrResponse,
        flightIndex: globalFlightIndex,
        carrierCode: carrierCode,
      );

      globalFlightIndex++;
    });

    return filteredResponses;
  }

  /// Extract carrier code from flight key
  /// Flight key format: "{carrierName}-{flightNumber}#{fromAirport}#{toAirport}"
  static String _extractCarrierCodeFromKey(String flightKey) {
    final parts = flightKey.split('-');
    return parts.isNotEmpty ? parts[0] : '';
  }
}
