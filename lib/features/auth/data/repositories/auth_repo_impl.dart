import 'package:hive_flutter/hive_flutter.dart';
import 'package:yellow_rose/dependncy_injection.dart';
import 'package:yellow_rose/features/auth/data/datasources/auth_service.dart';
import 'package:yellow_rose/features/auth/data/datasources/auth_local_service.dart';
import 'package:yellow_rose/features/auth/data/models/billing_entity.dart';
import 'package:yellow_rose/features/auth/data/models/sign_in_request.dart';
import 'package:yellow_rose/features/auth/domain/entities/user_details.dart';
import 'package:yellow_rose/features/auth/domain/repositories/auth_repo.dart';

class AuthRepositoryImpl implements AuthRepository {
  final _authService = getIt<AuthService>();
  final _authLocalService = getIt<AuthLocalService>();
  final Box airportBox = Hive.box('userProfile');

  @override
  Future signIn(SignInRequest signInRequest) async {
    var response = await _authService.signIn(signInRequest);
    await airportBox.put('profile', response.toJson());
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
      // Clear local storage for profile
      await airportBox.clear();
    } catch (_) {}
  }
}
