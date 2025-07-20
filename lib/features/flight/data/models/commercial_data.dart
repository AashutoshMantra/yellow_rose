import 'dart:convert';

class CommercialData {
    int? finalAmount;
    CommercialFee? fee;

    CommercialData({
        this.finalAmount,
        this.fee,
    });


  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(finalAmount != null){
      result.addAll({'finalAmount': finalAmount});
    }
    if(fee != null){
      result.addAll({'fee': fee!.toMap()});
    }
  
    return result;
  }

  factory CommercialData.fromMap(Map<String, dynamic> map) {
    return CommercialData(
      finalAmount: map['finalAmount']?.toInt(),
      fee: map['fee'] != null ? CommercialFee.fromMap(map['fee']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CommercialData.fromJson(String source) => CommercialData.fromMap(json.decode(source));
}

class CommercialFee {
    String? product;
    dynamic type;
    String? label;
    dynamic tag;
    InValue? inValue;
    dynamic currency;
    int? value;
    int? totalValue;
    List<Tax>? taxes;

    CommercialFee({
        this.product,
        this.type,
        this.label,
        this.tag,
        this.inValue,
        this.currency,
        this.value,
        this.totalValue,
        this.taxes,
    });


  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(product != null){
      result.addAll({'product': product});
    }
    result.addAll({'type': type});
    if(label != null){
      result.addAll({'label': label});
    }
    result.addAll({'tag': tag});
    if(inValue != null){
      result.addAll({'inValue': inValue!.toMap()});
    }
    result.addAll({'currency': currency});
    if(value != null){
      result.addAll({'value': value});
    }
    if(totalValue != null){
      result.addAll({'totalValue': totalValue});
    }
    if(taxes != null){
      result.addAll({'taxes': taxes!.map((x) => x?.toMap()).toList()});
    }
  
    return result;
  }

  factory CommercialFee.fromMap(Map<String, dynamic> map) {
    return CommercialFee(
      product: map['product'],
      type: map['type'] ?? null,
      label: map['label'],
      tag: map['tag'] ?? null,
      inValue: map['inValue'] != null ? InValue.fromMap(map['inValue']) : null,
      currency: map['currency'] ?? null,
      value: map['value']?.toInt(),
      totalValue: map['totalValue']?.toInt(),
      taxes: map['taxes'] != null ? List<Tax>.from(map['taxes']?.map((x) => Tax.fromMap(x))) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CommercialFee.fromJson(String source) => CommercialFee.fromMap(json.decode(source));
}

class InValue {
    int? perAdult;
    int? perChild;
    int? perInfant;
    int? totalValue;

    InValue({
        this.perAdult,
        this.perChild,
        this.perInfant,
        this.totalValue,
    });


  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(perAdult != null){
      result.addAll({'perAdult': perAdult});
    }
    if(perChild != null){
      result.addAll({'perChild': perChild});
    }
    if(perInfant != null){
      result.addAll({'perInfant': perInfant});
    }
    if(totalValue != null){
      result.addAll({'totalValue': totalValue});
    }
  
    return result;
  }

  factory InValue.fromMap(Map<String, dynamic> map) {
    return InValue(
      perAdult: map['perAdult']?.toInt(),
      perChild: map['perChild']?.toInt(),
      perInfant: map['perInfant']?.toInt(),
      totalValue: map['totalValue']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory InValue.fromJson(String source) => InValue.fromMap(json.decode(source));
}

class Tax {
    String? label;
    String? name;
    String? hsnCode;
    int? percent;
    dynamic currency;
    int? amount;

    Tax({
        this.label,
        this.name,
        this.hsnCode,
        this.percent,
        this.currency,
        this.amount,
    });


  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(label != null){
      result.addAll({'label': label});
    }
    if(name != null){
      result.addAll({'name': name});
    }
    if(hsnCode != null){
      result.addAll({'hsnCode': hsnCode});
    }
    if(percent != null){
      result.addAll({'percent': percent});
    }
    result.addAll({'currency': currency});
    if(amount != null){
      result.addAll({'amount': amount});
    }
  
    return result;
  }

  factory Tax.fromMap(Map<String, dynamic> map) {
    return Tax(
      label: map['label'],
      name: map['name'],
      hsnCode: map['hsnCode'],
      percent: map['percent']?.toInt(),
      currency: map['currency'] ?? null,
      amount: map['amount']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Tax.fromJson(String source) => Tax.fromMap(json.decode(source));
}
