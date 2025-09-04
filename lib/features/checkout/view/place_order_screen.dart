import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodey/core/data/cart_provider.dart';
import 'package:foodey/core/theme/app_colors.dart';
import 'package:go_router/go_router.dart';

class PlaceOrderScreen extends ConsumerStatefulWidget {
  const PlaceOrderScreen({super.key});

  @override
  ConsumerState<PlaceOrderScreen> createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends ConsumerState<PlaceOrderScreen> {
  final double deliveryCharges = 3.99;

  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(cartProvider);
    final subtotal = cart.subtotal;
    final total = subtotal + deliveryCharges;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Custom app bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => context.pop(),
                    icon: const Icon(Icons.arrow_back_ios),
                    padding: EdgeInsets.zero,
                  ),
                  const Spacer(),
                  const Text(
                    'Place order',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Nunito',
                    ),
                  ),
                  const Spacer(),
                  const SizedBox(width: 48), // Balance the back button
                ],
              ),
            ),

            // Order items list
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const SizedBox(height: 8),

                    // Cart items
                    ...cart.items.map((item) => _buildOrderItem(item)),

                    // Show more items indicator
                    if (cart.items.length > 3)
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Text(
                          '+${cart.items.length - 3} more',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Nunito',
                          ),
                        ),
                      ),

                    const SizedBox(height: 24),

                    // Add coupon section
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.local_offer_outlined,
                            color: Colors.grey.shade600,
                            size: 20,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Add a coupon',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 16,
                              fontFamily: 'Nunito',
                            ),
                          ),
                          const Spacer(),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.grey.shade400,
                            size: 16,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Order summary
                    Container(
                      padding: const EdgeInsets.all(0),
                      child: Column(
                        children: [
                          _buildSummaryRow('Subtotal', subtotal),
                          const SizedBox(height: 12),
                          _buildSummaryRow(
                            'Delivery Charges',
                            deliveryCharges,
                            isDelivery: true,
                          ),
                          const SizedBox(height: 16),
                          Container(height: 1, color: Colors.grey.shade300),
                          const SizedBox(height: 16),
                          _buildSummaryRow('Total', total, isTotal: true),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),

            // Bottom section with total and continue button
            Container(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    offset: const Offset(0, -2),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '\$ ${total.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Nunito',
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      // Handle order placement
                      _showOrderConfirmation();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Continue',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Nunito',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderItem(item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          // Product image
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: AssetImage(item.product.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),

          // Product details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.product.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Nunito',
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${item.product.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Nunito',
                      ),
                    ),
                    Row(
                      children: [
                        _QtyButton(
                          icon: Icons.remove,
                          onTap: () {
                            final current = item.quantity - 1;
                            ref
                                .read(cartProvider.notifier)
                                .setQuantity(item.product.id, current);
                          },
                        ),
                        const SizedBox(width: 16),
                        Text(
                          item.quantity.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Nunito',
                          ),
                        ),
                        const SizedBox(width: 16),
                        _QtyButton(
                          icon: Icons.add,
                          onTap: () {
                            ref
                                .read(cartProvider.notifier)
                                .setQuantity(
                                  item.product.id,
                                  item.quantity + 1,
                                );
                          },
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          icon: Icon(
                            Icons.delete_outline,
                            color: Colors.grey.shade600,
                          ),
                          onPressed: () => ref
                              .read(cartProvider.notifier)
                              .remove(item.product.id),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(
    String label,
    double amount, {
    bool isTotal = false,
    bool isDelivery = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 18 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal ? Colors.black : Colors.grey.shade700,
            fontFamily: 'Nunito',
          ),
        ),
        Text(
          isDelivery
              ? '+\$${amount.toStringAsFixed(2)}'
              : '${amount.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: isTotal ? 18 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
            color: isTotal
                ? Colors.black
                : (isDelivery ? AppColors.primary : Colors.black),
            fontFamily: 'Nunito',
          ),
        ),
      ],
    );
  }

  void _showOrderConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Order Placed!',
          style: TextStyle(fontFamily: 'Nunito'),
        ),
        content: const Text(
          'Your order has been placed successfully. You will receive a confirmation shortly.',
          style: TextStyle(fontFamily: 'Nunito'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              ref.read(cartProvider.notifier).clear();
              context.go('/orders');
            },
            child: Text(
              'OK',
              style: TextStyle(color: AppColors.primary, fontFamily: 'Nunito'),
            ),
          ),
        ],
      ),
    );
  }
}

class _QtyButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _QtyButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: AppColors.light,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Icon(icon, color: AppColors.primary, size: 18),
      ),
    );
  }
}
