import 'package:flutter/material.dart';

import '../models/product_model.dart';
import '../screens/product_detail_screen.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 2,
      shadowColor: Colors.black12,
      color: Colors.white,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(color: Color(0xFFEDEEF3)),
      ),

      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailScreen(product: product),
            ),
          );
        },

        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              // Ürün görseli
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8F9FC),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Image.asset(
                    product.imageUrl,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.image_not_supported_outlined,
                        size: 40,
                        color: Colors.grey,
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // Ürün adı
              SizedBox(
                height: 36,
                child: Center(
                  child: Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF111827),
                      height: 1.2,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 6),

              // Ürün fiyatı
              Text(
                '${product.price.toStringAsFixed(2)} TL',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF4F46E5),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
