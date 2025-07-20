import 'dart:convert';

class RouteRequest {
  final String url;
  final String supplier;
  final String? source;
  final List<String> carriers;
  RouteRequest({
    required this.url,
    required this.supplier,
    this.source,
    required this.carriers,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'url': url});
    result.addAll({'supplier': supplier});
    if (source != null) {
      result.addAll({'source': source});
    }
    result.addAll({'carriers': carriers});

    return result;
  }

  factory RouteRequest.fromMap(Map<String, dynamic> map) {
    return RouteRequest(
      url: map['url'] ?? '',
      supplier: map['supplier'] ?? '',
      source: map['source'],
      carriers:
          map['carriers'] != null ? List<String>.from(map['carriers']) : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory RouteRequest.fromJson(String source) =>
      RouteRequest.fromMap(json.decode(source));
}
