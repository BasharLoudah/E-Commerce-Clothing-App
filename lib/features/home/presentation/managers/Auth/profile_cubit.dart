// import 'package:bloc/bloc.dart';
// import 'package:e_commerece_app/features/home/data/data_source/auth_remote_data_source.dart';

// class ProfileCubit extends Cubit<ProfileState> {
//   final AuthRemoteDataSource _authRemoteDataSource;
//   ProfileCubit(this._authRemoteDataSource) : super(ProfileInitial());

//   Future<void> updateProfile(CreateAccountParams params, String token) async {
//     emit(ProfileLoading());
//     final response = await _authRemoteDataSource.register(params);
//     response.fold(
//       (error) {
//         emit(ProfileError(error));
//       },
//       (successMessage) {
//         emit(ProfileUpdated(successMessage));
//       },
//     );
//   }
// }

// abstract class ProfileState {}

// class ProfileInitial extends ProfileState {}

// class ProfileLoading extends ProfileState {}

// class ProfileUpdated extends ProfileState {
//   final String successMessage;
//   ProfileUpdated(this.successMessage);
// }

// class ProfileError extends ProfileState {
//   final String errorMessage;
//   ProfileError(this.errorMessage);
// }
