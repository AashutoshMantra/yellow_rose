import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:yellow_rose/features/bus/data/models/search/bus_search_request.dart';
import 'package:yellow_rose/features/bus/data/models/search/bus_search_response.dart';

class BusSearchReqResPair {
  final BusSearchRequest? baseSearchRequest;
  final List<BusSearchResponse>? busSearchResponse;
  BusSearchReqResPair({
    this.baseSearchRequest,
    this.busSearchResponse,
  });

  BusSearchReqResPair copyWith({
    BusSearchRequest? baseSearchRequest,
    List<BusSearchResponse>? busSearchResponse,
  }) {
    return BusSearchReqResPair(
      baseSearchRequest: baseSearchRequest ?? this.baseSearchRequest,
      busSearchResponse: busSearchResponse ?? this.busSearchResponse,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (baseSearchRequest != null) {
      result.addAll({'baseSearchRequest': baseSearchRequest!.toMap()});
    }
    if (busSearchResponse != null) {
      result.addAll({
        'busSearchResponse': busSearchResponse!.map((x) => x.toMap()).toList()
      });
    }

    return result;
  }

  factory BusSearchReqResPair.fromMap(Map<String, dynamic> map) {
    return BusSearchReqResPair(
      baseSearchRequest: map['baseSearchRequest'] != null
          ? BusSearchRequest.fromMap(map['baseSearchRequest'])
          : null,
      busSearchResponse: map['busSearchResponse'] != null
          ? List<BusSearchResponse>.from(map['busSearchResponse']
              ?.map((x) => BusSearchResponse.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BusSearchReqResPair.fromJson(String source) =>
      BusSearchReqResPair.fromMap(json.decode(source));

  @override
  String toString() =>
      'BusSearchReqResPair(baseSearchRequest: $baseSearchRequest, busSearchResponse: $busSearchResponse)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BusSearchReqResPair &&
        other.baseSearchRequest == baseSearchRequest &&
        listEquals(other.busSearchResponse, busSearchResponse);
  }

  @override
  int get hashCode => baseSearchRequest.hashCode ^ busSearchResponse.hashCode;
}
