import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Custom app bar
        Container(
          padding: const EdgeInsets.all(16),
          child: const Row(
            children: [
              Text(
                'Profile',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),

        // Main content
        const Expanded(child: Center(child: Text('Profile Screen Content'))),
      ],
    );
  }
}
