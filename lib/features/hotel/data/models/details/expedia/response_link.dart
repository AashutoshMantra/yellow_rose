import 'dart:convert';

class ExpediaResponseLink {
  final String? type;
  final String? method;
  final String? href;
  final String? expires;
  ExpediaResponseLink({
    this.type,
    this.method,
    this.href,
    this.expires,
  });

  ExpediaResponseLink copyWith({
    String? type,
    String? method,
    String? href,
    String? expires,
  }) {
    return ExpediaResponseLink(
      type: type ?? this.type,
      method: method ?? this.method,
      href: href ?? this.href,
      expires: expires ?? this.expires,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(type != null){
      result.addAll({'type': type});
    }
    if(method != null){
      result.addAll({'method': method});
    }
    if(href != null){
      result.addAll({'href': href});
    }
    if(expires != null){
      result.addAll({'expires': expires});
    }
  
    return result;
  }

  factory ExpediaResponseLink.fromMap(Map<String, dynamic> map) {
    return ExpediaResponseLink(
      type: map['type'],
      method: map['method'],
      href: map['href'],
      expires: map['expires'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ExpediaResponseLink.fromJson(String source) => ExpediaResponseLink.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ExpediaResponseLink(type: $type, method: $method, href: $href, expires: $expires)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ExpediaResponseLink &&
      other.type == type &&
      other.method == method &&
      other.href == href &&
      other.expires == expires;
  }

  @override
  int get hashCode {
    return type.hashCode ^
      method.hashCode ^
      href.hashCode ^
      expires.hashCode;
  }
}
