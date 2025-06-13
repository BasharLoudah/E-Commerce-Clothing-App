class Product {
  final int id;
  final String name;
  final String image;
  final double price;
  final double? oldPrice;
  final double? distance;

  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    this.oldPrice,
    this.distance,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      price: json['price'].toDouble(),
      oldPrice: json['old_price']?.toDouble(),
      distance: json['distance']?.toDouble(),
    );
  }
 Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "price":price,
        "old_price":oldPrice,
        "distance":distance,
      };

  Product copyWith({
    int? id,
    String? name,
    String? image,
    double? price,
    double? oldPrice,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      price: price ?? this.price,
      oldPrice: oldPrice ?? this.oldPrice,
    );
  }
}

class Service {
  final int id;
  final String name;
  final String description;
  final String imageUrl;
  final String location; // New property for location
  final double distance; // New property for distance
  final double rating; // New property for rating
  final int reviews; // New property for number of reviews
  final double price; // Add this if needed

  Service({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.location,
    required this.distance,
    required this.rating,
    required this.reviews,
    required this.price, // Add this

  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(

      price: (json['price'] as num).toDouble(), // Add this
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['image'],
      location: json['location'] ?? 'Unknown location', // Default if not provided
      distance: (json['distance'] as num?)?.toDouble() ?? 0.0, // Handle null or integer
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0, // Handle null or integer
      reviews: json['reviews'] ?? 0, // Default to 0 if not provided
    );
  }

  Service copyWith({
    int? id,
    String? name,
    String? description,
    String? imageUrl,
    String? location,
    double? distance,
    double? rating,
    int? reviews,
    double? price,
  }) {
    return Service(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      location: location ?? this.location,
      distance: distance ?? this.distance,
      rating: rating ?? this.rating,
      reviews: reviews ?? this.reviews,
      price: price ?? this.price,
    );
  }
}

