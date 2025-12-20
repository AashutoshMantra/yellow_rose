/// Utility class for parsing DateTime from API responses
/// Preserves the time as shown in the string, ignoring timezone conversions
class DateTimeParser {
  /// Parses DateTime string and preserves the time as shown, ignoring timezone conversion
  ///
  /// Examples:
  /// - "2025-10-14T15:40:00.000+05:30" -> DateTime with 15:40 (not converted)
  /// - "2025-10-14T15:40:00Z" -> DateTime with 15:40 (not converted to local)
  /// - "2025-10-14T15:40:00.000-07:00" -> DateTime with 15:40
  /// - 1697294400000 (milliseconds) -> DateTime from epoch
  static DateTime? parse(dynamic dateTimeStr) {
    if (dateTimeStr == null) {
      throw ArgumentError('DateTime string cannot be null');
    }

    // Handle milliseconds since epoch
    if (dateTimeStr is int) {
      return DateTime.fromMillisecondsSinceEpoch(dateTimeStr);
    }

    String str = dateTimeStr.toString().trim();

    if (str.isEmpty) {
      throw ArgumentError('DateTime string cannot be empty');
    }

    // Remove timezone information to parse as local time
    // This preserves the time as shown in the string

    // Handle 'Z' (UTC indicator)
    if (str.endsWith('Z')) {
      str = str.substring(0, str.length - 1);
    }

    // Handle positive timezone offset like "+05:30" or "+0530"
    if (str.contains('+')) {
      str = str.split('+')[0];
    }

    // Handle negative timezone offset like "-07:00" or "-0700"
    // Be careful not to remove the date separator (e.g., "2025-10-14")
    int lastMinusIndex = str.lastIndexOf('-');
    if (lastMinusIndex > 8) {
      // Only if it appears after the date part
      str = str.substring(0, lastMinusIndex);
    }
    try {
      return DateTime.tryParse(str);
    } catch (e) {
      return null;
    }

    // Parse the cleaned string as local DateTime
  }

  /// Safely parses DateTime, returns null if parsing fails
  static DateTime? tryParse(dynamic dateTimeStr) {
    try {
      return parse(dateTimeStr);
    } catch (e) {
      return null;
    }
  }

  /// Parses DateTime from map with a given key
  static DateTime? parseFromMap(Map<String, dynamic> map, String key) {
    if (!map.containsKey(key) || map[key] == null) {
      throw ArgumentError('Key "$key" not found or is null in map');
    }
    return parse(map[key]);
  }

  /// Safely parses DateTime from map, returns null if key not found or parsing fails
  static DateTime? tryParseFromMap(Map<String, dynamic> map, String key) {
    try {
      if (!map.containsKey(key) || map[key] == null) {
        return null;
      }
      return parse(map[key]);
    } catch (e) {
      return null;
    }
  }

  static int? calculateAge(DateTime dateTime) {
    final today = DateTime.now();
    int age = today.year - dateTime.year;
    if (today.month < dateTime.month ||
        (today.month == dateTime.month && today.day < dateTime.day)) {
      age--;
    }
    return age;
  }
}
