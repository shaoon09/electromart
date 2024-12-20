class Product {
  final String id;
  final String name;
  final String description; // Includes the description field
  final double price;
  final String imageUrl;

  // Constructor with all necessary fields
  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  // Factory constructor to create a Product from JSON
  factory Product.fromJson(Map<dynamic, dynamic> json, {required String id}) {
    return Product(
      id: id, // Firebase keys are passed here as the unique id
      name: json['name'] ?? 'Unknown Product',
      description: json['description'] ?? 'No description available',
      price: (json['price'] is num)
          ? (json['price'] as num).toDouble()
          : double.tryParse(json['price']?.toString() ?? '0.0') ?? 0.0,
      imageUrl: json['imageUrl'] ?? '',
    );
  }

  // Method to convert Product object to JSON (useful for Firebase or other storage)
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
    };
  }

  // Optional: Override toString for better debugging
  @override
  String toString() {
    return 'Product(id: $id, name: $name, description: $description, price: $price, imageUrl: $imageUrl)';
  }
}
