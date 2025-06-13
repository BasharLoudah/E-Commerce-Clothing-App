import 'package:dartz/dartz.dart';
import 'package:e_commerece_app/features/home/data/models/productmodel.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'dart:async'; // For adding retry logic

class RemoteProductDataSource {
  final String baseUrl = 'https://api.escuelajs.co/api/v1/products/';

  Future<Either<String, List<ProductModel>>> getProduct() async {
    try {
      final response = await _retryRequest(() => http.get(Uri.parse(baseUrl)));
      
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final products = data.map((productsData) {
          return ProductModel.fromJson(productsData);
        }).toList();
        return Right(products);
      } else {
        return Left('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      return Left('Error: $e');
    }
  }

  // Retry logic with exponential backoff
  Future<http.Response> _retryRequest(Future<http.Response> Function() request) async {
    int retryCount = 0;
    while (retryCount < 3) {
      try {
        return await request();
      } catch (e) {
        retryCount++;
        if (retryCount >= 3) {
          rethrow;
        }
        await Future.delayed(Duration(seconds: retryCount * 2));
      }
    }
    throw Exception('Failed after retries');
  }
}
