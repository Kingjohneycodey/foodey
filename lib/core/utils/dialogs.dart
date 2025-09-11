import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:foodey/core/models/product.dart';
import 'package:foodey/core/theme/app_colors.dart';
import 'package:another_flushbar/flushbar.dart';

Future<void> showAddToCartSuccess(
  BuildContext context, {
  required Product product,
  required int quantity,
}) async {
  await Flushbar(
    message: 'Added $quantity × ${product.name} to your cart',
    icon: const Icon(Icons.check_circle, color: Colors.white),
    backgroundColor: AppColors.primary,
    duration: const Duration(seconds: 2),
    margin: const EdgeInsets.all(16),
    borderRadius: BorderRadius.circular(12),
    mainButton: TextButton(
      onPressed: () {
        context.push('/cart');
      },
      child: const Text(
        'VIEW',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    ),
  ).show(context);
}
