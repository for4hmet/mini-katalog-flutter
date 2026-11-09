import 'package:flutter/material.dart';

import 'data/product_data.dart';
import 'widgets/product_card.dart';
import 'screens/cart_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mini Katalog',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4F46E5)),
        scaffoldBackgroundColor: const Color(0xFFF7F8FC),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Color(0xFF111827),
          elevation: 0,
          surfaceTintColor: Colors.transparent,
        ),
      ),
      home: const MyHomePage(title: 'Mini Katalog'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String searchQuery = '';
  String selectedCategory = 'Tümü';

  final TextEditingController searchController = TextEditingController();

  final List<String> categories = ['Tümü', 'Teknoloji', 'Gaming'];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Arama ve kategori filtrelerini birlikte uygula
    final filteredProducts = products.where((product) {
      final matchesSearch = product.name.toLowerCase().contains(
        searchQuery.trim().toLowerCase(),
      );

      final matchesCategory =
          selectedCategory == 'Tümü' || product.category == selectedCategory;

      return matchesSearch && matchesCategory;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(Icons.storefront_rounded, color: Color(0xFF4F46E5)),
            const SizedBox(width: 10),
            Text(
              widget.title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Sepetim',
            icon: const Icon(
              Icons.shopping_bag_outlined,
              color: Color(0xFF4F46E5),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartScreen()),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),

      body: SafeArea(
        child: CustomScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Karşılama alanı
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(22),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF4F46E5), Color(0xFF7C3AED)],
                        ),
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Teknoloji Dünyasını Keşfet',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '${products.length} farklı teknoloji ve '
                            'gaming ürünü seni bekliyor!',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Arama kutusu
                    TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: 'Ürün veya marka ara...',
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Color(0xFF4F46E5),
                        ),
                        suffixIcon: searchQuery.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () {
                                  searchController.clear();
                                  setState(() {
                                    searchQuery = '';
                                  });
                                },
                              )
                            : null,
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          searchQuery = value;
                        });
                      },
                    ),

                    const SizedBox(height: 18),

                    // Kategori filtre butonları
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: categories.map((category) {
                          final isSelected = selectedCategory == category;

                          return Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: ChoiceChip(
                              label: Text(category),
                              selected: isSelected,
                              showCheckmark: false,
                              selectedColor: const Color(0xFF4F46E5),
                              backgroundColor: Colors.white,
                              labelStyle: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : const Color(0xFF4B5563),
                                fontWeight: FontWeight.w600,
                              ),
                              side: BorderSide(
                                color: isSelected
                                    ? const Color(0xFF4F46E5)
                                    : const Color(0xFFE5E7EB),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              onSelected: (_) {
                                setState(() {
                                  selectedCategory = category;
                                });
                              },
                            ),
                          );
                        }).toList(),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Ürün başlığı ve sayaç
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            searchQuery.isNotEmpty
                                ? 'Arama Sonuçları'
                                : selectedCategory == 'Tümü'
                                ? 'Tüm Ürünler'
                                : '$selectedCategory Ürünleri',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF111827),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 7,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEDE9FE),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '${filteredProducts.length} Ürün',
                            style: const TextStyle(
                              color: Color(0xFF4F46E5),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),

            // Ürün listesi
            if (filteredProducts.isEmpty)
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(32),
                  child: Center(
                    child: Text(
                      'Aradığınız ürün bulunamadı.',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 24),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return ProductCard(product: filteredProducts[index]);
                  }, childCount: filteredProducts.length),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.80,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
