import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product.dart';

class CartItem {
  Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]);

  void addToCart(Product product) {
    state = [...state, CartItem(product: product)];
  }

  void removeFromCart(int productId) {
    state = state.where((item) => item.product.id != productId).toList();
  }

  void updateQuantity(int productId, int quantity) {
    state =
        state.map((item) {
          if (item.product.id == productId) {
            return CartItem(product: item.product, quantity: quantity);
          }
          return item;
        }).toList();
  }

  double get totalPrice => state.fold(
    0,
    (sum, item) => sum + (item.product.discountedPrice * item.quantity),
  );
}

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>(
  (ref) => CartNotifier(),
);
