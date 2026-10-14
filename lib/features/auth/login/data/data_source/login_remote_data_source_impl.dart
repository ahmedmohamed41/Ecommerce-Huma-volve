import 'package:ecommerce_app_huma_volve/core/constant/api_endpoint.dart';
import 'package:ecommerce_app_huma_volve/core/network/api_client.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/data/data_source/login_remote_data_source.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/data/models/login_model.dart';

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final ApiClient apiClient;
  LoginRemoteDataSourceImpl(this.apiClient);
  @override
  Future<LoginModel> login({
    required String email,
    required String password,
  }) async {
    final response = await apiClient.dio.post(
      ApiEndpoint.loginEndPoint,
      data: {"email": email, "password": password},
    );
    final Map<String, dynamic> json = response.data;
    final modelData = LoginModel.fromJson(json);
    return modelData;
  }
}
