import 'package:flutter/material.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
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
                'Orders',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),

        // Main content
        const Expanded(child: Center(child: Text('Orders Screen Content'))),
      ],
    );
  }
}
