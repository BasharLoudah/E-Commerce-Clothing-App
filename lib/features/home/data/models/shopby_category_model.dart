import 'dart:ui';

class ShopbyCategoryModel {
  final String name;
  final String imageAsset;
  final VoidCallback onTap;
ShopbyCategoryModel({
    required this.name,
    required this.imageAsset,
    required this.onTap,

  });
}