import 'package:e_commerece_app/features/home/data/models/auth_response_model.dart';

class AppManagerState {
  final AuthResponseModel? user;

  AppManagerState({this.user});

  AppManagerState copyWith({
    AuthResponseModel? user,
  }) {
    return AppManagerState(
      user: user ?? this.user,
    );
  }
}
