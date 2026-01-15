/// Configuration for SSR (Special Service Request) restrictions
///
/// This class defines rules for restricting which SSR options can be displayed
/// for specific flights based on airline code and flight position.
class SsrRestrictionConfig {
  /// The airline code (e.g., "6E" for IndiGo)
  final String airlineCode;

  /// The SSR code to restrict (e.g., "FFWD")
  final String ssrCode;

  /// If true, this SSR is only available for the first flight
  /// If false, this SSR is restricted from the first flight
  final bool firstFlightOnly;

  /// Optional: Description of the restriction for documentation
  final String? description;

  const SsrRestrictionConfig({
    required this.airlineCode,
    required this.ssrCode,
    required this.firstFlightOnly,
    this.description,
  });

  /// Check if this restriction applies to a given flight
  /// [flightIndex] is 0-based (0 = first flight, 1 = second flight, etc.)
  /// [carrierCode] is the airline code of the flight
  bool shouldRestrictSsr(int flightIndex, String carrierCode) {
    // Only apply restriction if airline matches
    if (carrierCode != airlineCode) {
      return false;
    }

    // If firstFlightOnly is true, restrict SSR for flights after the first
    // (i.e., hide it when flightIndex > 0)
    if (firstFlightOnly) {
      return flightIndex > 0;
    }

    // If firstFlightOnly is false, restrict SSR only for the first flight
    // (i.e., hide it when flightIndex == 0)
    return flightIndex == 0;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SsrRestrictionConfig &&
        other.airlineCode == airlineCode &&
        other.ssrCode == ssrCode &&
        other.firstFlightOnly == firstFlightOnly;
  }

  @override
  int get hashCode =>
      airlineCode.hashCode ^ ssrCode.hashCode ^ firstFlightOnly.hashCode;

  @override
  String toString() {
    return 'SsrRestrictionConfig(airline: $airlineCode, ssr: $ssrCode, firstFlightOnly: $firstFlightOnly)';
  }
}

/// Central repository of SSR restriction rules
///
/// Add new restriction rules here as they are identified for different airlines
class SsrRestrictionRepository {
  SsrRestrictionRepository._();

  /// All configured SSR restrictions
  ///
  /// To add a new restriction:
  /// 1. Identify the airline code (e.g., "6E" for IndiGo)
  /// 2. Identify the SSR code (e.g., "FFWD")
  /// 3. Determine if it should only appear on first flight (true) or only on subsequent flights (false)
  /// 4. Add a new SsrRestrictionConfig entry with a description
  static const List<SsrRestrictionConfig> restrictions = [
    // IndiGo (6E) - FFWD SSR should only appear on first flight
    SsrRestrictionConfig(
      airlineCode: '6E',
      ssrCode: 'FFWD',
      firstFlightOnly: true,
      description:
          'IndiGo FFWD special service is only available for the first flight segment',
    ),

    // Add more restrictions here as needed:
    // Example for future use:
    // SsrRestrictionConfig(
    //   airlineCode: 'AI',
    //   ssrCode: 'WCHR',
    //   firstFlightOnly: false,
    //   description: 'Air India wheelchair service not available on first flight',
    // ),
  ];

  /// Get all restrictions that apply to a specific airline
  static List<SsrRestrictionConfig> getRestrictionsForAirline(
      String airlineCode) {
    return restrictions
        .where((restriction) => restriction.airlineCode == airlineCode)
        .toList();
  }

  /// Get all restrictions for a specific SSR code
  static List<SsrRestrictionConfig> getRestrictionsForSsr(String ssrCode) {
    return restrictions
        .where((restriction) => restriction.ssrCode == ssrCode)
        .toList();
  }

  /// Check if an SSR should be restricted for a given flight
  ///
  /// [ssrCode] - The SSR code to check
  /// [flightIndex] - The 0-based index of the flight (0 = first, 1 = second, etc.)
  /// [carrierCode] - The airline code of the flight
  ///
  /// Returns true if the SSR should be hidden/restricted, false if it should be shown
  static bool shouldRestrictSsr({
    required String ssrCode,
    required int flightIndex,
    required String carrierCode,
  }) {
    // Find any restriction that matches this SSR code and applies to this flight
    return restrictions.any((restriction) =>
        restriction.ssrCode == ssrCode &&
        restriction.shouldRestrictSsr(flightIndex, carrierCode));
  }

  /// Get list of all configured airline codes
  static Set<String> getAllConfiguredAirlines() {
    return restrictions.map((r) => r.airlineCode).toSet();
  }

  /// Get list of all configured SSR codes
  static Set<String> getAllConfiguredSsrCodes() {
    return restrictions.map((r) => r.ssrCode).toSet();
  }
}
