import 'dart:convert';

import 'package:flutter/foundation.dart';

class BusErrorResponse {
  int? status;
  String? message;
  Map<String, dynamic>? errors;
  BusErrorResponse({
    this.status,
    this.message,
    this.errors,
  });

  BusErrorResponse copyWith({
    int? status,
    String? message,
    Map<String, dynamic>? errors,
  }) {
    return BusErrorResponse(
      status: status ?? this.status,
      message: message ?? this.message,
      errors: errors ?? this.errors,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(status != null){
      result.addAll({'status': status});
    }
    if(message != null){
      result.addAll({'message': message});
    }
    if(errors != null){
      result.addAll({'errors': errors});
    }
  
    return result;
  }

  factory BusErrorResponse.fromMap(Map<String, dynamic> map) {
    return BusErrorResponse(
      status: map['status']?.toInt(),
      message: map['message'],
      errors: Map<String, dynamic>.from(map['errors']),
    );
  }

  String toJson() => json.encode(toMap());

  factory BusErrorResponse.fromJson(String source) => BusErrorResponse.fromMap(json.decode(source));

  @override
  String toString() => 'BusErrorResponse(status: $status, message: $message, errors: $errors)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is BusErrorResponse &&
      other.status == status &&
      other.message == message &&
      mapEquals(other.errors, errors);
  }

  @override
  int get hashCode => status.hashCode ^ message.hashCode ^ errors.hashCode;
}
