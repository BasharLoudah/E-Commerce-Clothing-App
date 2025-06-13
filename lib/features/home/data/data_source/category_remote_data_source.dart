import 'package:e_commerece_app/core/network/api.dart';
import 'package:e_commerece_app/core/network/api_request.dart';
import 'package:e_commerece_app/core/network/api_urls.dart';

class CategoryRemoteDataSource {
  Future<List<Map<String, dynamic>>> fetchCategories() async {
    final request = ApiRequest(url: ApiUrls.getCategories, body: {});
    final response = await Api.get(request);
    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(response.body['data']);
    }
    throw Exception('Failed to fetch categories');
  }

  Future<void> addCategory(
      Map<String, dynamic> categoryData, String token) async {
    final request = ApiRequest(url: ApiUrls.storeCategory, body: categoryData);
    await Api.postWithAuth(request, token);
  }
}
