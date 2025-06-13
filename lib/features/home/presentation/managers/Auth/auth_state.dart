import 'package:e_commerece_app/features/home/data/models/auth_response_model.dart';

class AuthState {
  final bool isLoading;
  final String? error;
  final AuthResponseModel? authData;

  AuthState({
    this.isLoading = false,
    this.error,
    this.authData,
  });

  AuthState copyWith({
    bool? isLoading,
    String? error,
    AuthResponseModel? authData,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      authData: authData ?? this.authData,
    );
  }
}