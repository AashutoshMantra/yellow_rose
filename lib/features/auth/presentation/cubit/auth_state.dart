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
  final UserBookingProfile userBookingProfile;
  final List<UserBookingProfile> corporateProfiles;
  const Authenticated({
    required this.userDetails,
    required this.billingEntities,
    this.approvalWorkflow,
    required this.userBookingProfile,
    this.corporateProfiles = const [],
  });
  @override
  List<Object?> get props => [userDetails, billingEntities, approvalWorkflow, userBookingProfile, corporateProfiles];
}

class Unauthenticated extends AuthState {}
