import 'package:yellow_rose/dependncy_injection.dart';
import 'package:yellow_rose/features/auth/data/models/billing_entity.dart';
import 'package:yellow_rose/features/auth/data/models/sign_in_request.dart';
import 'package:yellow_rose/features/auth/domain/entities/user_details.dart';
import 'package:yellow_rose/features/auth/domain/repositories/auth_repo.dart';
import 'package:yellow_rose/features/home_screen/domain/usecases/recent_search_usecase.dart';

abstract class IAuthUseCase {
  Future signIn(SignInRequest signInRequest);
  bool isLoggedIn();
  UserDetails? getUserProfile();
  Future<List<BillingEntity>> getBillingEntity(String uuid);
  Future<void> signOut();
}

class AuthUseCase implements IAuthUseCase {
  final _authRepo = getIt<AuthRepository>();
  final _recentSearchUsecase = getIt<RecentSearchUseCase>();

  @override
  bool isLoggedIn() {
    return _authRepo.isLoggedIn();
  }

  @override
  Future signIn(SignInRequest signInRequest) async {
    return await _authRepo.signIn(signInRequest);
  }

  @override
  UserDetails? getUserProfile() {
    return getIt<AuthRepository>().getUserProfile();
  }

  @override
  Future<List<BillingEntity>> getBillingEntity(String uuid) async {
    return await _authRepo.getBillingEntity(uuid);
  }

  @override
  Future<void> signOut() async {
    await _recentSearchUsecase.saveAirRecentSearches([]);
    await _recentSearchUsecase.saveHotelRecentSearches([]);
    return await _authRepo.signOut();
  }
}
