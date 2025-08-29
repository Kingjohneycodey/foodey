import 'package:flutter/material.dart';
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
      builder: (context, state) => const MainAppScreen(currentIndex: 0),
    ),
    GoRoute(
      path: '/menu',
      builder: (context, state) => const MainAppScreen(currentIndex: 1),
    ),
    GoRoute(
      path: '/cart',
      builder: (context, state) => const MainAppScreen(currentIndex: 2),
    ),
    GoRoute(
      path: '/orders',
      builder: (context, state) => const MainAppScreen(currentIndex: 3),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const MainAppScreen(currentIndex: 4),
    ),
  ],
);

class MainAppScreen extends StatefulWidget {
  final int currentIndex;

  const MainAppScreen({super.key, required this.currentIndex});

  @override
  State<MainAppScreen> createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex;
  }

  Widget _buildBody() {
    print('Building body for index: $_currentIndex');
    switch (_currentIndex) {
      case 0:
        return const HomeScreen();
      case 1:
        return const MenuScreen();
      case 2:
        return const CartScreen();
      case 3:
        return const OrdersScreen();
      case 4:
        return const ProfileScreen();
      default:
        return const HomeScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    print('MainAppScreen building with index: $_currentIndex');
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom:
            false, // Don't add bottom safe area since we have bottom navigation
        child: _buildBody(),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(color: Colors.grey.shade300, width: 2),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,
            elevation: 0,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
            currentIndex: _currentIndex,
            onTap: (index) {
              print('Tab tapped: $index');
              setState(() {
                _currentIndex = index;
              });
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
        ),
      ),
    );
  }
}
