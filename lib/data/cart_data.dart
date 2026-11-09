import '../models/product_model.dart';

// Sepete eklenen ürünlerin listesi
final List<Product> cartItems = [];

// Ürünü sepete ekleme
void addToCart(Product product) {
  cartItems.add(product);
}
