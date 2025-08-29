import 'package:flutter/material.dart';
import 'package:foodey/core/theme/app_colors.dart';
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
      path: '/home',
      builder: (context, state) => const MainAppShell(currentIndex: 0),
    ),
    GoRoute(
      path: '/menu',
      builder: (context, state) => const MainAppShell(currentIndex: 1),
    ),
    GoRoute(
      path: '/cart',
      builder: (context, state) => const MainAppShell(currentIndex: 2),
    ),
    GoRoute(
      path: '/orders',
      builder: (context, state) => const MainAppShell(currentIndex: 3),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const MainAppShell(currentIndex: 4),
    ),
  ],
);

class MainAppShell extends StatefulWidget {
  final int currentIndex;

  const MainAppShell({super.key, required this.currentIndex});

  @override
  State<MainAppShell> createState() => _MainAppShellState();
}

class _MainAppShellState extends State<MainAppShell> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex;
  }

  @override
  void didUpdateWidget(MainAppShell oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentIndex != widget.currentIndex) {
      setState(() {
        _currentIndex = widget.currentIndex;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          HomeScreen(),
          MenuScreen(),
          CartScreen(),
          OrdersScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
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
}
