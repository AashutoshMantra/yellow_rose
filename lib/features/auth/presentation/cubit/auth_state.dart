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
  final CorporatePolicyResponse corporatePolicies;
  final UserBookingProfile userBookingProfile;
  final List<UserBookingProfile> corporateProfiles;
  const Authenticated({
    required this.userDetails,
    required this.billingEntities,
    this.approvalWorkflow,
    this.corporatePolicies = const CorporatePolicyResponse(),
    required this.userBookingProfile,
    this.corporateProfiles = const [],
  });
  @override
  List<Object?> get props => [
        userDetails,
        billingEntities,
        approvalWorkflow,
        corporatePolicies,
        userBookingProfile,
        corporateProfiles,
      ];
}

class Unauthenticated extends AuthState {}
