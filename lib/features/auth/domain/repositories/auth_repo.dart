import 'package:yellow_rose/features/auth/data/models/billing_entity.dart';
import 'package:yellow_rose/features/auth/data/models/sign_in_request.dart';
import 'package:yellow_rose/features/auth/domain/entities/user_details.dart';

abstract interface class AuthRepository {
  Future signIn(SignInRequest signInRequest);
  bool isLoggedIn();
  UserDetails? getUserProfile();
  Future<List<BillingEntity>> getBillingEntity(String uuid);
}
