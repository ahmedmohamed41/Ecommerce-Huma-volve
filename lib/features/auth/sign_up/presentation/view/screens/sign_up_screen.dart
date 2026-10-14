import 'package:ecommerce_app_huma_volve/core/network/api_client.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/data/data_source/signup_remote_data_source.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/data/data_source/signup_remote_data_source_impl.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/data/models/signup_re_model.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/data/repository/signup_repository_impl.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/domain/repository/signup_repository.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/domain/use_cases/signup_use_case.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/presentation/view_model/signup_cubit.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/presentation/view_model/signup_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/widgets/custom_text_field.dart';
import '../../../../../../core/widgets/primary_button.dart';
import '../../../../../../core/theme.dart';
import '../../../../login/presentation/view/screens/login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final SignupCubit signupCubit;
  late final ApiClient apiClient;
  late final SignupUseCase _signupUseCase;
  late final SignupRepository signupRepository;
  late final SignupRemoteDataSource signupRemoteDataSource;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    apiClient = ApiClient();
    signupRemoteDataSource = SignupRemoteDataSourceImpl(apiClient);
    signupRepository = SignupRepositoryImpl(signupRemoteDataSource);
    _signupUseCase = SignupUseCase(signupRepository);
    signupCubit = SignupCubit(_signupUseCase);
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    signupCubit.close();
    super.dispose();
  }

  void _signup() {
    if (_formKey.currentState?.validate() ?? false) {
      signupCubit.signup(
        SignupReModel(
          name: nameController.text.trim(),
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: signupCubit,
      child: Scaffold(
        backgroundColor: AppTheme.background,
        body: SafeArea(
          child: BlocConsumer<SignupCubit, SignupState>(
            listener: (context, state) {
              if (state is SignupSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("SignUp Success"),
                    backgroundColor: Colors.blueGrey,
                  ),
                );
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              } else if (state is SignupError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.errorMessage),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            builder: (context, state) {
              final isLoading = state is SignupLoading;
              return SingleChildScrollView(
                padding: const EdgeInsets.all(32.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 40),
                      Icon(Icons.person_add, size: 80, color: AppTheme.primary),
                      const SizedBox(height: 32),
                      Text(
                        'Create Account',
                        style: Theme.of(context).textTheme.displayLarge
                            ?.copyWith(fontSize: 32),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Sign up to get started',
                        style: Theme.of(context).textTheme.bodyMedium
                            ?.copyWith(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 48),
                      CustomTextField(
                        controller: nameController,
                        hintText: 'Full Name',
                        prefixIcon: Icons.person_outline,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your full name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        controller: emailController,
                        hintText: 'Email Address',
                        prefixIcon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!value.contains('@')) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        controller: passwordController,
                        hintText: 'Password',
                        prefixIcon: Icons.lock_outline,
                        isPassword: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 40),
                      PrimaryButton(
                        text: 'Sign Up',
                        onPressed: _signup,
                        isLoading: isLoading,
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Already have an account? '),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (
                                    context,
                                    animation,
                                    secondaryAnimation,
                                  ) => const LoginScreen(),
                                  transitionsBuilder: (
                                    context,
                                    animation,
                                    secondaryAnimation,
                                    child,
                                  ) {
                                    return FadeTransition(
                                      opacity: animation,
                                      child: child,
                                    );
                                  },
                                ),
                              );
                            },
                            child: Text(
                              'Login',
                              style: TextStyle(
                                color: AppTheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}