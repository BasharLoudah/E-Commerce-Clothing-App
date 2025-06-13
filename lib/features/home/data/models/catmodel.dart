class CategoryModel {
  final int id;
  final String name;
  final String image;
  final String creationAt;
  final String updatedAt;

  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    required this.creationAt,
    required this.updatedAt,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      creationAt: json['creationAt'],
      updatedAt: json['updatedAt'],
    );
  }
}

enum CategoryType { tShirt, shoes, bag }
