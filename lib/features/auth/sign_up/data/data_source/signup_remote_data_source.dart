import 'package:ecommerce_app_huma_volve/features/auth/sign_up/data/models/signup_model.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/data/models/signup_re_model.dart';

abstract class SignupRemoteDataSource {
  Future<SignUpModel> signup(SignupReModel signupReModel);
}
