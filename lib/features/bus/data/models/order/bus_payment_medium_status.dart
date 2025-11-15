import 'dart:convert';

class BusPaymentMediumStatus {
  String? mediumName;
  bool? isBusinessEnabled;
  bool? isPersonalEnabled;
  BusPaymentMediumStatus({
    this.mediumName,
    this.isBusinessEnabled,
    this.isPersonalEnabled,
  });

  BusPaymentMediumStatus copyWith({
    String? mediumName,
    bool? isBusinessEnabled,
    bool? isPersonalEnabled,
  }) {
    return BusPaymentMediumStatus(
      mediumName: mediumName ?? this.mediumName,
      isBusinessEnabled: isBusinessEnabled ?? this.isBusinessEnabled,
      isPersonalEnabled: isPersonalEnabled ?? this.isPersonalEnabled,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(mediumName != null){
      result.addAll({'mediumName': mediumName});
    }
    if(isBusinessEnabled != null){
      result.addAll({'isBusinessEnabled': isBusinessEnabled});
    }
    if(isPersonalEnabled != null){
      result.addAll({'isPersonalEnabled': isPersonalEnabled});
    }
  
    return result;
  }

  factory BusPaymentMediumStatus.fromMap(Map<String, dynamic> map) {
    return BusPaymentMediumStatus(
      mediumName: map['mediumName'],
      isBusinessEnabled: map['isBusinessEnabled'],
      isPersonalEnabled: map['isPersonalEnabled'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BusPaymentMediumStatus.fromJson(String source) => BusPaymentMediumStatus.fromMap(json.decode(source));

  @override
  String toString() => 'BusPaymentMediumStatus(mediumName: $mediumName, isBusinessEnabled: $isBusinessEnabled, isPersonalEnabled: $isPersonalEnabled)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is BusPaymentMediumStatus &&
      other.mediumName == mediumName &&
      other.isBusinessEnabled == isBusinessEnabled &&
      other.isPersonalEnabled == isPersonalEnabled;
  }

  @override
  int get hashCode => mediumName.hashCode ^ isBusinessEnabled.hashCode ^ isPersonalEnabled.hashCode;
}
