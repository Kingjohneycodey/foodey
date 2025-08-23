import 'package:flutter/material.dart';
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

final GoRouter appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(path: '/splash', builder: (context, state) => const SplashScreen()),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    ShellRoute(
      builder: (context, state, child) {
        return Scaffold(
          body: child,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _getIndex(state.uri.toString()),
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
              BottomNavigationBarItem(
                icon: Icon(Icons.restaurant),
                label: "Menu",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                label: "Cart",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.receipt),
                label: "Orders",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "Profile",
              ),
            ],
          ),
        );
      },
      routes: [
        GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
        GoRoute(path: '/menu', builder: (context, state) => const MenuScreen()),
        GoRoute(path: '/cart', builder: (context, state) => const CartScreen()),
        GoRoute(
          path: '/orders',
          builder: (context, state) => const OrdersScreen(),
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) => const ProfileScreen(),
        ),
      ],
    ),
  ],
);

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
