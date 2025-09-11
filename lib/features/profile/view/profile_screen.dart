import 'package:flutter/material.dart';
import 'package:foodey/core/theme/app_colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with close button and logo
              Row(
                children: [
                  const Text(
                    'Profile',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2D2D2D),
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
                        const Text(
                          'Daniel Jones',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2D2D2D),
                            fontFamily: 'Nunito',
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'daniel.jones@example.com',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF666666),
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
                            color: const Color(0xFFF5F5F5),
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
                              const Text(
                                'Premium',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF2D2D2D),
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
              const Text(
                'General',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2D2D2D),
                  fontFamily: 'Nunito',
                ),
              ),

              const SizedBox(height: 16),

              // General Menu Items
              _buildMenuItem(
                icon: Icons.person_outline,
                title: 'My Account',
                onTap: () {},
              ),
              _buildMenuItem(
                icon: Icons.list_alt,
                title: 'My Orders',
                onTap: () {},
              ),
              _buildMenuItem(
                icon: Icons.payment,
                title: 'Payment',
                onTap: () {},
              ),
              _buildMenuItem(
                icon: Icons.location_on_outlined,
                title: 'Addresses',
                onTap: () {},
              ),
              _buildMenuItem(
                icon: Icons.diamond_outlined,
                title: 'Subscription',
                onTap: () {},
              ),
              _buildMenuItem(
                icon: Icons.settings_outlined,
                title: 'Settings',
                onTap: () {},
              ),

              const SizedBox(height: 32),

              // Theme Section
              const Text(
                'Theme',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2D2D2D),
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
                  color: const Color(0xFFF9FAF8),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE0E0E0)),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.dark_mode_outlined,
                      size: 20,
                      color: Color(0xFF2D2D2D),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        'Dark mode',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF2D2D2D),
                          fontFamily: 'Nunito',
                        ),
                      ),
                    ),
                    Switch(
                      value: _isDarkMode,
                      onChanged: (value) {
                        setState(() {
                          _isDarkMode = value;
                        });
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
              color: const Color(0xFFF9FAF8),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(icon, size: 20, color: const Color(0xFF2D2D2D)),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF2D2D2D),
                      fontFamily: 'Nunito',
                    ),
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Color(0xFF999999),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
