import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/error/error_handler.dart';
import 'package:ecommerce_app_huma_volve/core/failure/failure.dart';
import 'package:ecommerce_app_huma_volve/core/storage/secure_storage.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/data/data_source/login_remote_data_source.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/domain/entites/login_entity.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/domain/repository/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  LoginRemoteDataSource loginRemoteDataSource;
  LoginRepositoryImpl(this.loginRemoteDataSource);
  @override
  Future<Either<Failure, LoginEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await loginRemoteDataSource.login(
        email: email,
        password: password,
      );
      await SecureStorage.saveAccessToken(response.accessToken);
      await SecureStorage.saveRefreshToken(response.refreshToken);
      return Right(response);
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }
}
