part of 'sign_in_form_cubit.dart';

class SignInFormState extends Equatable {
  final String? userName;
  final String? password;
  final bool isSaving;
  final String? error;
  final bool showPassword;

  final bool isSaved;
  const SignInFormState({
    this.userName,
    this.password,
    this.isSaving=false,
    this.isSaved=false,
    this.error, 
    this.showPassword=false
  }
  );
 
  factory SignInFormState.initial(){
    return const SignInFormState();
  }

  @override
  List<Object?> get props => [userName,password,isSaving,isSaved,error,showPassword];

  SignInFormState copyWith({
    String? userName,
    String? password,
    bool? isSaving,
    String? error,
    bool? isSaved,
    bool? showPassword,
  }) {
    return SignInFormState(
      userName: userName ?? this.userName,
      password: password ?? this.password,
      isSaving: isSaving ?? this.isSaving,
      error: error ?? this.error,
      isSaved: isSaved ?? this.isSaved,
      showPassword:showPassword??this.showPassword
    );
  }
}

