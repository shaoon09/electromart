import 'package:get/get.dart';
import '../models/product.dart';

class CartController extends GetxController {
  var cartItems = <Product>[].obs;

  // Add item to cart with quantity check
  void addToCart(Product product) {
    // Check if product already exists in cart
    var existingItem =
    cartItems.firstWhereOrNull((item) => item.id == product.id);

    if (existingItem == null) {
      cartItems.add(product);
    } else {
      // Show a snackbar indicating it's already in the cart
      Get.snackbar(
        "Already in Cart",
        "${product.name} is already in your cart.",
        snackPosition: SnackPosition.BOTTOM,

      );
    }
  }

  // Remove a specific product
  void removeFromCart(Product product) {
    cartItems.remove(product);
  }

  // Clear the cart
  void clearCart() {
    cartItems.clear();
  }

  // Calculate total price
  double get totalPrice =>
      cartItems.fold(0, (sum, item) => sum + item.price);

  // Check if cart is empty
  bool get isCartEmpty => cartItems.isEmpty;

  // Get total number of items in the cart
  int get totalItems => cartItems.length;
}
