import 'package:ecommerce_app_huma_volve/features/auth/login/domain/entites/login_entity.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginSuccess extends LoginState {
  LoginEntity login;
  LoginSuccess(this.login);
}

class LoginLoading extends LoginState {}

class LoginError extends LoginState {
  final String errorMessage;
  LoginError(this.errorMessage);
}
