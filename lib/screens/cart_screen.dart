import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/cart_provider.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);
    final cartNotifier = ref.read(cartProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Shopping Cart')),
      body:
          cartItems.isEmpty
              ? const Center(child: Text('Your cart is empty'))
              : ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return ListTile(
                    leading: Image.network(
                      item.product.thumbnail,
                      width: 50,
                      height: 50,
                    ),
                    title: Text(item.product.title),
                    subtitle: Text(
                      "₹${item.product.discountedPrice.toStringAsFixed(2)} x ${item.quantity}",
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () {
                            if (item.quantity > 1) {
                              cartNotifier.updateQuantity(
                                item.product.id,
                                item.quantity - 1,
                              );
                            } else {
                              cartNotifier.removeFromCart(item.product.id);
                            }
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed:
                              () => cartNotifier.updateQuantity(
                                item.product.id,
                                item.quantity + 1,
                              ),
                        ),
                      ],
                    ),
                  );
                },
              ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          "Total: ₹${ref.watch(cartProvider.notifier).totalPrice.toStringAsFixed(2)}",
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
