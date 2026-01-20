import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:yellow_rose/core/utils/extensions.dart';
import 'package:yellow_rose/features/auth/data/models/policy/approvers.dart';
import 'package:yellow_rose/features/auth/data/models/policy/condition_request.dart';
import 'package:yellow_rose/features/flight/data/models/product_type.dart';

class ApprovalWorkflow {
  final String? workFlowId;
  final String? workFlowName;
  final String? workFlowDesc;
  final String? status;
  final List<Approvers>? workflow;

  final String? createdBy;
  final String? corporateUserUid;
  final String? lastModifiedBy;
  final String? travelPolicyId;
  final String? product;
  final String? policyApplied;
  final int? priority;
  final bool? approvalAdmin;
  ApprovalWorkflow({
    this.workFlowId,
    this.workFlowName,
    this.workFlowDesc,
    this.status,
    this.workflow,
    this.createdBy,
    this.corporateUserUid,
    this.lastModifiedBy,
    this.travelPolicyId,
    this.product,
    this.policyApplied,
    this.priority,
    this.approvalAdmin,
  });

  ApprovalWorkflow copyWith({
    String? workFlowId,
    String? workFlowName,
    String? workFlowDesc,
    String? status,
    List<Approvers>? workflow,
    String? createdBy,
    String? corporateUserUid,
    String? lastModifiedBy,
    String? travelPolicyId,
    String? product,
    String? policyApplied,
    int? priority,
    bool? approvalAdmin,
  }) {
    return ApprovalWorkflow(
      workFlowId: workFlowId ?? this.workFlowId,
      workFlowName: workFlowName ?? this.workFlowName,
      workFlowDesc: workFlowDesc ?? this.workFlowDesc,
      status: status ?? this.status,
      workflow: workflow ?? this.workflow,
      createdBy: createdBy ?? this.createdBy,
      corporateUserUid: corporateUserUid ?? this.corporateUserUid,
      lastModifiedBy: lastModifiedBy ?? this.lastModifiedBy,
      travelPolicyId: travelPolicyId ?? this.travelPolicyId,
      product: product ?? this.product,
      policyApplied: policyApplied ?? this.policyApplied,
      priority: priority ?? this.priority,
      approvalAdmin: approvalAdmin ?? this.approvalAdmin,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(workFlowId != null){
      result.addAll({'workFlowId': workFlowId});
    }
    if(workFlowName != null){
      result.addAll({'workFlowName': workFlowName});
    }
    if(workFlowDesc != null){
      result.addAll({'workFlowDesc': workFlowDesc});
    }
    if(status != null){
      result.addAll({'status': status});
    }
    if(workflow != null){
      result.addAll({'workflow': workflow!.map((x) => x?.toMap()).toList()});
    }
    if(createdBy != null){
      result.addAll({'createdBy': createdBy});
    }
    if(corporateUserUid != null){
      result.addAll({'corporateUserUid': corporateUserUid});
    }
    if(lastModifiedBy != null){
      result.addAll({'lastModifiedBy': lastModifiedBy});
    }
    if(travelPolicyId != null){
      result.addAll({'travelPolicyId': travelPolicyId});
    }
    if(product != null){
      result.addAll({'product': product});
    }
    if(policyApplied != null){
      result.addAll({'policyApplied': policyApplied});
    }
    if(priority != null){
      result.addAll({'priority': priority});
    }
    if(approvalAdmin != null){
      result.addAll({'approvalAdmin': approvalAdmin});
    }
  
    return result;
  }

  factory ApprovalWorkflow.fromMap(Map<String, dynamic> map) {
    return ApprovalWorkflow(
      workFlowId: map['workFlowId'],
      workFlowName: map['workFlowName'],
      workFlowDesc: map['workFlowDesc'],
      status: map['status'],
      workflow: map['workflow'] != null ? List<Approvers>.from(map['workflow']?.map((x) => Approvers.fromMap(x))) : null,
      createdBy: map['createdBy'],
      corporateUserUid: map['corporateUserUid'],
      lastModifiedBy: map['lastModifiedBy'],
      travelPolicyId: map['travelPolicyId'],
      product: map['product'],
      policyApplied: map['policyApplied'],
      priority: map['priority']?.toInt(),
      approvalAdmin: map['approvalAdmin'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ApprovalWorkflow.fromJson(String source) =>
      ApprovalWorkflow.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ApprovalWorkflow(workFlowId: $workFlowId, workFlowName: $workFlowName, workFlowDesc: $workFlowDesc, status: $status, workflow: $workflow, createdBy: $createdBy, corporateUserUid: $corporateUserUid, lastModifiedBy: $lastModifiedBy, travelPolicyId: $travelPolicyId, product: $product, policyApplied: $policyApplied, priority: $priority, approvalAdmin: $approvalAdmin)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ApprovalWorkflow &&
      other.workFlowId == workFlowId &&
      other.workFlowName == workFlowName &&
      other.workFlowDesc == workFlowDesc &&
      other.status == status &&
      listEquals(other.workflow, workflow) &&
      other.createdBy == createdBy &&
      other.corporateUserUid == corporateUserUid &&
      other.lastModifiedBy == lastModifiedBy &&
      other.travelPolicyId == travelPolicyId &&
      other.product == product &&
      other.policyApplied == policyApplied &&
      other.priority == priority &&
      other.approvalAdmin == approvalAdmin;
  }

  @override
  int get hashCode {
    return workFlowId.hashCode ^
      workFlowName.hashCode ^
      workFlowDesc.hashCode ^
      status.hashCode ^
      workflow.hashCode ^
      createdBy.hashCode ^
      corporateUserUid.hashCode ^
      lastModifiedBy.hashCode ^
      travelPolicyId.hashCode ^
      product.hashCode ^
      policyApplied.hashCode ^
      priority.hashCode ^
      approvalAdmin.hashCode;
  }
}
