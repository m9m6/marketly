
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/cart_screen.dart';
import 'package:flutter_application_1/screens/categories_screen.dart';

import '../model/category_model.dart';
import '../model/product_model.dart';
import '../services/api_service.dart';
import '../widgets/category_chip.dart';
import '../widgets/home_page/product_card.dart';
import '../widgets/home_page/promo_card.dart';
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

  @override
  void initState() {
    super.initState();
    productsFuture = ApiService.getProducts();
    categoriesFuture = ApiService.getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8f9fa),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: _buildSearchBox(),
      ),

      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomeContent(
            productsFuture: productsFuture,
            categoriesFuture: categoriesFuture,
            selectedCategorySlug: selectedCategorySlug,
            onCategorySelected: (slug) {
              setState(() {
                selectedCategorySlug = slug;
                productsFuture = slug.isEmpty
                    ? ApiService.getProducts()
                    : ApiService.getProductsByCategory(slug);
              });
            },
          ),
          const CategoriesScreen(),
          const CartScreen(),
          const ProfileScreen(),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: "Categories"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Cart"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
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
}

// THIS WAS THE FIX — NOW STATEFUL, NOT Stateless
class HomeContent extends StatefulWidget {
  final Future<List<Product>> productsFuture;
  final Future<List<CategoryModel>> categoriesFuture;
  final String selectedCategorySlug;
  final Function(String slug) onCategorySelected;

  const HomeContent({
    super.key,
    required this.productsFuture,
    required this.categoriesFuture,
    required this.selectedCategorySlug,
    required this.onCategorySelected,
  });

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  List<Product> productList = []; // stored here permanently

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildBanners(),
          _buildCategoryList(),
          _buildProductGrid(),
        ],
      ),
    );
  }

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
        future: widget.categoriesFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const CircularProgressIndicator();
          final categories = snapshot.data!;

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                CategoryChip(
                  category: CategoryModel(id: 0, name: "All", slug: ""),
                  selected: widget.selectedCategorySlug.isEmpty,
                  onSelected: (_) => widget.onCategorySelected(""),
                ),
                ...categories.map((cat) => CategoryChip(
                      category: cat,
                      selected: cat.slug == widget.selectedCategorySlug,
                      onSelected: (_) => widget.onCategorySelected(cat.slug),
                    )),
              ],
            ),
          );
        },
      );

  Widget _buildProductGrid() => FutureBuilder<List<Product>>(
        future: widget.productsFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Padding(
              padding: EdgeInsets.only(top: 60),
              child: CircularProgressIndicator(),
            );
          }

          /// Load products only once
          if (productList.isEmpty) {
            productList = snapshot.data!;
          }

          return Padding(
            padding: const EdgeInsets.all(10),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: productList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: 0.68,
              ),
              itemBuilder: (context, index) {
                return ProductCard(
                  product: productList[index],
                  onDelete: () {
                    setState(() {
                      productList.removeAt(index); // delete permanently
                    });
                  },
                );
              },
            ),
          );
        },
      );
}
