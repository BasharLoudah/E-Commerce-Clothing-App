// import 'package:e_commerece_app/features/home/data/data_source/auth_remote_data_source.dart';

// import 'package:e_commerece_app/features/home/presentation/managers/login_state.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class LoginCubit extends Cubit<LoginState> {
//   LoginCubit() : super(LoginState());
//   final AuthRemoteDataSource authRemoteDataSource = AuthRemoteDataSource();

//   Future<void> login(String email, String password) async {
//     emit(state.copyWith(isLoading: true));
//     final result = await authRemoteDataSource
//         .login(LoginauthParams(email: email, password: password));

//     result.fold((failure) {
//       emit(state.copyWith(isLoading: false, error: failure));
//     }, (user) {
//       emit(state.copyWith(isLoading: false, user: user));
//     });
//   }
// }
