import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';
import '../models/product.dart';

class ProductController extends GetxController {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref('products');
  final RxList<Product> products = <Product>[].obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  /// Fetch products from Firebase Realtime Database and update the observable list
  void fetchProducts() {
    _dbRef.onValue.listen((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;

      if (data != null) {
        products.clear(); // Clear the existing product list to avoid duplication
        data.forEach((key, value) {
          products.add(
            Product.fromJson(
              value as Map<dynamic, dynamic>, // Cast the value to Map
              id: key, // Pass the Firebase key as the product ID
            ),
          );
        });
      }
    });
  }

  /// Add a new product to Firebase
  Future<void> addProduct(Product product) async {
    try {
      final newRef = _dbRef.push(); // Generate a new key for the product
      await newRef.set(product.toJson()); // Save the product as JSON
    } catch (e) {
      Get.snackbar('Error', 'Failed to add product: $e');
    }
  }

  /// Delete a product from Firebase
  Future<void> deleteProduct(String productId) async {
    try {
      await _dbRef.child(productId).remove(); // Remove the product by ID
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete product: $e');
    }
  }

  /// Update an existing product in Firebase
  Future<void> updateProduct(String productId, Product updatedProduct) async {
    try {
      await _dbRef.child(productId).update(updatedProduct.toJson()); // Update the product fields
    } catch (e) {
      Get.snackbar('Error', 'Failed to update product: $e');
    }
  }
}
