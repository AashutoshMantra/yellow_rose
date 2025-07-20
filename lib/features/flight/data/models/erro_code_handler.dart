import 'dart:convert';

import 'package:yellow_rose/core/utils/extensions.dart';
import 'package:yellow_rose/features/flight/data/models/error_source.dart';
import 'package:yellow_rose/features/flight/data/models/product_type.dart';

class ErrorCodeHandler {
  final ProductTypeEnum? product;
  final String? statusCode;
  final ErrorSourceEnum? errorSource;
  final String? errorCode;
  final Object? errorData;
  ErrorCodeHandler({
    this.product,
    this.statusCode,
    this.errorSource,
    this.errorCode,
    this.errorData,
  });

  ErrorCodeHandler copyWith({
    ProductTypeEnum? product,
    String? statusCode,
    ErrorSourceEnum? errorSource,
    String? errorCode,
    Object? errorData,
  }) {
    return ErrorCodeHandler(
      product: product ?? this.product,
      statusCode: statusCode ?? this.statusCode,
      errorSource: errorSource ?? this.errorSource,
      errorCode: errorCode ?? this.errorCode,
      errorData: errorData ?? this.errorData,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (product != null) {
      result.addAll({'product': product!.name});
    }
    if (statusCode != null) {
      result.addAll({'statusCode': statusCode});
    }
    if (errorSource != null) {
      result.addAll({'errorSource': errorSource!.name});
    }
    if (errorCode != null) {
      result.addAll({'errorCode': errorCode});
    }
    if (errorData != null) {
      result.addAll({'errorData': jsonEncode(errorData)});
    }

    return result;
  }

  factory ErrorCodeHandler.fromMap(Map<String, dynamic> map) {
    return ErrorCodeHandler(
      product: (map['product'] as String?)?.toEnum(ProductTypeEnum.values),
      statusCode: map['statusCode'],
      errorSource:
          (map['errorSource'] as String?)?.toEnum(ErrorSourceEnum.values),
      errorCode: map['errorCode'],
      errorData: map['errorData'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ErrorCodeHandler.fromJson(String source) =>
      ErrorCodeHandler.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ErrorCodeHandler(product: $product, statusCode: $statusCode, errorSource: $errorSource, errorCode: $errorCode, errorData: $errorData)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ErrorCodeHandler &&
        other.product == product &&
        other.statusCode == statusCode &&
        other.errorSource == errorSource &&
        other.errorCode == errorCode &&
        other.errorData == errorData;
  }

  @override
  int get hashCode {
    return product.hashCode ^
        statusCode.hashCode ^
        errorSource.hashCode ^
        errorCode.hashCode ^
        errorData.hashCode;
  }
}
