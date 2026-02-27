class CorporatePolicy {
  final String? product;
  final String? userType;
  final String? code;
  final dynamic value;

  const CorporatePolicy({
    this.product,
    this.userType,
    this.code,
    this.value,
  });

  factory CorporatePolicy.fromMap(Map<String, dynamic> map) {
    return CorporatePolicy(
      product: map['product'],
      userType: map['userType'],
      code: map['code'],
      value: map['value'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'product': product,
      'userType': userType,
      'code': code,
      'value': value,
    };
  }

  @override
  String toString() =>
      'CorporatePolicy(product: $product, userType: $userType, code: $code, value: $value)';
}

class CorporatePolicyResponse {
  final int? id;
  final String? userUid;
  final List<CorporatePolicy> policies;

  const CorporatePolicyResponse({
    this.id,
    this.userUid,
    this.policies = const [],
  });

  factory CorporatePolicyResponse.fromMap(Map<String, dynamic> map) {
    return CorporatePolicyResponse(
      id: map['id'],
      userUid: map['userUid'],
      policies: (map['policies'] as List<dynamic>?)
              ?.map((p) => CorporatePolicy.fromMap(p as Map<String, dynamic>))
              .toList() ??
          const [],
    );
  }

  static const empty = CorporatePolicyResponse();

  // ---------------------------------------------------------------------------
  // Generic policy lookup helpers
  // ---------------------------------------------------------------------------

  /// Finds the first policy matching [code] and optionally [product].
  /// Returns `null` if no match is found.
  CorporatePolicy? findPolicy(String code, {String? product}) {
    for (final policy in policies) {
      final codeMatch = policy.code == code;
      final productMatch = product == null || policy.product == product;
      if (codeMatch && productMatch) return policy;
    }
    return null;
  }

  T getPolicyValue<T>(String code, {String? product, required T defaultValue}) {
    final policy = findPolicy(code, product: product);
    if (policy?.value is T) return policy!.value as T;
    return defaultValue;
  }

  bool isBoolPolicyEnabled(String code,
      {String? product, bool defaultValue = false}) {
    return getPolicyValue<bool>(code,
        product: product, defaultValue: defaultValue);
  }

  // ---------------------------------------------------------------------------
  // Convenience: service enablement checks
  // ---------------------------------------------------------------------------

  /// Whether the given service [policyCode] is enabled.
  ///
  /// This is a generic check — for specific services use the named getters
  /// below, or pass the code from [SupportedService.policyCode].
  ///
  /// Defaults to `true` if no policy is found (fail-open for new services).
  bool isServiceEnabledByCode(String policyCode) {
    return isBoolPolicyEnabled(policyCode, defaultValue: true);
  }

  bool get isAirEnabled => isServiceEnabledByCode('enable-air');
  bool get isHotelEnabled => isServiceEnabledByCode('enable-hotel');
  bool get isBusEnabled => isServiceEnabledByCode('enable-bus');
  bool get isInsuranceEnabled => isServiceEnabledByCode('enable-insurance');

  @override
  String toString() =>
      'CorporatePolicyResponse(id: $id, userUid: $userUid, policies: ${policies.length})';
}
