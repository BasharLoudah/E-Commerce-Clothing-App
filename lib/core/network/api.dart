import 'package:dio/dio.dart';
import 'package:e_commerece_app/core/network/api_request.dart';
import 'package:e_commerece_app/core/network/api_response.dart';

class Api {
  static final Dio _dio = Dio(
    BaseOptions(
      headers: {'Accept': 'application/json'},
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  static Future<ApiResponse> post(ApiRequest request) async {
    try {
      final response = await _dio.post(
        request.url,
        data: request.body,
      );
      return ApiResponse(
        statusCode: response.statusCode!,
        body: response.data,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  static Future<ApiResponse> postWithAuth(
      ApiRequest request, String token) async {
    try {
      final response = await _dio.post(
        request.url,
        data: request.body,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return ApiResponse(
        statusCode: response.statusCode!,
        body: response.data,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  static Future<ApiResponse> get(ApiRequest request) async {
    try {
      final response = await _dio.get(request.url);
      return ApiResponse(
        statusCode: response.statusCode!,
        body: response.data,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  static Future<ApiResponse> delete(ApiRequest request, String token) async {
    try {
      final response = await _dio.delete(
        request.url,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return ApiResponse(
        statusCode: response.statusCode!,
        body: response.data,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  static Exception _handleError(DioException error) {
    final errorMessage = error.response?.data['message'] ?? error.message;
    return Exception('API Error: $errorMessage');
  }
}
