
import 'package:dartz/dartz.dart';

import '../../models/catmodel.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;


class RemoteCategoryDataSource {
  final String baseUrl = 'https://api.escuelajs.co/api/v1/categories/';

  // دالة لجلب الكاتيغوريز من الـ API
  Future<Either<String, List<CategoryModel>>> getCategories() async {
    try {
      // إجراء طلب GET للـ API
      final response = await http.get(Uri.parse(baseUrl));

      // التحقق من حالة الاستجابة
      if (response.statusCode == 200) {
        // إذا كانت الاستجابة ناجحة، نقوم بتحويل الـ JSON إلى كائنات Dart
        final List<dynamic> data = jsonDecode(response.body);

        // تحويل الـ JSON إلى كائنات CategoryModel
        final categories = data.map((categoryData) {
          return CategoryModel.fromJson(categoryData);
        }).toList();

        // إرجاع النتيجة كـ Right لأنه تم بنجاح
        return Right(categories);
      } else {
        // إذا كانت الاستجابة غير ناجحة، إرجاع رسالة خطأ
        return Left('Failed to load categories: ${response.statusCode}');
      }
    } catch (e) {
      // في حال حدوث أي خطأ أثناء الطلب، إرجاع رسالة خطأ
      return Left('Error: $e');
    }
  }
}
