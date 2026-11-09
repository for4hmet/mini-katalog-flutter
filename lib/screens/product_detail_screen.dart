import 'package:flutter/material.dart';

import '../models/product_model.dart';
import '../data/cart_data.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF4F46E5);
    const textColor = Color(0xFF111827);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ürün Detayı',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      // Ürün bilgileri
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ürün görsel alanı
            Container(
              width: double.infinity,
              height: 280,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: const Color(0xFFEDEEF3)),
              ),
              child: Image.asset(
                product.imageUrl,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.image_not_supported_outlined,
                    size: 70,
                    color: Colors.grey,
                  );
                },
              ),
            ),

            const SizedBox(height: 26),

            // Ürün adı
            Text(
              product.name,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),

            const SizedBox(height: 14),

            // Ürün fiyatı
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFFEDE9FE),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(
                '${product.price.toStringAsFixed(2)} TL',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ),

            const SizedBox(height: 28),

            // Ürün açıklaması kartı
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFEDEEF3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.info_outline_rounded, color: primaryColor),
                      SizedBox(width: 10),
                      Text(
                        'Ürün Açıklaması',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  Text(
                    product.description,
                    style: const TextStyle(
                      fontSize: 15,
                      height: 1.6,
                      color: Color(0xFF4B5563),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // Sabit sepete ekleme butonu
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(20, 14, 20, 14),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color(0x12000000),
              blurRadius: 12,
              offset: Offset(0, -3),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: SizedBox(
            height: 54,
            child: ElevatedButton.icon(
              onPressed: () {
                // Mevcut sepet sistemini koruyoruz
                addToCart(product);

                ScaffoldMessenger.of(context).hideCurrentSnackBar();

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${product.name} sepete eklendi!'),
                    duration: const Duration(seconds: 2),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart_outlined),
              label: const Text(
                'Sepete Ekle',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
