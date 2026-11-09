class Product {
  final int id;
  final String name;
  final double price;
  final String description;
  final String imageUrl;
  final String category;

  // Ürün constructor
  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.imageUrl,
    this.category = 'Teknoloji',
  });

  // JSON verisini Product nesnesine dönüştürme
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: (json['price'] as num).toDouble(),
      description: json['description'],
      imageUrl: json['imageUrl'],
      category: json['category'] as String? ?? 'Teknoloji',
    );
  }

  // Product nesnesini JSON verisine dönüştürme
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
      'imageUrl': imageUrl,
      'category': category,
    };
  }
}
