class ProductModel {
  final int id;
  final String title;
  final double price;
  final String description;
  final List<String> images;
  final String creationAt;
  final String updatedAt;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.images,
    required this.creationAt,
    required this.updatedAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      price: json['price'].toDouble(), // Ensure price is double
      description: json['description'],
      images: List<String>.from(json['images']),
      creationAt: json['creationAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
