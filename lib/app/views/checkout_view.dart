import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';
import 'package:firebase_database/firebase_database.dart';

class CheckoutView extends StatelessWidget {
  final CartController cartController = Get.find<CartController>();
  final DatabaseReference ordersRef =
  FirebaseDatabase.instance.ref('orders'); // Firebase orders node

  CheckoutView({Key? key}) : super(key: key);

  void _placeOrder() async {
    if (cartController.cartItems.isEmpty) {
      Get.snackbar("Cart is Empty", "Please add items to your cart before checking out.");
      return;
    }

    try {
      // Creating an order summary
      final orderData = {
        'items': cartController.cartItems.map((item) => {
          'id': item.id,
          'name': item.name,
          'price': item.price,
          'imageUrl': item.imageUrl,
        }).toList(),
        'total': cartController.totalPrice,
        'date': DateTime.now().toIso8601String(),
      };

      // Push order data to Firebase
      await ordersRef.push().set(orderData);

      // Clear cart after placing the order
      cartController.cartItems.clear();

      // Notify user
      Get.snackbar("Success", "Your order has been placed successfully!");
      Get.offAllNamed('/productList'); // Redirect to product list
    } catch (e) {
      Get.snackbar("Error", "Failed to place order. Please try again.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (cartController.cartItems.isEmpty) {
                return const Center(
                  child: Text("Your cart is empty."),
                );
              }
              return ListView.builder(
                itemCount: cartController.cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartController.cartItems[index];
                  return ListTile(
                    leading: Image.network(item.imageUrl, width: 50, height: 50),
                    title: Text(item.name),
                    subtitle: Text("\$${item.price}"),
                  );
                },
              );
            }),
          ),
          const Divider(height: 1, color: Colors.grey),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Obx(() {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Total: \$${cartController.totalPrice.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _placeOrder,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 15),
                    ),
                    child: const Text(
                      "Place Order",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
