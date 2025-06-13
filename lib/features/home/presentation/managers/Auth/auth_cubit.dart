import 'package:e_commerece_app/features/home/data/data_source/auth_remote_data_source.dart';
import 'package:e_commerece_app/features/home/presentation/managers/Auth/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRemoteDataSource remote;

  AuthCubit({required this.remote}) : super(AuthState());

  Future<void> login(String phone, String password) async {
    emit(state.copyWith(isLoading: true, error: null));

    final response = await remote.login(phone, password);

    response.fold(
      (error) {
        emit(state.copyWith(isLoading: false, error: error));
      },
      (authData) {
        emit(state.copyWith(isLoading: false, authData: authData));
      },
    );
  }

  Future<void> logout() async {
    emit(state.copyWith(isLoading: true));
    final response = await remote.logout();

    response.fold(
      (error) {
        emit(state.copyWith(isLoading: false, error: error));
      },
      (success) async {
        if (success) {
          const storage = FlutterSecureStorage();
          await storage.delete(key: 'token');
          emit(state.copyWith(isLoading: false, authData: null));
        }
      },
    );
  }

  Future<void> register(CreateAccountParams params) async {
    emit(state.copyWith(isLoading: true));
    final response = await remote.register(params);

    response.fold(
      (error) {
        emit(state.copyWith(isLoading: false, error: error));
      },
      (data) {
        emit(state.copyWith(isLoading: false, authData: data));
      },
    );
  }
}
