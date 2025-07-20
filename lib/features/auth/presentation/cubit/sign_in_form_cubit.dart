import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yellow_rose/dependncy_injection.dart';
import 'package:yellow_rose/features/auth/data/models/sign_in_request.dart';
import 'package:yellow_rose/features/auth/domain/usecases/auth_use_case.dart';

part 'sign_in_form_state.dart';

class SignInFormCubit extends Cubit<SignInFormState> {
  SignInFormCubit() : super(SignInFormState.initial());
  final _authUseCase = getIt<IAuthUseCase>();
  onEmailChange(String? email) {
    emit(state.copyWith(userName: email));
  }

  onPasswordChange(String? password) {
    emit(state.copyWith(password: password));
  }

  toggleShowPasswordChange() {
    emit(state.copyWith(showPassword: !state.showPassword));
  }

  Future<void> signIn() async {
    try {
      var signInRequest =
          SignInRequest(username: state.userName!, password: state.password!);
      await _authUseCase.signIn(signInRequest);
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
      rethrow;
    }
  }
}
