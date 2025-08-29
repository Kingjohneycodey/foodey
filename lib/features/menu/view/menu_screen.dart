import 'package:flutter/material.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
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
                'Menu',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),

        // Main content
        const Expanded(child: Center(child: Text('Menu Screen Content'))),
      ],
    );
  }
}
