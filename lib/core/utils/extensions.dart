import 'package:collection/collection.dart';

extension EnumParsing on String {
  T? toEnum<T>(List<T> enumValues) {
    return enumValues.firstWhereOrNull(
      (e) => e.toString().toLowerCase() == toLowerCase(),
    );
  }
}

extension DynamicEnumParsing on dynamic {
  T? toEnum<T>(List<T> enumValues) {
    if (this is String) {
      return (this as String?)?.toEnum(enumValues);
    }
    return null;
  }
}

T? stringToEnum<T>(dynamic value, List<T> enumValues) {
  if (value == null || value is! String) return null;
  return enumValues.firstWhereOrNull(
    (e) => (e as Enum).name.toString().toLowerCase() == value.toLowerCase(),
  );
}

extension StringExtension on String {
  String toTitleCase() {
    if (isEmpty) {
      return this;
    }
    return trim()
        .split(' ')
        .map((word) =>
            word.substring(0, 1).toUpperCase() +
            word.substring(1).toLowerCase())
        .join(' ');
  }
}

extension StringIgnoreCase on String {
  bool equalsIgnoreCase(String other) {
    return toLowerCase() == other.toLowerCase();
  }
}
