import 'package:ecommerce_app_huma_volve/features/auth/sign_up/domain/entites/signup_re_entity.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/domain/use_cases/signup_use_case.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/presentation/view_model/signup_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupCubit extends Cubit<SignupState> {
  final SignupUseCase _signupUseCase;
  SignupCubit(this._signupUseCase) : super(SignupInitial());

  void signup(SignupReEntity signupReEntity) async {
    emit(SignupLoading());
    final response = await _signupUseCase.call(signupReEntity);
    response.fold(
      (failure) {
        emit(SignupError(failure.failureMessage));
      },
      (r) {
        emit(SignupSuccess(r));
      },
    );
  }
}
