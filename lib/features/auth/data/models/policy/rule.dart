import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:yellow_rose/features/auth/data/models/policy/condition_request.dart';
import 'package:yellow_rose/features/auth/data/models/policy/policy.dart';

class Rules {
  final List<ConditionRequest>? conditions;
  final List<Policy>? policies;
  Rules({
    this.conditions,
    this.policies,
  });

  Rules copyWith({
    List<ConditionRequest>? conditions,
    List<Policy>? policies,
  }) {
    return Rules(
      conditions: conditions ?? this.conditions,
      policies: policies ?? this.policies,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(conditions != null){
      result.addAll({'conditions': conditions!.map((x) => x?.toMap()).toList()});
    }
    if(policies != null){
      result.addAll({'policies': policies!.map((x) => x?.toMap()).toList()});
    }
  
    return result;
  }

  factory Rules.fromMap(Map<String, dynamic> map) {
    return Rules(
      conditions: map['conditions'] != null ? List<ConditionRequest>.from(map['conditions']?.map((x) => ConditionRequest.fromMap(x))) : null,
      policies: map['policies'] != null ? List<Policy>.from(map['policies']?.map((x) => Policy.fromMap(x))) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Rules.fromJson(String source) => Rules.fromMap(json.decode(source));

  @override
  String toString() => 'Rules(conditions: $conditions, policies: $policies)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Rules &&
      listEquals(other.conditions, conditions) &&
      listEquals(other.policies, policies);
  }

  @override
  int get hashCode => conditions.hashCode ^ policies.hashCode;
}
