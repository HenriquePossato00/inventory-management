class Product {
  final String id;
  final String name;
  final int quantity;
  final double price;

  Product({
    required this.id,
    required this.name,
    required this.quantity,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json["id"],
      name: json["name"],
      quantity: json["quantity"],
      price: (json["price"] as num).toDouble(),
    );
  }
}