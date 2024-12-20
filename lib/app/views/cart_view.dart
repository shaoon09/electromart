import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';

class CartView extends StatelessWidget {
  final CartController cartController = Get.find<CartController>();

  CartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
        actions: [
          IconButton(
            onPressed: () {
              if (cartController.cartItems.isEmpty) {
                Get.snackbar(
                  "Cart is Empty",
                  "There are no items to clear.",
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.redAccent.withOpacity(0.7),
                  colorText: Colors.white,
                );
                return;
              }
              cartController.clearCart();
              Get.snackbar(
                "Cart Cleared",
                "All items have been removed from your cart.",
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.green.withOpacity(0.7),
                colorText: Colors.white,
              );
            },
            icon: const Icon(Icons.delete_forever),
            tooltip: "Clear Cart",
          )
        ],
      ),
      body: Obx(() {
        if (cartController.cartItems.isEmpty) {
          return const Center(
            child: Text(
              "Your cart is empty!",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          );
        }

        return ListView.builder(
          itemCount: cartController.cartItems.length,
          itemBuilder: (context, index) {
            final item = cartController.cartItems[index];
            return Card(
              margin:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: ListTile(
                leading: Image.network(
                  item.imageUrl,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
                title: Text(
                  item.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  '\$${item.price.toStringAsFixed(2)}',
                  style: const TextStyle(color: Colors.green),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    cartController.removeFromCart(item);
                    Get.snackbar(
                      "Item Removed",
                      "${item.name} has been removed from your cart.",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.orangeAccent.withOpacity(0.7),
                      colorText: Colors.white,
                    );
                  },
                ),
              ),
            );
          },
        );
      }),
      bottomNavigationBar: Obx(() {
        return BottomAppBar(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            color: Colors.blueAccent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Total:",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "\$${cartController.totalPrice.toStringAsFixed(2)}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
