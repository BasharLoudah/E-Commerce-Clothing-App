import 'package:image_picker/image_picker.dart';

class SignUpState {
  final String email;
  final String phone;
  final String password;
  final String passwordConfirmation;
  final String gender;
  final String type;
  final XFile? image;

  SignUpState({
    this.email = '',
    this.phone = '',
    this.password = '',
    this.passwordConfirmation = '',
    this.gender = '',
    this.type = '',
    this.image,
  });

  SignUpState copyWith({
    String? email,
    String? phone,
    String? password,
    String? passwordConfirmation,
    String? gender,
    String? type,
    XFile? image,
  }) {
    return SignUpState(
      email: email ?? this.email,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      passwordConfirmation: passwordConfirmation ?? this.passwordConfirmation,
      gender: gender ?? this.gender,
      type: type ?? this.type,
      image: image ?? this.image,
    );
  }
}

class SignUpInitial extends SignUpState {}

class SignUpSuccess extends SignUpState {}

class SignUpError extends SignUpState {
  final String errorMessage;

  SignUpError(this.errorMessage);
}
