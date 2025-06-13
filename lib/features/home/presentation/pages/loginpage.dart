import 'package:e_commerece_app/features/home/data/data_source/auth_remote_data_source.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:e_commerece_app/features/home/presentation/managers/Auth/auth_cubit.dart';
import 'package:e_commerece_app/features/home/presentation/managers/Auth/auth_state.dart';
import 'package:e_commerece_app/core/common/app%20manager/app_manager_cubit.dart';
import 'package:e_commerece_app/core/routes/routes_paths.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    _checkToken();
  }

  Future<void> _checkToken() async {
    final token = await _storage.read(key: 'token');
    if (token != null) {
      // Token exists; verify and navigate to home if valid
      BlocProvider.of<AppManagerCubit>(context).initApp();
      context.go(RoutesPaths.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state.authData != null) {
            context.read<AppManagerCubit>().saveUserData(state.authData!);
            _storage.write(key: 'token', value: state.authData!.token);
            context.go(RoutesPaths.home);
          }
          if (state.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error!)),
            );
          }
        },
        child: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 40),
                    TextField(
                      controller: phoneController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.phone),
                        labelText: 'Phone',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state) {
                        if (state.authData != null) {
                          // Save user data to AppManagerCubit
                          BlocProvider.of<AppManagerCubit>(context)
                              .saveUserData(state.authData!);

                          // Save token in storage
                          const FlutterSecureStorage().write(
                            key: 'token',
                            value: state.authData!.token,
                          );

                          // Navigate to home
                          context.go(RoutesPaths.home);
                        }

                        if (state.error != null) {
                          // Show error message
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.error!)),
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state.isLoading) {
                          return const CircularProgressIndicator();
                        } else {
                          return ElevatedButton(
                            onPressed: () {
                              final phone = phoneController.text;
                              final password = passwordController.text;

                              BlocProvider.of<AuthCubit>(context).login(
                                phone,
                                password,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text('Confirm'),
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account? "),
                        TextButton(
                          onPressed: () {
                            context.go(RoutesPaths.signUp);
                          },
                          child: const Text('Sign Up'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
