import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/failure/failure.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/domain/entites/signup_entity.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/domain/entites/signup_re_entity.dart';

abstract class SignupRepository {
  Future<Either<Failure, SignupEntity>> signup(SignupReEntity signupReEntity);
}
