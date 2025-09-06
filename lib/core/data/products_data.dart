import '../models/product.dart';

class ProductsData {
  static final List<Product> allProducts = [
    Product(
      id: '1',
      name: 'Classic Burger',
      description:
          'Juicy beef patty with fresh lettuce, tomato, and special sauce',
      price: 12.75,
      rating: 4.7,
      image: 'assets/images/burger1.jpeg',
      category: 'Burger',
      tags: ['beef', 'juicy', 'classic', 'popular'],
    ),
    Product(
      id: '11',
      name: 'Beef Burger',
      description: 'Premium beef burger with cheese and special sauce',
      price: 8.99,
      originalPrice: 9.99,
      rating: 4.5,
      image: 'assets/images/burger1.jpeg',
      category: 'Burger',
      tags: ['beef', 'premium', 'cheese'],
    ),
    Product(
      id: '12',
      name: 'Pepperoni Cheese Pizza',
      description: 'Delicious pizza with pepperoni and extra cheese',
      price: 12.99,
      rating: 4.8,
      image: 'assets/images/burger1.jpeg',
      category: 'Pizza',
      tags: ['pepperoni', 'cheese', 'pizza'],
    ),
    Product(
      id: '13',
      name: 'Donut Box',
      description: 'Box of assorted fresh donuts with various flavors',
      price: 13.45,
      rating: 4.6,
      image: 'assets/images/burger1.jpeg',
      category: 'Donuts',
      tags: ['variety', 'sweet', 'box', 'assorted'],
    ),
    Product(
      id: '2',
      name: 'Pepperoni Pizza',
      description:
          'Traditional pizza with pepperoni, mozzarella, and tomato sauce',
      price: 18.50,
      rating: 4.8,
      image: 'assets/images/burger1.jpeg',
      category: 'Pizza',
      tags: ['pepperoni', 'cheese', 'traditional', 'italian'],
    ),
    Product(
      id: '3',
      name: 'Chocolate Donut',
      description: 'Freshly baked donut with rich chocolate glaze',
      price: 4.89,
      originalPrice: 5.75,
      rating: 4.6,
      image: 'assets/images/burger1.jpeg',
      category: 'Donuts',
      tags: ['chocolate', 'sweet', 'dessert', 'baked'],
    ),
    Product(
      id: '4',
      name: 'Caesar Salad',
      description: 'Fresh romaine lettuce with Caesar dressing and croutons',
      price: 9.25,
      rating: 4.5,
      image: 'assets/images/burger1.jpeg',
      category: 'Salad',
      tags: ['healthy', 'fresh', 'vegetables', 'light'],
    ),
    Product(
      id: '5',
      name: 'Ice Cream Cone',
      description: 'Creamy vanilla ice cream in a crispy cone',
      price: 4.50,
      rating: 4.9,
      image: 'assets/images/burger1.jpeg',
      category: 'Ice Cream',
      tags: ['cold', 'sweet', 'dessert', 'vanilla'],
    ),
    Product(
      id: '6',
      name: 'Chicken Sandwich',
      description: 'Grilled chicken breast with lettuce and mayo',
      price: 11.25,
      rating: 4.7,
      image: 'assets/images/burger1.jpeg',
      category: 'Sandwich',
      tags: ['chicken', 'grilled', 'healthy', 'protein'],
    ),
    Product(
      id: '7',
      name: 'Margherita Pizza',
      description: 'Classic pizza with tomato sauce, mozzarella, and basil',
      price: 16.99,
      rating: 4.6,
      image: 'assets/images/burger1.jpeg',
      category: 'Pizza',
      tags: ['margherita', 'cheese', 'basil', 'traditional'],
    ),
    Product(
      id: '8',
      name: 'BBQ Burger',
      description: 'Beef burger with BBQ sauce, onion rings, and cheddar',
      price: 14.99,
      rating: 4.8,
      image: 'assets/images/burger1.jpeg',
      category: 'Burger',
      tags: ['bbq', 'beef', 'onion', 'cheddar'],
    ),
    Product(
      id: '9',
      name: 'Strawberry Donut',
      description: 'Pink glazed donut with strawberry flavoring',
      price: 4.25,
      rating: 4.4,
      image: 'assets/images/burger1.jpeg',
      category: 'Donuts',
      tags: ['strawberry', 'pink', 'sweet', 'fruity'],
    ),
    Product(
      id: '10',
      name: 'Greek Salad',
      description: 'Mixed greens with feta cheese, olives, and vinaigrette',
      price: 10.75,
      rating: 4.3,
      image: 'assets/images/burger1.jpeg',
      category: 'Salad',
      tags: ['greek', 'feta', 'olives', 'mediterranean'],
    ),
    Product(
      id: '11',
      name: 'Chocolate Ice Cream',
      description: 'Rich chocolate ice cream with chocolate chips',
      price: 5.25,
      rating: 4.7,
      image: 'assets/images/burger1.jpeg',
      category: 'Ice Cream',
      tags: ['chocolate', 'rich', 'chips', 'indulgent'],
    ),
    Product(
      id: '12',
      name: 'Veggie Sandwich',
      description: 'Fresh vegetables with hummus on whole grain bread',
      price: 9.99,
      rating: 4.2,
      image: 'assets/images/burger1.jpeg',
      category: 'Sandwich',
      tags: ['vegetarian', 'hummus', 'healthy', 'veggies'],
    ),
  ];

  static List<Product> searchProducts(String query) {
    if (query.isEmpty) return allProducts;

    return allProducts
        .where((product) => product.matchesSearch(query))
        .toList();
  }

  static List<Product> getProductsByCategory(String category) {
    if (category == 'Offers') return allProducts.take(3).toList();

    return allProducts
        .where((product) => product.category == category)
        .toList();
  }

  static List<String> getAllCategories() {
    return allProducts.map((product) => product.category).toSet().toList();
  }
}
