import 'package:codroid_hub/modules/cart/model/cart_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>(
  (ref) => CartNotifier(),
);

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]);

  void addItemToCart(CartItem newItem) {
    state = [...state, newItem];
  }

  void removeItemFromCart(String productId) {
    state = state.where((item) => item.productId != productId).toList();
  }

  void updateItemQuantity(String productId, int newQuantity) {
    state = state.map((item) {
      if (item.productId == productId) {
        return item.copyWith(quantity: newQuantity);
      }
      return item;
    }).toList();
  }
}

extension CartItemExtensions on CartItem {
  CartItem copyWith({int? quantity}) {
    return CartItem(
      productId: productId,
      productName: productName,
      price: price,
    );
  }
}