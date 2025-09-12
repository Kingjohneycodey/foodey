import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodey/core/models/restaurant.dart';
import 'package:foodey/core/models/product.dart';

class RestaurantNotifier extends StateNotifier<List<Restaurant>> {
  RestaurantNotifier() : super(_sampleRestaurants);

  static final List<Restaurant> _sampleRestaurants = [
    Restaurant(
      id: '1',
      name: 'Burger Palace',
      description: 'Best burgers in town with fresh ingredients',
      image: 'assets/images/burger1.jpeg',
      rating: 4.5,
      deliveryTime: '25-35 mins',
      deliveryFee: '\$2.99',
      address: '123 Main St, Downtown',
      categories: ['Burgers', 'Fast Food', 'American'],
      menuItems: [
        Product(
          id: '1',
          name: 'Classic Cheeseburger',
          description:
              'Juicy beef patty with melted cheese, lettuce, tomato, and our special sauce',
          price: 12.99,
          rating: 4.5,
          image: 'assets/images/burger1.jpeg',
          category: 'Burgers',
          tags: ['beef', 'cheese', 'classic'],
        ),
        Product(
          id: '2',
          name: 'Bacon Deluxe',
          description:
              'Double beef patty with crispy bacon, cheddar cheese, and BBQ sauce',
          price: 15.99,
          rating: 4.7,
          image: 'assets/images/burger1.jpeg',
          category: 'Burgers',
          tags: ['beef', 'bacon', 'deluxe'],
        ),
        Product(
          id: '3',
          name: 'Chicken Tenders',
          description:
              'Crispy chicken tenders served with honey mustard dipping sauce',
          price: 9.99,
          rating: 4.3,
          image: 'assets/images/burger1.jpeg',
          category: 'Fast Food',
          tags: ['chicken', 'crispy', 'tenders'],
        ),
        Product(
          id: '4',
          name: 'French Fries',
          description: 'Golden crispy fries seasoned with sea salt',
          price: 4.99,
          rating: 4.2,
          image: 'assets/images/burger1.jpeg',
          category: 'Fast Food',
          tags: ['fries', 'sides', 'crispy'],
        ),
      ],
    ),
    Restaurant(
      id: '2',
      name: 'Pizza Corner',
      description: 'Authentic Italian pizza with fresh toppings',
      image: 'assets/images/banner.png',
      rating: 4.3,
      deliveryTime: '30-40 mins',
      deliveryFee: '\$3.99',
      address: '456 Oak Ave, Midtown',
      categories: ['Pizza', 'Italian', 'Mediterranean'],
      menuItems: [
        Product(
          id: '5',
          name: 'Margherita Pizza',
          description:
              'Classic pizza with tomato sauce, mozzarella, and fresh basil',
          price: 16.99,
          rating: 4.4,
          image: 'assets/images/banner.png',
          category: 'Pizza',
          tags: ['pizza', 'margherita', 'classic'],
        ),
        Product(
          id: '6',
          name: 'Pepperoni Supreme',
          description:
              'Loaded with pepperoni, bell peppers, onions, and extra cheese',
          price: 19.99,
          rating: 4.6,
          image: 'assets/images/banner.png',
          category: 'Pizza',
          tags: ['pizza', 'pepperoni', 'supreme'],
        ),
        Product(
          id: '7',
          name: 'Caesar Salad',
          description:
              'Fresh romaine lettuce with parmesan cheese and croutons',
          price: 8.99,
          rating: 4.1,
          image: 'assets/images/banner.png',
          category: 'Italian',
          tags: ['salad', 'caesar', 'healthy'],
        ),
      ],
    ),
    Restaurant(
      id: '3',
      name: 'Sushi Master',
      description: 'Fresh sushi and Japanese cuisine',
      image: 'assets/images/logo.png',
      rating: 4.8,
      deliveryTime: '20-30 mins',
      deliveryFee: '\$4.99',
      address: '789 Pine St, Uptown',
      categories: ['Sushi', 'Japanese', 'Asian'],
      menuItems: [
        Product(
          id: '8',
          name: 'California Roll',
          description:
              'Crab, avocado, and cucumber wrapped in seaweed and rice',
          price: 11.99,
          rating: 4.5,
          image: 'assets/images/logo.png',
          category: 'Sushi',
          tags: ['sushi', 'california', 'roll'],
        ),
        Product(
          id: '9',
          name: 'Salmon Nigiri',
          description: 'Fresh salmon over seasoned rice',
          price: 13.99,
          rating: 4.7,
          image: 'assets/images/logo.png',
          category: 'Sushi',
          tags: ['sushi', 'salmon', 'nigiri'],
        ),
        Product(
          id: '10',
          name: 'Chicken Teriyaki',
          description: 'Grilled chicken with teriyaki sauce and steamed rice',
          price: 14.99,
          rating: 4.4,
          image: 'assets/images/logo.png',
          category: 'Japanese',
          tags: ['chicken', 'teriyaki', 'grilled'],
        ),
      ],
    ),
    Restaurant(
      id: '4',
      name: 'Taco Fiesta',
      description: 'Authentic Mexican tacos and burritos',
      image: 'assets/images/onboarding1.png',
      rating: 4.2,
      deliveryTime: '15-25 mins',
      deliveryFee: '\$1.99',
      address: '321 Elm St, Eastside',
      categories: ['Mexican', 'Tacos', 'Burritos'],
      menuItems: [
        Product(
          id: '11',
          name: 'Beef Tacos',
          description:
              'Three soft tacos with seasoned ground beef, lettuce, and cheese',
          price: 8.99,
          rating: 4.3,
          image: 'assets/images/onboarding1.png',
          category: 'Tacos',
          tags: ['tacos', 'beef', 'mexican'],
        ),
        Product(
          id: '12',
          name: 'Chicken Burrito',
          description:
              'Large burrito with grilled chicken, rice, beans, and salsa',
          price: 10.99,
          rating: 4.4,
          image: 'assets/images/onboarding1.png',
          category: 'Burritos',
          tags: ['burrito', 'chicken', 'mexican'],
        ),
        Product(
          id: '13',
          name: 'Churros',
          description: 'Crispy fried dough sticks with cinnamon sugar',
          price: 5.99,
          rating: 4.6,
          image: 'assets/images/onboarding1.png',
          category: 'Mexican',
          tags: ['dessert', 'churros', 'sweet'],
        ),
      ],
    ),
  ];

  List<Restaurant> getRestaurantsByCategory(String category) {
    return state
        .where((restaurant) => restaurant.categories.contains(category))
        .toList();
  }

  List<Restaurant> searchRestaurants(String query) {
    if (query.isEmpty) return state;

    final lowercaseQuery = query.toLowerCase();
    return state
        .where(
          (restaurant) =>
              restaurant.name.toLowerCase().contains(lowercaseQuery) ||
              restaurant.description.toLowerCase().contains(lowercaseQuery) ||
              restaurant.categories.any(
                (cat) => cat.toLowerCase().contains(lowercaseQuery),
              ),
        )
        .toList();
  }
}

final restaurantProvider =
    StateNotifierProvider<RestaurantNotifier, List<Restaurant>>(
      (ref) => RestaurantNotifier(),
    );
