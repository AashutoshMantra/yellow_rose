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
  final bool isPersonalMode;
  const Authenticated({
    required this.userDetails,
    required this.billingEntities,
    this.approvalWorkflow,
    this.corporatePolicies = const CorporatePolicyResponse(),
    required this.userBookingProfile,
    this.corporateProfiles = const [],
    this.isPersonalMode = false,
  });

  Authenticated copyWith({
    List<UserBookingProfile>? corporateProfiles,
    bool? isPersonalMode,
  }) {
    return Authenticated(
      userDetails: userDetails,
      billingEntities: billingEntities,
      approvalWorkflow: approvalWorkflow,
      corporatePolicies: corporatePolicies,
      userBookingProfile: userBookingProfile,
      corporateProfiles: corporateProfiles ?? this.corporateProfiles,
      isPersonalMode: isPersonalMode ?? this.isPersonalMode,
    );
  }

  @override
  List<Object?> get props => [
        userDetails,
        billingEntities,
        approvalWorkflow,
        corporatePolicies,
        userBookingProfile,
        corporateProfiles,
        isPersonalMode,
      ];
}

class Unauthenticated extends AuthState {}
