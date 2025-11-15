import 'dart:convert';

class BusDetailRequest {
  String requestId;
  int inventoryId;
  String doj;
  bool callFareBreakUpAPI = false;
  BusDetailRequest({
    required this.requestId,
    required this.inventoryId,
    required this.doj,
    required this.callFareBreakUpAPI,
  });

  BusDetailRequest copyWith({
    String? requestId,
    int? inventoryId,
    String? doj,
    bool? callFareBreakUpAPI,
  }) {
    return BusDetailRequest(
      requestId: requestId ?? this.requestId,
      inventoryId: inventoryId ?? this.inventoryId,
      doj: doj ?? this.doj,
      callFareBreakUpAPI: callFareBreakUpAPI ?? this.callFareBreakUpAPI,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'requestId': requestId});
    result.addAll({'inventoryId': inventoryId});
    result.addAll({'doj': doj});
    result.addAll({'callFareBreakUpAPI': callFareBreakUpAPI});

    return result;
  }

  factory BusDetailRequest.fromMap(Map<String, dynamic> map) {
    return BusDetailRequest(
      requestId: map['requestId'] ?? '',
      inventoryId: map['inventoryId']?.toInt() ?? 0,
      doj: map['doj'] ?? '',
      callFareBreakUpAPI: map['callFareBreakUpAPI'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory BusDetailRequest.fromJson(String source) =>
      BusDetailRequest.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BusDetailRequest(requestId: $requestId, inventoryId: $inventoryId, doj: $doj, callFareBreakUpAPI: $callFareBreakUpAPI)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BusDetailRequest &&
        other.requestId == requestId &&
        other.inventoryId == inventoryId &&
        other.doj == doj &&
        other.callFareBreakUpAPI == callFareBreakUpAPI;
  }

  @override
  int get hashCode {
    return requestId.hashCode ^
        inventoryId.hashCode ^
        doj.hashCode ^
        callFareBreakUpAPI.hashCode;
  }
}
