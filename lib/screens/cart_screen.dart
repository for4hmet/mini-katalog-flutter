import 'package:flutter/material.dart';

import '../data/cart_data.dart';

// Fiyatları Türkçe para biçiminde gösterir.
// Örnek: 1499.99 -> 1.499,99 TL
String formatPrice(double price) {
  final parts = price.toStringAsFixed(2).split('.');

  final wholePart = parts[0].replaceAllMapped(
    RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
    (match) => '${match[1]}.',
  );

  return '$wholePart,${parts[1]} TL';
}

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  static const primaryColor = Color(0xFF4F46E5);
  static const textColor = Color(0xFF111827);

  @override
  Widget build(BuildContext context) {
    // Sepetteki ürünlerin toplam fiyatı
    final total = cartItems.fold<double>(
      0,
      (sum, product) => sum + product.price,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sepetim',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Center(
            child: Container(
              margin: const EdgeInsets.only(right: 18),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
              decoration: BoxDecoration(
                color: const Color(0xFFEDE9FE),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '${cartItems.length} Ürün',
                style: const TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),

      // Sepet içeriği
      body: cartItems.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(28),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(30),
                      decoration: const BoxDecoration(
                        color: Color(0xFFEDE9FE),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.shopping_cart_outlined,
                        size: 70,
                        color: primaryColor,
                      ),
                    ),

                    const SizedBox(height: 24),

                    const Text(
                      'Sepetiniz Henüz Boş',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      'Beğendiğiniz ürünleri sepetinize '
                      'ekleyerek alışverişe başlayabilirsiniz.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 26),

                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_rounded),
                      label: const Text('Ürünlere Göz At'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 22,
                          vertical: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          // Sepetteki ürün kartları
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: cartItems.length,
              separatorBuilder: (context, index) {
                return const SizedBox(height: 12);
              },
              itemBuilder: (context, index) {
                final product = cartItems[index];

                return Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: const Color(0xFFEDEEF3)),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x08000000),
                        blurRadius: 10,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      // Ürün görseli
                      Container(
                        width: 85,
                        height: 90,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8F9FC),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Image.asset(
                          product.imageUrl,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.image_not_supported,
                              color: Colors.grey,
                            );
                          },
                        ),
                      ),

                      const SizedBox(width: 14),

                      // Ürün adı ve fiyatı
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: textColor,
                              ),
                            ),

                            const SizedBox(height: 10),

                            Text(
                              formatPrice(product.price),
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 6),

                      // Ürünü sepetten silme
                      IconButton(
                        tooltip: 'Ürünü Sil',
                        onPressed: () {
                          setState(() {
                            cartItems.removeAt(index);
                          });
                        },
                        icon: const Icon(
                          Icons.delete_outline_rounded,
                          color: Color(0xFFEF4444),
                        ),
                        style: IconButton.styleFrom(
                          backgroundColor: const Color(0xFFFEF2F2),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

      // Ekranın altında sabit toplam tutar
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 16),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color(0x12000000),
              blurRadius: 14,
              offset: Offset(0, -3),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Toplam Tutar',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                  ),

                  Text(
                    formatPrice(total),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              Text(
                '${cartItems.length} ürün sepette',
                style: const TextStyle(color: Colors.grey, fontSize: 13),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
