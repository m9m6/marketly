import 'package:flutter/material.dart';
import 'package:marketly/screens/cart_screen.dart';
import 'package:marketly/screens/categories_screen.dart';

import '../model/category_model.dart';
import '../model/product_model.dart';
import '../services/api_service.dart';
import '../widgets/category_chip.dart';
import '../widgets/home_page/product_card.dart';
import '../widgets/home_page/promo_card.dart';

// صفحات افتراضية للتنقل

import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/HomeScreen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Product>> productsFuture;
  late Future<List<CategoryModel>> categoriesFuture;
  String selectedCategorySlug = '';

  int _currentIndex = 0;

  final List<String> _routes = [
    HomeScreen.routeName,
    CategoriesScreen.routeName,
    CartScreen.routeName,
    ProfileScreen.routeName,
  ];

  @override
  void initState() {
    super.initState();
    productsFuture = ApiService.getProducts();
    categoriesFuture = ApiService.getCategories();
  }

  void _onNavTapped(int index) {
    if (index == _currentIndex) return;

    setState(() {
      _currentIndex = index;
    });

    Navigator.pushNamed(context, _routes[index]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8f9fa),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: _buildSearchBox(),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: CircleAvatar(
              backgroundColor: Colors.orange.shade100,
              child: const Icon(Icons.person, color: Colors.orange),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildBanners(),
            _buildCategoryList(),
            _buildProductGrid(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildSearchBox() => Container(
    height: 45,
    decoration: BoxDecoration(
      color: Colors.grey.shade200,
      borderRadius: BorderRadius.circular(12),
    ),
    child: const TextField(
      decoration: InputDecoration(
        hintText: "Search for products...",
        border: InputBorder.none,
        prefixIcon: Icon(Icons.search, color: Colors.grey),
        contentPadding: EdgeInsets.symmetric(vertical: 12),
      ),
    ),
  );

  Widget _buildBanners() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
    child: Row(
      children: const [
        Expanded(
          child: PromoCard(
            imageUrl:
            'https://images.unsplash.com/photo-1541099649105-f69ad21f3246',
            title: 'New Arrivals',
            subtitle: 'Check out the latest fashion',
            color: Colors.black,
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: PromoCard(
            imageUrl:
            'https://images.unsplash.com/photo-1526170375885-4d8ecf77b99f',
            title: 'Sale',
            subtitle: 'Up to 50% Off',
            color: Colors.green,
          ),
        ),
      ],
    ),
  );

  Widget _buildCategoryList() => FutureBuilder<List<CategoryModel>>(
    future: categoriesFuture,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return Text('Error loading categories: ${snapshot.error}');
      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
        return const Text("No categories available");
      }

      final categories = snapshot.data!;

      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            CategoryChip(
              category: CategoryModel(id: 0, name: "All", slug: ""),
              selected: selectedCategorySlug.isEmpty,
              onSelected: (isSelected) {
                setState(() {
                  selectedCategorySlug = '';
                  productsFuture = ApiService.getProducts();
                });
              },
            ),
            ...categories.map((cat) => CategoryChip(
              category: cat,
              selected: cat.slug == selectedCategorySlug,
              onSelected: (_) {
                setState(() {
                  selectedCategorySlug = cat.slug;
                  productsFuture =
                      ApiService.getProductsByCategory(cat.slug);
                });
              },
            ))
          ],
        ),
      );
    },
  );

  Widget _buildProductGrid() => FutureBuilder<List<Product>>(
    future: productsFuture,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Padding(
          padding: EdgeInsets.only(top: 60),
          child: CircularProgressIndicator(),
        );
      } else if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
        return const Text("No products available");
      }

      final products = snapshot.data!;

      return Padding(
        padding: const EdgeInsets.all(10),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: products.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            childAspectRatio: 0.68,
          ),
          itemBuilder: (_, index) =>
              ProductCard(product: products[index], onDelete: () {}),
        ),
      );
    },
  );

  Widget _buildBottomNav() => BottomNavigationBar(
    selectedItemColor: Colors.green,
    unselectedItemColor: Colors.grey,
    currentIndex: _currentIndex,
    type: BottomNavigationBarType.fixed,
    onTap: _onNavTapped,
    items: const [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
      BottomNavigationBarItem(icon: Icon(Icons.category), label: "Categories"),
      BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Cart"),
      BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
    ],
  );
}
