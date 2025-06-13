import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_commerece_app/core/network/api_urls.dart';
import 'package:e_commerece_app/features/home/data/models/data_model.dart';
import 'package:e_commerece_app/features/home/data/models/product_response_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ProductRemoteDataSource {
  final Dio dio;
  final FlutterSecureStorage storage;

  ProductRemoteDataSource({required this.dio, required this.storage});
// Add to product_remote_data_source.dart
  Future<Either<String, bool>> updateProductWithImage({
    required String productId,
    required CreateProductParams params,
    required String token,
  }) async {
    try {
      final formData = FormData.fromMap({
        'en[name]': params.enName,
        'en[description]': params.enDescription,
        'ar[name]': params.arName,
        'ar[description]': params.arDescription,
        'price': params.price,
        'discount_price': params.discountPrice,
        'category_id': params.categoryId,
        'delivery_fee': params.deliveryFee,
        'image': await MultipartFile.fromFile(
          params.imagePath,
          filename: params.imageName,
        ),
        '_method': 'PUT',
      });

      final response = await dio.post(
        '${ApiUrls.storeProduct}/$productId',
        data: formData,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
          contentType: 'multipart/form-data',
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return const Right(true);
      } else {
        return Left(response.data['message'] ?? 'Update failed');
      }
    } on DioException catch (e) {
      return Left(e.response?.data['message'] ?? e.message ?? 'Network error');
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, List<Product>>> fetchProducts() async {
    try {
      final response = await dio.get(ApiUrls.getProducts);

      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        final products = data.map((json) => Product.fromJson(json)).toList();
        return Right(products);
      } else {
        return Left('Failed to fetch products: ${response.statusCode}');
      }
    } on DioException catch (e) {
      return Left('Network error: ${e.message}');
    } catch (e) {
      return Left('Unexpected error: $e');
    }
  }

  Future<Either<String, ProductResponseModel>> addProduct(
    CreateProductParams params,
  ) async {
    try {
      final token = await storage.read(key: 'token');
      if (token == null) return Left('Authentication required');

      final formData = FormData.fromMap({
        'en[name]': params.enName,
        'en[description]': params.enDescription,
        'ar[name]': params.arName,
        'ar[description]': params.arDescription,
        'price': params.price,
        'discount_price': params.discountPrice,
        'category_id': params.categoryId,
        'delivery_fee': params.deliveryFee,
        'image': await MultipartFile.fromFile(
          params.imagePath,
          filename: params.imageName,
        ),
      });

      final response = await dio.post(
        ApiUrls.storeProduct,
        data: formData,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
          contentType: 'multipart/form-data',
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(ProductResponseModel.fromJson(response.data['data']));
      } else {
        return Left('Failed to add product: ${response.data['message']}');
      }
    } on DioException catch (e) {
      return Left('Network error: ${e.response?.data['message'] ?? e.message}');
    } catch (e) {
      return Left('Unexpected error: $e');
    }
  }

  Future<Either<String, List<Map<String, dynamic>>>> fetchCategories() async {
    try {
      final response = await dio.get(ApiUrls.getCategories);

      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return Right(data.cast<Map<String, dynamic>>());
      } else {
        return Left('Failed to fetch categories: ${response.statusCode}');
      }
    } on DioException catch (e) {
      return Left('Network error: ${e.message}');
    } catch (e) {
      return Left('Unexpected error: $e');
    }
  }

  Future<Either<String, Map<String, dynamic>>> fetchProductDetails(
    String productId,
  ) async {
    try {
      final response = await dio.get('${ApiUrls.getProductDetails}/$productId');

      if (response.statusCode == 200) {
        return Right(response.data as Map<String, dynamic>);
      } else {
        return Left('Failed to fetch product details: ${response.statusCode}');
      }
    } on DioException catch (e) {
      return Left('Network error: ${e.message}');
    } catch (e) {
      return Left('Unexpected error: $e');
    }
  }

  Future<Either<String, bool>> updateProduct({
    required String productId,
    required Map<String, dynamic> productData,
  }) async {
    try {
      final token = await storage.read(key: 'token');
      if (token == null) return Left('Authentication required');

      final response = await dio.put(
        '${ApiUrls.storeProduct}/$productId',
        data: productData,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      return response.statusCode == 200
          ? const Right(true)
          : Left('Update failed: ${response.data['message']}');
    } on DioException catch (e) {
      return Left('Network error: ${e.message}');
    } catch (e) {
      return Left('Unexpected error: $e');
    }
  }

  Future<Either<String, bool>> deleteProduct(String productId) async {
    try {
      final token = await storage.read(key: 'token');
      if (token == null) return Left('Authentication required');

      final response = await dio.delete(
        '${ApiUrls.getProductDetails}/$productId',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      return response.statusCode == 200
          ? const Right(true)
          : Left('Deletion failed: ${response.data['message']}');
    } on DioException catch (e) {
      return Left('Network error: ${e.message}');
    } catch (e) {
      return Left('Unexpected error: $e');
    }
  }
}

class CreateProductParams {
  final String imagePath;
  final String imageName;
  final String enName;
  final String enDescription;
  final String arName;
  final String arDescription;
  final double price;
  final double discountPrice;
  final int categoryId;
  final double deliveryFee;

  CreateProductParams({
    required this.imagePath,
    required this.imageName,
    required this.enName,
    required this.enDescription,
    required this.arName,
    required this.arDescription,
    required this.price,
    required this.discountPrice,
    required this.categoryId,
    required this.deliveryFee,
  });
}
