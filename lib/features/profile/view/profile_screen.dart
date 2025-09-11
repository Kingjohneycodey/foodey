import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodey/core/theme/app_colors.dart';
import 'package:foodey/core/theme/theme_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final isDarkMode = themeMode == ThemeMode.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF1A1A1A) : Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Profile',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode
                          ? Colors.white
                          : const Color(0xFF2D2D2D),
                      fontFamily: 'Nunito',
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // User Profile Section
              Row(
                children: [
                  // Profile Avatar
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[300],
                    ),
                    child: const Icon(
                      Icons.person,
                      size: 30,
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(width: 16),

                  // User Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Daniel Jones',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isDarkMode
                                ? Colors.white
                                : const Color(0xFF2D2D2D),
                            fontFamily: 'Nunito',
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'daniel.jones@example.com',
                          style: TextStyle(
                            fontSize: 14,
                            color: isDarkMode
                                ? Colors.grey[400]
                                : const Color(0xFF666666),
                            fontFamily: 'Nunito',
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Premium Badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: isDarkMode
                                ? const Color(0xFF2A2A2A)
                                : const Color(0xFFF5F5F5),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.star,
                                size: 16,
                                color: Colors.orange,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Premium',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: isDarkMode
                                      ? Colors.white
                                      : const Color(0xFF2D2D2D),
                                  fontFamily: 'Nunito',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),

              // General Section
              Text(
                'General',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: isDarkMode ? Colors.white : const Color(0xFF2D2D2D),
                  fontFamily: 'Nunito',
                ),
              ),

              const SizedBox(height: 16),

              // General Menu Items
              _buildMenuItem(
                icon: Icons.person_outline,
                title: 'My Account',
                onTap: () {},
                isDarkMode: isDarkMode,
              ),
              _buildMenuItem(
                icon: Icons.list_alt,
                title: 'My Orders',
                onTap: () {},
                isDarkMode: isDarkMode,
              ),
              _buildMenuItem(
                icon: Icons.payment,
                title: 'Payment',
                onTap: () {},
                isDarkMode: isDarkMode,
              ),
              _buildMenuItem(
                icon: Icons.location_on_outlined,
                title: 'Addresses',
                onTap: () {},
                isDarkMode: isDarkMode,
              ),
              _buildMenuItem(
                icon: Icons.diamond_outlined,
                title: 'Subscription',
                onTap: () {},
                isDarkMode: isDarkMode,
              ),
              _buildMenuItem(
                icon: Icons.settings_outlined,
                title: 'Settings',
                onTap: () {},
                isDarkMode: isDarkMode,
              ),

              const SizedBox(height: 32),

              // Theme Section
              Text(
                'Theme',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: isDarkMode ? Colors.white : const Color(0xFF2D2D2D),
                  fontFamily: 'Nunito',
                ),
              ),

              const SizedBox(height: 16),

              // Dark Mode Toggle
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? const Color(0xFF2A2A2A)
                      : const Color(0xFFF9FAF8),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isDarkMode
                        ? const Color(0xFF404040)
                        : const Color(0xFFE0E0E0),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.dark_mode_outlined,
                      size: 20,
                      color: isDarkMode
                          ? Colors.white
                          : const Color(0xFF2D2D2D),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Dark mode',
                        style: TextStyle(
                          fontSize: 16,
                          color: isDarkMode
                              ? Colors.white
                              : const Color(0xFF2D2D2D),
                          fontFamily: 'Nunito',
                        ),
                      ),
                    ),
                    Switch(
                      value: isDarkMode,
                      onChanged: (value) {
                        ref.read(themeModeProvider.notifier).toggleTheme();
                      },
                      activeColor: AppColors.primary,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    required bool isDarkMode,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isDarkMode
                  ? const Color(0xFF2A2A2A)
                  : const Color(0xFFF9FAF8),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 20,
                  color: isDarkMode ? Colors.white : const Color(0xFF2D2D2D),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      color: isDarkMode
                          ? Colors.white
                          : const Color(0xFF2D2D2D),
                      fontFamily: 'Nunito',
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: isDarkMode
                      ? Colors.grey[400]
                      : const Color(0xFF999999),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
