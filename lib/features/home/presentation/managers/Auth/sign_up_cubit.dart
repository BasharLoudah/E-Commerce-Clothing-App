// import 'package:e_commerece_app/features/home/data/data_source/auth_remote_data_source.dart';
// import 'package:e_commerece_app/features/home/presentation/managers/Auth/profile_cubit.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:image_picker/image_picker.dart';
// import 'sign_up_state.dart';

// class SignUpCubit extends Cubit<SignUpState> {
//   final ProfileCubit profileCubit;
//   SignUpCubit({required this.profileCubit}) : super(SignUpInitial());

//   final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
//   final ImagePicker _picker = ImagePicker();

//   void updateEmail(String email) {
//     emit(state.copyWith(email: email));
//   }

//   void updatePhone(String phone) {
//     emit(state.copyWith(phone: phone));
//   }

//   void updatePassword(String password) {
//     emit(state.copyWith(password: password));
//   }

//   void updatePasswordConfirmation(String passwordConfirmation) {
//     emit(state.copyWith(passwordConfirmation: passwordConfirmation));
//   }

//   void selectGender(String gender) {
//     emit(state.copyWith(gender: gender));
//   }

//   void selectType(String type) {
//     emit(state.copyWith(type: type));
//   }

//   Future<void> pickImage() async {
//     final XFile? pickedImage =
//         await _picker.pickImage(source: ImageSource.gallery);
//     if (pickedImage != null) {
//       emit(state.copyWith(image: pickedImage));
//     } else {
//       emit(SignUpError("Image is required"));
//     }
//   }

//   Future<void> saveData(BuildContext context) async {
//     if (_validateForm()) {
//       await _secureStorage.write(key: 'email', value: state.email);
//       await _secureStorage.write(key: 'phone', value: state.phone);
//       await _secureStorage.write(key: 'password', value: state.password);

//       await _secureStorage.write(key: 'token', value: 'token saved');
//       print('secc');

//       emit(SignUpSuccess());

// //cash maneger

//       final params = UpdateProfileParams(
//         email: state.email,
//         phone: state.phone,
//         gender: state.gender,
//         image: state.image,
//         type: state.type,
//       );

//       final token = await _secureStorage.read(key: 'token');
//       print('Saved token: $token');

//       if (token != null) {
//         final profileCubit =
//             context.read<ProfileCubit>(); // Access ProfileCubit from context
//         await profileCubit.updateProfile(
//             params, token); // Pass the token to the ProfileCubit
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Token is missing')),
//         );
//       }
//     }
//   }

//   bool _validateForm() {
//     if (state.email.isEmpty ||
//         !RegExp(r'^[a-zA-Z]+-[a-zA-Z]+@[a-zA-Z]+\.(org)$')
//             .hasMatch(state.email)) {
//       emit(SignUpError("Invalid email format"));
//       return false;
//     }
//     if (state.phone.isEmpty || state.phone.length < 10) {
//       emit(SignUpError("Phone number must be at least 10 digits"));
//       return false;
//     }
//     if (state.password.isEmpty || state.password.length < 8) {
//       emit(SignUpError("Password must be at least 8 characters"));
//       return false;
//     }
//     if (state.passwordConfirmation.isEmpty ||
//         state.password != state.passwordConfirmation) {
//       emit(SignUpError("Passwords do not match"));
//       return false;
//     }
//     if (state.gender.isEmpty) {
//       emit(SignUpError("Gender is required"));
//       return false;
//     }
//     if (state.type.isEmpty) {
//       emit(SignUpError("Type is required"));
//       return false;
//     }
//     if (state.image == null) {
//       emit(SignUpError("Image is required"));
//       return false;
//     }
//     return true;
//   }
// }
