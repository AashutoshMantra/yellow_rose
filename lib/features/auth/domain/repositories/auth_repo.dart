import 'package:yellow_rose/features/auth/data/models/billing_entity.dart';
import 'package:yellow_rose/features/auth/data/models/policy/approval_workflow_request.dart';
import 'package:yellow_rose/features/auth/data/models/profile/user_booking_profile.dart';
import 'package:yellow_rose/features/auth/data/models/sign_in_request.dart';
import 'package:yellow_rose/features/auth/domain/entities/user_details.dart';

abstract interface class AuthRepository {
  Future signIn(SignInRequest signInRequest);
  bool isLoggedIn();
  UserDetails? getUserDetail();
  Future<void> signOut();
  Future<List<BillingEntity>> getBillingEntity(String uuid);
  Future<ApprovalWorkflow> getApprovalWorkflow();
  Future<UserBookingProfile> getUserProfile();
  Future<List<UserBookingProfile>> getAllCorporateProfile();
  Future<List<UserBookingProfile>> getGroupByCorporateUserProfiles();
}
