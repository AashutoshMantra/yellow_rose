import 'dart:convert';

class ExpediaHotelContentResponseLink {
  final String? id;
  final String? method;
  final String? href;
  final String? expires;
  ExpediaHotelContentResponseLink({
    this.id,
    this.method,
    this.href,
    this.expires,
  });

  ExpediaHotelContentResponseLink copyWith({
    String? id,
    String? method,
    String? href,
    String? expires,
  }) {
    return ExpediaHotelContentResponseLink(
      id: id ?? this.id,
      method: method ?? this.method,
      href: href ?? this.href,
      expires: expires ?? this.expires,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (method != null) {
      result.addAll({'method': method});
    }
    if (href != null) {
      result.addAll({'href': href});
    }
    if (expires != null) {
      result.addAll({'expires': expires});
    }

    return result;
  }

  factory ExpediaHotelContentResponseLink.fromMap(Map<String, dynamic> map) {
    return ExpediaHotelContentResponseLink(
      id: map['id'],
      method: map['method'],
      href: map['href'],
      expires: map['expires'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ExpediaHotelContentResponseLink.fromJson(String source) =>
      ExpediaHotelContentResponseLink.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ExpediaHotelContentResponseLink(id: $id, method: $method, href: $href, expires: $expires)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ExpediaHotelContentResponseLink &&
        other.id == id &&
        other.method == method &&
        other.href == href &&
        other.expires == expires;
  }

  @override
  int get hashCode {
    return id.hashCode ^ method.hashCode ^ href.hashCode ^ expires.hashCode;
  }
}
