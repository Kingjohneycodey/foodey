import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodey/core/data/cart_provider.dart';
import 'package:foodey/core/theme/app_colors.dart';
import 'package:go_router/go_router.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Consumer(
            builder: (context, ref, _) {
              final cart = ref.watch(cartProvider);
              return Column(
                children: [
                  // Custom app bar
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Transform.rotate(
                          angle: -0.3,
                          child: Icon(Icons.shopping_cart),
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Cart',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Items
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: cart.items.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final item = cart.items[index];
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.grey.shade200),
                          ),
                          child: Row(
                            children: [
                              // Thumbnail placeholder (use product.image if desired)
                              GestureDetector(
                                onTap: () => context.push(
                                  '/product/${item.product.id}',
                                  extra: item.product,
                                ),
                                child: Container(
                                  width: 90,
                                  height: 90,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(16),
                                      bottomLeft: Radius.circular(16),
                                    ),
                                    image: DecorationImage(
                                      image: AssetImage(item.product.image),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(6),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        onTap: () => context.push(
                                          '/product/${item.product.id}',
                                          extra: item.product,
                                        ),
                                        child: Text(
                                          item.product.name,
                                          style: const TextStyle(fontSize: 16),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '\$' +
                                                item.product.price
                                                    .toStringAsFixed(2),
                                            style: const TextStyle(
                                              fontSize: 16,

                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              _QtyButton(
                                                icon: Icons.remove,
                                                onTap: () {
                                                  final current =
                                                      item.quantity - 1;
                                                  ref
                                                      .read(
                                                        cartProvider.notifier,
                                                      )
                                                      .setQuantity(
                                                        item.product.id,
                                                        current,
                                                      );
                                                },
                                              ),
                                              const SizedBox(width: 8),
                                              Text(
                                                item.quantity.toString(),
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              _QtyButton(
                                                icon: Icons.add,
                                                onTap: () {
                                                  ref
                                                      .read(
                                                        cartProvider.notifier,
                                                      )
                                                      .setQuantity(
                                                        item.product.id,
                                                        item.quantity + 1,
                                                      );
                                                },
                                              ),
                                              IconButton(
                                                icon: const Icon(
                                                  Icons.delete_outline,
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
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  // Footer total and proceed
                  Container(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                    child: Row(
                      children: [
                        Text(
                          '\$ ' + cart.subtotal.toStringAsFixed(2),
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Spacer(),
                        ElevatedButton(
                          onPressed: cart.items.isEmpty
                              ? null
                              : () {
                                  context.push('/place-order');
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: cart.items.isEmpty
                                ? Colors.grey.shade300
                                : AppColors.primary,
                            foregroundColor: cart.items.isEmpty
                                ? Colors.grey.shade700
                                : Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 16,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: const Text('Place order'),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
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
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: AppColors.light,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Icon(icon, color: AppColors.primary),
      ),
    );
  }
}
