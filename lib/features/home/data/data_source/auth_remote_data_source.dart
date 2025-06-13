import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_commerece_app/core/common/app%20manager/app_manager_cubit.dart';
import 'package:e_commerece_app/core/common/models/user_model.dart';
import 'package:e_commerece_app/core/network/api.dart';
import 'package:e_commerece_app/core/network/api_request.dart';
import 'package:e_commerece_app/core/network/api_response.dart';
import 'package:e_commerece_app/core/network/api_urls.dart';
import 'package:e_commerece_app/features/home/data/models/auth_response_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

// auth_remote_data_source.dart
abstract class AuthRemoteDataSource {
  Future<Either<String, AuthResponseModel>> register(
      CreateAccountParams params);
  Future<Either<String, AuthResponseModel>> login(
      String phone, String password);
  Future<Either<String, bool>> logout();
  // Remove product-related methods
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;
  final FlutterSecureStorage storage;

  AuthRemoteDataSourceImpl(this.dio, this.storage);
  @override
  Future<Either<String, AuthResponseModel>> register(
      CreateAccountParams params) async {
    try {
      final formData = FormData.fromMap({
        'phone': params.phone,
        'email': params.name, // This seems misnamed, should be email?
        'name': params.name,
        'password': params.passwordController,
        'password_confirmation': params.passwordConfirmController,
        'gender': params.gender,
        'type': params.type,
        'image': await MultipartFile.fromFile(params.image.path),
      });

      final response = await dio.post(
        ApiUrls.register,
        data: formData,
      );

      if (response.statusCode == 200) {
        final userData = AuthResponseModel.fromJson(response.data['data']);
        return Right(userData);
      } else {
        return Left(response.data['message'] ?? 'Registration failed');
      }
    } on DioException catch (e) {
      return Left(e.response?.data['message'] ?? e.toString());
    }
  }

  @override
  Future<Either<String, AuthResponseModel>> login(
      String phone, String password) async {
    try {
      final response = await dio.post(
        ApiUrls.login,
        data: {'phone': phone, 'password': password},
      );

      if (response.statusCode == 200) {
        final authData = AuthResponseModel.fromJson(response.data['data']);
        return Right(authData);
      } else {
        return Left(response.data['message'] ?? 'Login failed');
      }
    } on DioException catch (e) {
      return Left(e.response?.data['message'] ?? e.toString());
    }
  }

  @override
  Future<Either<String, bool>> logout() async {
    try {
      final token = await storage.read(key: 'token');
      final response = await dio.post(
        ApiUrls.logout,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return response.statusCode == 200
          ? const Right(true)
          : Left(response.data['message'] ?? 'Logout failed');
    } catch (e) {
      return Left(e.toString());
    }
  }
}

Future<void> updateProduct({
  required String productId,
  required String enName,
  required String enDescription,
  required String arName,
  required String arDescription,
  required String price,
  required String discountPrice,
  required String categoryId,
  required String deliveryFee,
  required File image,
  required String token,
}) async {
  var headers = {
    'Authorization': 'Bearer $token',
  };

  var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          'http://94.72.98.154/abdulrahim/public/api/products/$productId'))
    ..fields['en[name]'] = enName
    ..fields['en[description]'] = enDescription
    ..fields['ar[name]'] = arName
    ..fields['ar[description]'] = arDescription
    ..fields['price'] = price
    ..fields['discount_price'] = discountPrice
    ..fields['category_id'] = categoryId
    ..fields['delivery_fee'] = deliveryFee
    ..fields['_method'] = 'POST'
    ..files.add(await http.MultipartFile.fromPath('image', image.path))
    ..headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode != 200) {
    throw Exception('Failed to update product: ${response.reasonPhrase}');
  }
}

Future<void> storeService({
  required String price,
  required String newPrice,
  required String deliveryFee,
  required String homeServiceFee,
  required String type,
  required String duration,
  required String categoryId,
  required String branchId,
  required String enName,
  required String enDescription,
  required String arName,
  required String arDescription,
  required File image,
  required AppManagerCubit appManagerCubit,
}) async {
  try {
    final user = appManagerCubit.state.user; // Retrieve the user from the state

    if (user == null) {
      throw Exception("User not authenticated");
    }

    final request = ApiRequest(
      url: ApiUrls.storeService, // Add this endpoint to ApiUrls
      body: {
        'price': price,
        'new_price': newPrice,
        'delivery_fee': deliveryFee,
        'home_service_fee': homeServiceFee,
        'type': type,
        'duration': duration,
        'category_id': categoryId,
        'branch_id': branchId,
        'en[name]': enName,
        'en[description]': enDescription,
        'ar[name]': arName,
        'ar[description]': arDescription,
      },
    );

    final response = await Api.post(request);

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Service stored successfully');
    } else {
      throw Exception(
          'Failed to store service: ${response.body["message"] ?? "Unknown error"}');
    }
  } catch (error) {
    print('Error storing service: $error');
    rethrow;
  }
}

class CreateAccountParams {
  final String name;
  final String passwordConfirmController;
  final String passwordController;
  final File image;
  final String phone;
  final String id;
  final String type;
  final String gender;

  CreateAccountParams(this.name, this.passwordConfirmController,
      this.passwordController, this.image, this.id, this.phone,
      {required this.type, required this.gender});
}
