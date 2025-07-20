import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yellow_rose/dependncy_injection.dart';
import 'package:yellow_rose/features/auth/data/models/billing_entity.dart';
import 'package:yellow_rose/features/auth/domain/entities/user_details.dart';
import 'package:yellow_rose/features/auth/domain/usecases/auth_use_case.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  final _authUseCase = getIt<IAuthUseCase>();
  void appStarted() async {
    if (_authUseCase.isLoggedIn()) {
      UserDetails? userDetails = _authUseCase.getUserProfile();
      var enitty =
          await _authUseCase.getBillingEntity(userDetails?.userUid ?? '');
      if (userDetails != null) {
        emit(Authenticated(userDetails: userDetails, billingEntities: enitty));
      } else {
        emit(Unauthenticated());
      }
    } else {
      emit(Unauthenticated());
    }
  }
}
