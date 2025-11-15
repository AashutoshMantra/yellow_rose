import 'dart:convert';

class BusCancellationChargeRule {
  final int? fromHours;
  final int? toHours;
  final double? rate;
  final bool? isPercentage;
  final String? uiMessage;
  BusCancellationChargeRule({
    this.fromHours,
    this.toHours,
    this.rate,
    this.isPercentage,
    this.uiMessage,
  });

  BusCancellationChargeRule copyWith({
    int? fromHours,
    int? toHours,
    double? rate,
    bool? isPercentage,
    String? uiMessage,
  }) {
    return BusCancellationChargeRule(
      fromHours: fromHours ?? this.fromHours,
      toHours: toHours ?? this.toHours,
      rate: rate ?? this.rate,
      isPercentage: isPercentage ?? this.isPercentage,
      uiMessage: uiMessage ?? this.uiMessage,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (fromHours != null) {
      result.addAll({'fromHours': fromHours});
    }
    if (toHours != null) {
      result.addAll({'toHours': toHours});
    }
    if (rate != null) {
      result.addAll({'rate': rate});
    }
    if (isPercentage != null) {
      result.addAll({'isPercentage': isPercentage});
    }
    if (uiMessage != null) {
      result.addAll({'uiMessage': uiMessage});
    }

    return result;
  }

  factory BusCancellationChargeRule.fromMap(Map<String, dynamic> map) {
    return BusCancellationChargeRule(
      fromHours: map['fromHours']?.toInt(),
      toHours: map['toHours']?.toInt(),
      rate: map['rate']?.toDouble(),
      isPercentage: map['isPercentage'],
      uiMessage: map['uiMessage'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BusCancellationChargeRule.fromJson(String source) =>
      BusCancellationChargeRule.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CancellationChargeRule(fromHours: $fromHours, toHours: $toHours, rate: $rate, isPercentage: $isPercentage, uiMessage: $uiMessage)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BusCancellationChargeRule &&
        other.fromHours == fromHours &&
        other.toHours == toHours &&
        other.rate == rate &&
        other.isPercentage == isPercentage &&
        other.uiMessage == uiMessage;
  }

  @override
  int get hashCode {
    return fromHours.hashCode ^
        toHours.hashCode ^
        rate.hashCode ^
        isPercentage.hashCode ^
        uiMessage.hashCode;
  }
}
