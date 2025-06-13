import 'package:e_commerece_app/core/common/models/user_model.dart';
import 'dart:convert';

AuthResponseModel authResponseModelFromJson(String str) =>
    AuthResponseModel.fromJson(json.decode(str));

String authResponseModelToJson(AuthResponseModel data) =>
    json.encode(data.toJson());

class AuthResponseModel {
  final String token;
  final String role;
  final UserModel user;

  AuthResponseModel({
    required this.token,
    required this.role,
    required this.user,
  });

  get userableId => null;

  AuthResponseModel copyWith({
    String? token,
    String? role,
    UserModel? user,
  }) =>
      AuthResponseModel(
        token: token ?? this.token,
        role: role ?? this.role,
        user: user ?? this.user,
      );

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) =>
      AuthResponseModel(
        token: json["token"],
        role: json["role"],
        user: UserModel.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "role": role,
        "user": user.toJson(),
      };
}
