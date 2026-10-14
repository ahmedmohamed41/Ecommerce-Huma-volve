import 'package:ecommerce_app_huma_volve/features/auth/sign_up/domain/entites/signup_entity.dart';

abstract class SignupState {}

class SignupInitial extends SignupState {}

class SignupSuccess extends SignupState {
  SignupEntity signup;
  SignupSuccess(this.signup);
}

class SignupLoading extends SignupState {}

class SignupError extends SignupState {
  final String errorMessage;
  SignupError(this.errorMessage);
}
