import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodey/core/models/product.dart';

class CartItem {
  final Product product;
  final int quantity;

  const CartItem({required this.product, required this.quantity});

  CartItem copyWith({Product? product, int? quantity}) => CartItem(
    product: product ?? this.product,
    quantity: quantity ?? this.quantity,
  );

  double get lineTotal => product.price * quantity;
}

class CartState {
  final List<CartItem> items;
  const CartState({this.items = const []});

  double get subtotal => items.fold(0, (sum, i) => sum + i.lineTotal);
  int get totalItems => items.fold(0, (sum, i) => sum + i.quantity);
}

class CartNotifier extends StateNotifier<CartState> {
  CartNotifier() : super(const CartState());

  void add(Product product, {int quantity = 1}) {
    final idx = state.items.indexWhere((e) => e.product.id == product.id);
    if (idx == -1) {
      state = CartState(
        items: [
          ...state.items,
          CartItem(product: product, quantity: quantity),
        ],
      );
    } else {
      final updated = [...state.items];
      final existing = updated[idx];
      updated[idx] = existing.copyWith(quantity: existing.quantity + quantity);
      state = CartState(items: updated);
    }
  }

  void remove(String productId) {
    state = CartState(
      items: state.items.where((e) => e.product.id != productId).toList(),
    );
  }

  void setQuantity(String productId, int quantity) {
    if (quantity <= 0) {
      remove(productId);
      return;
    }
    final updated = state.items
        .map(
          (e) => e.product.id == productId ? e.copyWith(quantity: quantity) : e,
        )
        .toList();
    state = CartState(items: updated);
  }

  void clear() {
    state = const CartState(items: []);
  }
}

final cartProvider = StateNotifierProvider<CartNotifier, CartState>(
  (ref) => CartNotifier(),
);
