import 'package:flutter/material.dart';
import 'package:foodey/core/theme/app_colors.dart';
import 'package:go_router/go_router.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Only first 3 slides here
  final List<OnboardingPage> _pages = [
    OnboardingPage(
      title: 'Welcome to the most tastiest app',
      subtitle: 'You know, this app is edible meaning you can eat it!',
      image: 'assets/images/onboarding1.png',
    ),
    OnboardingPage(
      title: 'Quick & Easy Ordering',
      subtitle:
          'Order with just a few taps and track your delivery in real-time',
      image: 'assets/images/onboarding2.png',
    ),
    OnboardingPage(
      title: 'We’re the besties of birthday peoples',
      subtitle: 'We send cakes to our plus members, (only one cake per person)',
      image: 'assets/images/onboarding3.png',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(color: AppColors.background),
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                "Foodey",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                  fontFamily: 'Pacifico',
                ),
              ),
            ),
          ),
          SafeArea(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() => _currentPage = index);
              },
              itemCount: _pages.length,
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Image.asset(
                        _pages[index].image,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Column(
                          children: [
                            Text(
                              _pages[index].title,
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF363A33),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              _pages[index].subtitle,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Color(0xFF60655C),
                                height: 1.5,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          // Bottom controls
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Indicators
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _pages.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        height: 10,
                        width: _currentPage == index ? 30 : 10,
                        decoration: BoxDecoration(
                          color: _currentPage == index
                              ? AppColors.primary
                              : Colors.grey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => context.go('/onboarding2'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFE8F5E8),
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Skip',
                            style: TextStyle(
                              color: Color(0xFF5CAB1A),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (_currentPage < _pages.length - 1) {
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            } else {
                              context.go('/onboarding2');
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            _currentPage == _pages.length - 1
                                ? 'Continue'
                                : 'Next',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingPage {
  final String title;
  final String subtitle;
  final String image;

  OnboardingPage({
    required this.title,
    required this.subtitle,
    required this.image,
  });
}
