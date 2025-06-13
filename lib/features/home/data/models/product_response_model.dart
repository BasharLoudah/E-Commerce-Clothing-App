class ProductResponseModel {
  final int id;
  final String name;
  final String description;

  ProductResponseModel({
    required this.id,
    required this.name,
    required this.description,
  });

  factory ProductResponseModel.fromJson(Map<String, dynamic> json) {
    return ProductResponseModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }
}
