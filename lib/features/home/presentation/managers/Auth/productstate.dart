import 'package:e_commerece_app/features/home/data/models/product_response_model.dart';

class ProductState {
  final bool isLoading;
  final String? error;
  final ProductResponseModel? productData;

  // New state properties for categories
  final bool isLoadingCategories;
  final String? errorCategories;
  final List<Map<String, dynamic>> categories;

  ProductState({
    this.isLoading = false,
    this.error,
    this.productData,
    this.isLoadingCategories = false,
    this.errorCategories,
    this.categories = const [],
  });

  ProductState copyWith({
    bool? isLoading,
    String? error,
    ProductResponseModel? productData,
    bool? isLoadingCategories,
    String? errorCategories,
    List<Map<String, dynamic>>? categories,
  }) {
    return ProductState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      productData: productData ?? this.productData,
      isLoadingCategories: isLoadingCategories ?? this.isLoadingCategories,
      errorCategories: errorCategories ?? this.errorCategories,
      categories: categories ?? this.categories,
    );
  }
}
