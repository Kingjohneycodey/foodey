import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
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
                'Cart',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),

        // Main content
        const Expanded(child: Center(child: Text('Cart Screen Content'))),
      ],
    );
  }
}
