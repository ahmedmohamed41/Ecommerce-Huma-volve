import 'package:ecommerce_app_huma_volve/features/auth/login/data/models/login_model.dart';

abstract class LoginRemoteDataSource {
  Future<LoginModel> login({required String email, required String password});
}
