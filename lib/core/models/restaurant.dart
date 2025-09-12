import 'package:foodey/core/models/product.dart';

class Restaurant {
  final String id;
  final String name;
  final String description;
  final String image;
  final double rating;
  final String deliveryTime;
  final String deliveryFee;
  final List<String> categories;
  final List<Product> menuItems;
  final bool isOpen;
  final String address;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.rating,
    required this.deliveryTime,
    required this.deliveryFee,
    required this.categories,
    required this.menuItems,
    this.isOpen = true,
    required this.address,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? '',
      rating: (json['rating'] ?? 0.0).toDouble(),
      deliveryTime: json['deliveryTime'] ?? '',
      deliveryFee: json['deliveryFee'] ?? '',
      categories: List<String>.from(json['categories'] ?? []),
      menuItems:
          (json['menuItems'] as List<dynamic>?)
              ?.map((item) => Product.fromJson(item))
              .toList() ??
          [],
      isOpen: json['isOpen'] ?? true,
      address: json['address'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image': image,
      'rating': rating,
      'deliveryTime': deliveryTime,
      'deliveryFee': deliveryFee,
      'categories': categories,
      'menuItems': menuItems.map((item) => item.toJson()).toList(),
      'isOpen': isOpen,
      'address': address,
    };
  }

  List<Product> getMenuByCategory(String category) {
    return menuItems.where((item) => item.category == category).toList();
  }

  List<String> get availableCategories {
    return menuItems.map((item) => item.category).toSet().toList();
  }
}
