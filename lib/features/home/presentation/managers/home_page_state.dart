// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:e_commerece_app/features/home/data/models/productmodel.dart';

import '../../data/models/catmodel.dart';


class HomePageState {
  final List<CategoryModel> categories;
  final List<ProductModel> allProducts;
  final List<ProductModel> filtered;

  HomePageState({
    required this.categories,
    required this.allProducts,
    required this.filtered,
  });

  HomePageState copyWith({
    List<CategoryModel>? categories,
    List<ProductModel>? allProducts,
    List<ProductModel>? filtered,
  }) {
    return HomePageState(
      categories: categories ?? this.categories,
      allProducts: allProducts ?? this.allProducts,
      filtered: filtered ?? this.filtered,
    );
  }
}
