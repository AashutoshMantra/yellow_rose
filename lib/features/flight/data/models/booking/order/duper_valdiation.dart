import 'dart:convert';

class DupeValidation {
  bool validated = false;

  String action = "NA";
  DupeValidation({
    required this.validated,
    required this.action,
  });

  DupeValidation copyWith({
    bool? validated,
    String? action,
  }) {
    return DupeValidation(
      validated: validated ?? this.validated,
      action: action ?? this.action,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'validated': validated});
    result.addAll({'action': action});
  
    return result;
  }

  factory DupeValidation.fromMap(Map<String, dynamic> map) {
    return DupeValidation(
      validated: map['validated'] ?? false,
      action: map['action'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory DupeValidation.fromJson(String source) => DupeValidation.fromMap(json.decode(source));

  @override
  String toString() => 'DupeValidation(validated: $validated, action: $action)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is DupeValidation &&
      other.validated == validated &&
      other.action == action;
  }

  @override
  int get hashCode => validated.hashCode ^ action.hashCode;
}
