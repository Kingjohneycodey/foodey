import 'package:flutter/material.dart';
import 'package:foodey/core/theme/app_colors.dart';
import 'package:foodey/features/auth/view/register_otp_screen.dart';
import 'package:foodey/features/onboarding/view/onboarding_screen2.dart';
import 'package:go_router/go_router.dart';

import '../../features/splash/view/splash_screen.dart';
import '../../features/onboarding/view/onboarding_screen.dart';
import '../../features/auth/view/login_screen.dart';
import '../../features/auth/view/register_screen.dart';
import '../../features/home/view/home_screen.dart';
import '../../features/menu/view/menu_screen.dart';
import '../../features/cart/view/cart_screen.dart';
import '../../features/orders/view/orders_screen.dart';
import '../../features/profile/view/profile_screen.dart';
import '../../features/search/view/search_screen.dart';
import '../../core/models/product.dart';
import '../../features/menu/view/product_detail_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(path: '/splash', builder: (context, state) => const SplashScreen()),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: '/onboarding2',
      builder: (context, state) => const OnboardingScreen2(),
    ),
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/register-otp',
      builder: (context, state) => const RegisterOtpScreen(),
    ),

    ShellRoute(
      builder: (context, state, child) {
        return MainAppShell(child: child);
      },
      routes: [
        GoRoute(
          path: '/home',
          pageBuilder: (context, state) =>
              NoTransitionPage(child: const HomeScreen()),
        ),
        GoRoute(
          path: '/menu',
          pageBuilder: (context, state) =>
              NoTransitionPage(child: const MenuScreen()),
        ),
        GoRoute(
          path: '/cart',
          pageBuilder: (context, state) =>
              NoTransitionPage(child: const CartScreen()),
        ),
        GoRoute(
          path: '/orders',
          pageBuilder: (context, state) =>
              NoTransitionPage(child: const OrdersScreen()),
        ),
        GoRoute(
          path: '/profile',
          pageBuilder: (context, state) =>
              NoTransitionPage(child: const ProfileScreen()),
        ),
        GoRoute(
          path: '/search',
          pageBuilder: (context, state) =>
              NoTransitionPage(child: const SearchScreen()),
        ),
        GoRoute(
          path: '/product/:id',
          builder: (context, state) {
            final extra = state.extra;
            if (extra is Product) {
              return ProductDetailScreen(product: extra);
            }
            // Fallback: if no product provided, show an empty scaffold
            return const Scaffold(
              body: Center(child: Text('Product not found')),
            );
          },
        ),
      ],
    ),
  ],
);

class MainAppShell extends StatelessWidget {
  final Widget child;

  const MainAppShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final currentIndex = _getIndex(location);

    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.grey,
        currentIndex: currentIndex,
        onTap: (index) {
          switch (index) {
            case 0:
              context.go('/home');
              break;
            case 1:
              context.go('/menu');
              break;
            case 2:
              context.go('/cart');
              break;
            case 3:
              context.go('/orders');
              break;
            case 4:
              context.go('/profile');
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.restaurant), label: "Menu"),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Cart",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.receipt), label: "Orders"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }

  /// Helper function for BottomNav index
  int _getIndex(String location) {
    switch (location) {
      case '/home':
        return 0;
      case '/menu':
        return 1;
      case '/cart':
        return 2;
      case '/orders':
        return 3;
      case '/profile':
        return 4;
      default:
        return 0;
    }
  }
}
