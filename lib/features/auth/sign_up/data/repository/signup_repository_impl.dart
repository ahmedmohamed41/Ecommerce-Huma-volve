import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/error/error_handler.dart';
import 'package:ecommerce_app_huma_volve/core/failure/failure.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/data/data_source/signup_remote_data_source.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/data/models/signup_re_model.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/domain/entites/signup_entity.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/domain/entites/signup_re_entity.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/domain/repository/signup_repository.dart';

class SignupRepositoryImpl implements SignupRepository {
  SignupRemoteDataSource signupRemoteDataSource;
  SignupRepositoryImpl(this.signupRemoteDataSource);

  @override
  Future<Either<Failure, SignupEntity>> signup(
    SignupReEntity signupReEntity,
  ) async {
    try {
      final response = await signupRemoteDataSource.signup(
        signupReEntity as SignupReModel,
      );

      return Right(response);
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }
}
