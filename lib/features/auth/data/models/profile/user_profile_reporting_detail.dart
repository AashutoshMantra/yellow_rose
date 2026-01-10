import 'dart:convert';

class UserProfileReportingDetails {
  final int? id;

  final String? sapCode;

  final String? fareOption1;

  final String? fareOption2;

  final String? fareOption3;

  final String? reference;

  final String? ioPidNo;

  final String? indentDocNo;

  final String? bookedBy;

  final String? cod1;

  final String? cod2;

  final String? cod3;

  final String? reasonForTravel;

  final String? missedSavings;

  final String? globalId;

  final String? fareType;

  final String? fareRestriction;

  final String? cfoApprovalLessThan7Days;

  final String? billability;
  UserProfileReportingDetails({
    this.id,
    this.sapCode,
    this.fareOption1,
    this.fareOption2,
    this.fareOption3,
    this.reference,
    this.ioPidNo,
    this.indentDocNo,
    this.bookedBy,
    this.cod1,
    this.cod2,
    this.cod3,
    this.reasonForTravel,
    this.missedSavings,
    this.globalId,
    this.fareType,
    this.fareRestriction,
    this.cfoApprovalLessThan7Days,
    this.billability,
  });

  UserProfileReportingDetails copyWith({
    int? id,
    String? sapCode,
    String? fareOption1,
    String? fareOption2,
    String? fareOption3,
    String? reference,
    String? ioPidNo,
    String? indentDocNo,
    String? bookedBy,
    String? cod1,
    String? cod2,
    String? cod3,
    String? reasonForTravel,
    String? missedSavings,
    String? globalId,
    String? fareType,
    String? fareRestriction,
    String? cfoApprovalLessThan7Days,
    String? billability,
  }) {
    return UserProfileReportingDetails(
      id: id ?? this.id,
      sapCode: sapCode ?? this.sapCode,
      fareOption1: fareOption1 ?? this.fareOption1,
      fareOption2: fareOption2 ?? this.fareOption2,
      fareOption3: fareOption3 ?? this.fareOption3,
      reference: reference ?? this.reference,
      ioPidNo: ioPidNo ?? this.ioPidNo,
      indentDocNo: indentDocNo ?? this.indentDocNo,
      bookedBy: bookedBy ?? this.bookedBy,
      cod1: cod1 ?? this.cod1,
      cod2: cod2 ?? this.cod2,
      cod3: cod3 ?? this.cod3,
      reasonForTravel: reasonForTravel ?? this.reasonForTravel,
      missedSavings: missedSavings ?? this.missedSavings,
      globalId: globalId ?? this.globalId,
      fareType: fareType ?? this.fareType,
      fareRestriction: fareRestriction ?? this.fareRestriction,
      cfoApprovalLessThan7Days: cfoApprovalLessThan7Days ?? this.cfoApprovalLessThan7Days,
      billability: billability ?? this.billability,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(id != null){
      result.addAll({'id': id});
    }
    if(sapCode != null){
      result.addAll({'sapCode': sapCode});
    }
    if(fareOption1 != null){
      result.addAll({'fareOption1': fareOption1});
    }
    if(fareOption2 != null){
      result.addAll({'fareOption2': fareOption2});
    }
    if(fareOption3 != null){
      result.addAll({'fareOption3': fareOption3});
    }
    if(reference != null){
      result.addAll({'reference': reference});
    }
    if(ioPidNo != null){
      result.addAll({'ioPidNo': ioPidNo});
    }
    if(indentDocNo != null){
      result.addAll({'indentDocNo': indentDocNo});
    }
    if(bookedBy != null){
      result.addAll({'bookedBy': bookedBy});
    }
    if(cod1 != null){
      result.addAll({'cod1': cod1});
    }
    if(cod2 != null){
      result.addAll({'cod2': cod2});
    }
    if(cod3 != null){
      result.addAll({'cod3': cod3});
    }
    if(reasonForTravel != null){
      result.addAll({'reasonForTravel': reasonForTravel});
    }
    if(missedSavings != null){
      result.addAll({'missedSavings': missedSavings});
    }
    if(globalId != null){
      result.addAll({'globalId': globalId});
    }
    if(fareType != null){
      result.addAll({'fareType': fareType});
    }
    if(fareRestriction != null){
      result.addAll({'fareRestriction': fareRestriction});
    }
    if(cfoApprovalLessThan7Days != null){
      result.addAll({'cfoApprovalLessThan7Days': cfoApprovalLessThan7Days});
    }
    if(billability != null){
      result.addAll({'billability': billability});
    }
  
    return result;
  }

  factory UserProfileReportingDetails.fromMap(Map<String, dynamic> map) {
    return UserProfileReportingDetails(
      id: map['id']?.toInt(),
      sapCode: map['sapCode'],
      fareOption1: map['fareOption1'],
      fareOption2: map['fareOption2'],
      fareOption3: map['fareOption3'],
      reference: map['reference'],
      ioPidNo: map['ioPidNo'],
      indentDocNo: map['indentDocNo'],
      bookedBy: map['bookedBy'],
      cod1: map['cod1'],
      cod2: map['cod2'],
      cod3: map['cod3'],
      reasonForTravel: map['reasonForTravel'],
      missedSavings: map['missedSavings'],
      globalId: map['globalId'],
      fareType: map['fareType'],
      fareRestriction: map['fareRestriction'],
      cfoApprovalLessThan7Days: map['cfoApprovalLessThan7Days'],
      billability: map['billability'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserProfileReportingDetails.fromJson(String source) => UserProfileReportingDetails.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserProfileReportingDetails(id: $id, sapCode: $sapCode, fareOption1: $fareOption1, fareOption2: $fareOption2, fareOption3: $fareOption3, reference: $reference, ioPidNo: $ioPidNo, indentDocNo: $indentDocNo, bookedBy: $bookedBy, cod1: $cod1, cod2: $cod2, cod3: $cod3, reasonForTravel: $reasonForTravel, missedSavings: $missedSavings, globalId: $globalId, fareType: $fareType, fareRestriction: $fareRestriction, cfoApprovalLessThan7Days: $cfoApprovalLessThan7Days, billability: $billability)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is UserProfileReportingDetails &&
      other.id == id &&
      other.sapCode == sapCode &&
      other.fareOption1 == fareOption1 &&
      other.fareOption2 == fareOption2 &&
      other.fareOption3 == fareOption3 &&
      other.reference == reference &&
      other.ioPidNo == ioPidNo &&
      other.indentDocNo == indentDocNo &&
      other.bookedBy == bookedBy &&
      other.cod1 == cod1 &&
      other.cod2 == cod2 &&
      other.cod3 == cod3 &&
      other.reasonForTravel == reasonForTravel &&
      other.missedSavings == missedSavings &&
      other.globalId == globalId &&
      other.fareType == fareType &&
      other.fareRestriction == fareRestriction &&
      other.cfoApprovalLessThan7Days == cfoApprovalLessThan7Days &&
      other.billability == billability;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      sapCode.hashCode ^
      fareOption1.hashCode ^
      fareOption2.hashCode ^
      fareOption3.hashCode ^
      reference.hashCode ^
      ioPidNo.hashCode ^
      indentDocNo.hashCode ^
      bookedBy.hashCode ^
      cod1.hashCode ^
      cod2.hashCode ^
      cod3.hashCode ^
      reasonForTravel.hashCode ^
      missedSavings.hashCode ^
      globalId.hashCode ^
      fareType.hashCode ^
      fareRestriction.hashCode ^
      cfoApprovalLessThan7Days.hashCode ^
      billability.hashCode;
  }
}
