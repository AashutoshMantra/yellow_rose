import 'dart:convert';

class ExpediaHotelContentResponsePolicy {
  String? knowBeforeYouGo;
  ExpediaHotelContentResponsePolicy({
    this.knowBeforeYouGo,
  });

  ExpediaHotelContentResponsePolicy copyWith({
    String? knowBeforeYouGo,
  }) {
    return ExpediaHotelContentResponsePolicy(
      knowBeforeYouGo: knowBeforeYouGo ?? this.knowBeforeYouGo,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (knowBeforeYouGo != null) {
      result.addAll({'knowBeforeYouGo': knowBeforeYouGo});
    }

    return result;
  }

  factory ExpediaHotelContentResponsePolicy.fromMap(Map<String, dynamic> map) {
    return ExpediaHotelContentResponsePolicy(
      knowBeforeYouGo: map['know_before_you_go'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ExpediaHotelContentResponsePolicy.fromJson(String source) =>
      ExpediaHotelContentResponsePolicy.fromMap(json.decode(source));

  @override
  String toString() =>
      'ExpediaHotelContentResponsePolicy(knowBeforeYouGo: $knowBeforeYouGo)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ExpediaHotelContentResponsePolicy &&
        other.knowBeforeYouGo == knowBeforeYouGo;
  }

  @override
  int get hashCode => knowBeforeYouGo.hashCode;
}
