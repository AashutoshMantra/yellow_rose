part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class Authenticated extends AuthState {
  final UserDetails userDetails;
  final List<BillingEntity> billingEntities;
  final ApprovalWorkflow? approvalWorkflow;
  const Authenticated({
    required this.userDetails,
    required this.billingEntities,
    this.approvalWorkflow,
  });
  @override
  List<Object?> get props => [userDetails, billingEntities, approvalWorkflow];
}

class Unauthenticated extends AuthState {}
