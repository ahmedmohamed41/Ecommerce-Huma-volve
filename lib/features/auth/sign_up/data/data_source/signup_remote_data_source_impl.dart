import 'package:ecommerce_app_huma_volve/core/constant/api_endpoint.dart';
import 'package:ecommerce_app_huma_volve/core/network/api_client.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/data/data_source/signup_remote_data_source.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/data/models/signup_model.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/data/models/signup_re_model.dart';

class SignupRemoteDataSourceImpl implements SignupRemoteDataSource {
  final ApiClient apiClient;
  SignupRemoteDataSourceImpl(this.apiClient);
  @override
  Future<SignUpModel> signup(SignupReModel signupReModel) async {
    final response = await apiClient.dio.post(
      ApiEndpoint.signUpEndPoint,
      data: {
        "email": signupReModel.email,
        "password": signupReModel.password,
        "avatar":
            "https://avatarfiles.alphacoders.com/368/thumb-150-368375.png",
        "name": signupReModel.name,
      },
    );
    final Map<String, dynamic> json = response.data;
    final modelData = SignUpModel.fromJson(json);

    return modelData;
  }
}
