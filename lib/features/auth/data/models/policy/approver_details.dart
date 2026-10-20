import 'dart:convert';

class ApproverDetails {
  final String? approverId;
  final String? approverName;

  ApproverDetails({
    this.approverId,
    this.approverName,
  });

  ApproverDetails copyWith({
    String? approverId,
    String? approverName,
  }) {
    return ApproverDetails(
      approverId: approverId ?? this.approverId,
      approverName: approverName ?? this.approverName,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (approverId != null) {
      result.addAll({'approverId': approverId});
    }
    if (approverName != null) {
      result.addAll({'approverName': approverName});
    }

    return result;
  }

  factory ApproverDetails.fromMap(Map<String, dynamic> map) {
    return ApproverDetails(
      approverId: map['approverId'],
      approverName: map['approverName'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ApproverDetails.fromJson(String source) =>
      ApproverDetails.fromMap(json.decode(source));

  @override
  String toString() =>
      'ApproverDetails(approverId: $approverId, approverName: $approverName)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ApproverDetails &&
        other.approverId == approverId &&
        other.approverName == approverName;
  }

  @override
  int get hashCode => approverId.hashCode ^ approverName.hashCode;
}
