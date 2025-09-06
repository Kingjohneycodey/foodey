import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodey/core/models/product.dart';

class FavoritesState {
  final List<Product> items;
  const FavoritesState({this.items = const []});
}

class FavoritesNotifier extends StateNotifier<FavoritesState> {
  FavoritesNotifier() : super(const FavoritesState());

  void add(Product product) {
    if (!state.items.any((item) => item.id == product.id)) {
      state = FavoritesState(items: [...state.items, product]);
    }
  }

  void remove(String productId) {
    state = FavoritesState(
      items: state.items.where((item) => item.id != productId).toList(),
    );
  }

  bool isFavorite(String productId) {
    return state.items.any((item) => item.id == productId);
  }

  void toggle(Product product) {
    if (isFavorite(product.id)) {
      remove(product.id);
    } else {
      add(product);
    }
  }
}

final favoritesProvider =
    StateNotifierProvider<FavoritesNotifier, FavoritesState>(
      (ref) => FavoritesNotifier(),
    );
