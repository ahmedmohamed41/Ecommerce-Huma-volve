import 'package:ecommerce_app_huma_volve/features/auth/login/domain/use_cases/login_use_case.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/presentation/view_model/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase _loginUseCase;
  LoginCubit(this._loginUseCase) : super(LoginInitial());

  void login({required String email, required String password}) async {
    emit(LoginLoading());
    final response = await _loginUseCase.call(email: email, password: password);
    response.fold(
      (failure) {
        emit(LoginError(failure.failureMessage));
      },
      (r) {
        emit(LoginSuccess(r));
      },
    );
  }
}
