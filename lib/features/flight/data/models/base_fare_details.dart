import 'dart:convert';

class BaseFareDetails {
 final double baseFare;
    final double finalTax;
    final Map<String, Object>? miscellaneousData;
    final Map<String, List<double>>? taxes;
  BaseFareDetails({
    required this.baseFare,
    required this.finalTax,
    this.miscellaneousData,
    this.taxes,
  });


  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'baseFare': baseFare});
    result.addAll({'finalTax': finalTax});
    if(miscellaneousData != null){
      result.addAll({'miscellaneousData': miscellaneousData});
    }
    if(taxes != null){
      result.addAll({'taxes': taxes});
    }
  
    return result;
  }

  factory BaseFareDetails.fromMap(Map<String, dynamic> map) {
    return BaseFareDetails(
      baseFare: map['baseFare']?.toDouble() ?? 0.0,
      finalTax: map['finalTax']?.toDouble() ?? 0.0,
      miscellaneousData:map['miscellaneousData']!=null? Map<String, Object>.from(map['miscellaneousData']):null,
      taxes:map['taxes'] != null
        ? (map['taxes'] as Map).map<String, List<double>>(
            (key, value) => MapEntry(
              key.toString(), // Ensure key is a String
              (value as List).map((e) => (e as num).toDouble()).toList(),
            ),
          )
        : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BaseFareDetails.fromJson(String source) => BaseFareDetails.fromMap(json.decode(source));
}
