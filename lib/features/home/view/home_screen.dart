import 'package:flutter/material.dart';
import 'package:foodey/core/theme/app_colors.dart';
import 'package:go_router/go_router.dart';
import 'package:foodey/core/data/products_data.dart';
import 'package:foodey/core/models/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodey/core/data/cart_provider.dart';
import 'package:foodey/core/data/favorites_provider.dart';
import 'package:foodey/core/utils/dialogs.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  int _selectedCategory = 0;

  final List<String> categories = [
    'Offers',
    ...ProductsData.getAllCategories(),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Custom app bar
                Container(
                  padding: const EdgeInsets.only(
                    bottom: 16,
                    left: 16,
                    right: 16,
                  ),
                  child: Row(
                    children: [
                      // Profile image
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: const DecorationImage(
                            image: AssetImage('assets/images/avatar1.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      // Greeting text
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Hi Johney', style: TextStyle(fontSize: 16)),
                          Text(
                            'What are you craving?',
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),

                      const Spacer(),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () {
                              context.push('/favorites');
                            },
                            child: const Icon(
                              Icons.favorite,
                              color: AppColors.primary,
                            ),
                          ),
                          SizedBox(width: 8),
                          GestureDetector(
                            onTap: () {
                              // Handle notifications
                            },
                            child: const Icon(Icons.notifications),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Search bar
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: TextField(
                    readOnly: true,
                    onTap: () {
                      context.push('/search');
                    },
                    decoration: InputDecoration(
                      hintText: 'Search for food...',
                      hintStyle: TextStyle(color: Colors.grey.shade500),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey.shade500,
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),

                // Image slider
                Container(
                  height:
                      MediaQuery.of(context).size.width *
                      0.4, // 40% of screen width
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          image: DecorationImage(
                            image: AssetImage('assets/images/banner.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Page indicators
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (index) {
                    return Container(
                      width: 8,
                      height: 8,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentPage == index
                            ? AppColors.primary
                            : Colors.grey.shade300,
                      ),
                    );
                  }),
                ),

                // Categories
                Container(
                  height: 40,
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      bool isSelected = _selectedCategory == index;
                      return Container(
                        margin: EdgeInsets.only(
                          left: index == 0 ? 16 : 8,
                          right: index == categories.length - 1 ? 16 : 0,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedCategory = index;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected ? AppColors.light : null,
                              borderRadius: BorderRadius.circular(10),
                              border: isSelected
                                  ? null
                                  : Border.all(
                                      color: Color(0xFFE8EBE6),
                                      width: 1,
                                    ),
                            ),
                            child: Text(
                              categories[index],
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.grey.shade800
                                    : Color(0xFF70756B),
                                fontSize: 14,
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // List of items
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 180,
                    childAspectRatio: 0.8,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: _getProductsForSelectedCategory().length,
                  itemBuilder: (context, index) {
                    return _buildFoodCard(
                      _getProductsForSelectedCategory()[index],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Product> _getProductsForSelectedCategory() {
    if (_selectedCategory == 0) {
      // Offers category - show first 6 products
      return ProductsData.allProducts.take(6).toList();
    } else {
      final categoryName = categories[_selectedCategory];
      return ProductsData.getProductsByCategory(categoryName);
    }
  }

  Widget _buildFoodCard(Product product) {
    return GestureDetector(
      onTap: () {
        context.push('/product/${product.id}', extra: product);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Food image with rating badge
            Expanded(
              flex: 2,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                      image: DecorationImage(
                        image: AssetImage(product.image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // Rating badge
                  Positioned(
                    bottom: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.star, color: Colors.orange, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            product.rating.toString(),
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Favorite button
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Consumer(
                      builder: (context, ref, _) {
                        final favorites = ref.watch(favoritesProvider);
                        final isFavorite = favorites.items.any(
                          (item) => item.id == product.id,
                        );
                        return GestureDetector(
                          onTap: () {
                            ref
                                .read(favoritesProvider.notifier)
                                .toggle(product);
                          },
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: isFavorite
                                  ? Colors.red
                                  : Colors.grey.shade600,
                              size: 18,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            // Food details
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            product.name,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '\$${product.price.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Add to cart button
                    const SizedBox(width: 10),
                    Consumer(
                      builder: (context, ref, _) {
                        return InkWell(
                          onTap: () {
                            ref
                                .read(cartProvider.notifier)
                                .add(product, quantity: 1);
                            showAddToCartSuccess(
                              context,
                              product: product,
                              quantity: 1,
                            );
                          },
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: AppColors.light,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Icon(
                              Icons.add,
                              color: AppColors.primary,
                              size: 20,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
