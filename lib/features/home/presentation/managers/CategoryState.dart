import 'package:e_commerece_app/features/home/data/models/productmodel.dart';

import '../../data/models/catmodel.dart';

class CategoryState {
  final bool isLoading;
  final String? error;
  final List<CategoryModel> categories; // Changed to List<CategoryModel>
  final List<ProductModel> products; // Changed to List<ProductModel>

  CategoryState({
    this.isLoading = false,
    this.error,
    this.categories = const [], // Default empty list for categories
    this.products = const [], // Default empty list for products
  });

  CategoryState copyWith({
    bool? isLoading,
    String? error,
    List<CategoryModel>? categories,
    List<ProductModel>? products,
  }) {
    return CategoryState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      categories: categories ?? this.categories,
      products: products ?? this.products,
    );
  }
}
