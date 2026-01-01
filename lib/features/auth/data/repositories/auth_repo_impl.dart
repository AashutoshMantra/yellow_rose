import 'package:hive_flutter/hive_flutter.dart';
import 'package:yellow_rose/dependncy_injection.dart';
import 'package:yellow_rose/features/auth/data/datasources/auth_service.dart';
import 'package:yellow_rose/features/auth/data/datasources/auth_local_service.dart';
import 'package:yellow_rose/features/auth/data/models/billing_entity.dart';
import 'package:yellow_rose/features/auth/data/models/policy/approval_workflow_request.dart';
import 'package:yellow_rose/features/auth/data/models/sign_in_request.dart';
import 'package:yellow_rose/features/auth/domain/entities/user_details.dart';
import 'package:yellow_rose/features/auth/domain/repositories/auth_repo.dart';

class AuthRepositoryImpl implements AuthRepository {
  final _authService = getIt<AuthService>();
  final _authLocalService = getIt<AuthLocalService>();

  @override
  Future signIn(SignInRequest signInRequest) async {
    var response = await _authService.signIn(signInRequest);
    _authLocalService.saveUserProfile(UserDetails.fromSignInResponse(response));
  }

  @override
  bool isLoggedIn() {
    return _authLocalService.isSignedIn();
  }

  @override
  UserDetails? getUserProfile() {
    return _authLocalService.getUserProfile();
  }

  @override
  Future<List<BillingEntity>> getBillingEntity(String uuid) async {
    return await _authService.getBillingEntity(uuid);
  }

  @override
  Future<void> signOut() async {
    try {
      _authLocalService.clearUserProfile();
    } catch (_) {}
  }

  @override
  Future<ApprovalWorkflow> getApprovalWorkflow() {
    return _authService.getApprovalWorkflow();
  }
}
