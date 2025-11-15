import 'dart:convert';

class BusOperatorDetail {
  String? operatorId;
  String? operatorName;
  BusOperatorDetail({
    this.operatorId,
    this.operatorName,
  });

  BusOperatorDetail copyWith({
    String? operatorId,
    String? operatorName,
  }) {
    return BusOperatorDetail(
      operatorId: operatorId ?? this.operatorId,
      operatorName: operatorName ?? this.operatorName,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(operatorId != null){
      result.addAll({'operatorId': operatorId});
    }
    if(operatorName != null){
      result.addAll({'operatorName': operatorName});
    }
  
    return result;
  }

  factory BusOperatorDetail.fromMap(Map<String, dynamic> map) {
    return BusOperatorDetail(
      operatorId: map['operatorId'],
      operatorName: map['operatorName'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BusOperatorDetail.fromJson(String source) => BusOperatorDetail.fromMap(json.decode(source));

  @override
  String toString() => 'BusOperatorDetail(operatorId: $operatorId, operatorName: $operatorName)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is BusOperatorDetail &&
      other.operatorId == operatorId &&
      other.operatorName == operatorName;
  }

  @override
  int get hashCode => operatorId.hashCode ^ operatorName.hashCode;
}
