import 'package:e_commerece_app/core/network/api.dart';
import 'package:e_commerece_app/core/network/api_request.dart';

import 'package:e_commerece_app/core/network/api_urls.dart';

import '../../models/catmodel.dart';

class CategoryRemoteDataSource {
  Future<List<CategoryModel>> fetchCategories() async {
    final request = ApiRequest(
      url: ApiUrls.getCategories,
      body: {},
    );

    final response = await Api.get(request);

    if (response.statusCode == 200) {
      final List data = response.body as List;
      return data.map((e) => CategoryModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to fetch categories: ${response.statusCode}');
    }
  }
}


// class CategoryRemoteDataSource {
//   Future<List<CategoryModel>> fetchCategories() async {
//     final request = ApiRequest(
//       url: ApiUrls.category,
//       body: {},
//     );

//     final response = await Api.get(request);

//     if (response.statusCode == 200) {
//       final Map<String, dynamic> decodedData = response.body; // Parse the response into a Map

//       // Assuming that the 'categories' key contains a list of categories
//       if (decodedData.containsKey('categories') && decodedData['categories'] is List) {
//         final List categoriesList = decodedData['categories']; // Extract the list of categories

//         // Map over the list and convert each item into a CategoryModel
//         return categoriesList
//             .map((category) => CategoryModel.fromJson(category))
//             .toList();
//       } else {
//         throw Exception('Unexpected response format: categories key missing or not a list');
//       }
//     } else {
//       throw Exception('Failed to fetch categories: ${response.statusCode}');
//     }
//   }
// }

