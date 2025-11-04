import 'dart:async';
import 'package:flutter/material.dart';
import '../model/category_model.dart';
import '../model/product_model.dart';
import '../services/api_service.dart';
import '../widgets/category_chip.dart';
import '../widgets/home_page/product_card.dart';
import 'cart_screen.dart';
import 'categories_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/HomeScreen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeContent(),
    const CategoriesScreen(),
    const CartScreen(),
     ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8f9fa),
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: _buildModernBottomNav(),
    );
  }

  Widget _buildModernBottomNav() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.deepOrange,
          unselectedItemColor: Colors.grey.shade500,
          showUnselectedLabels: false,
          currentIndex: _currentIndex,
          elevation: 0,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.grid_view_rounded),
              label: "Categories",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_rounded),
              label: "Cart",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  late Future<List<Product>> productsFuture;
  late Future<List<CategoryModel>> categoriesFuture;
  String selectedCategorySlug = '';
  int currentOffer = 0;

  List<Map<String, dynamic>> offers = [
    {
      "title": "Big Winter Sale",
      "subtitle": "Get up to 50% off selected items",
      "code": "WINTER50",
      "color": [Colors.deepOrange, Colors.orangeAccent],
    },
    {
      "title": "New Arrivals",
      "subtitle": "Check out the latest tech gear",
      "code": "NEWTECH25",
      "color": [Colors.indigo, Colors.blueAccent],
    },
    {
      "title": "Exclusive Deal",
      "subtitle": "Save 30% on your first purchase",
      "code": "WELCOME30",
      "color": [Colors.purple, Colors.pinkAccent],
    },
  ];

  @override
  void initState() {
    super.initState();
    productsFuture = ApiService.getProducts();
    categoriesFuture = ApiService.getCategories();

    Timer.periodic(const Duration(seconds: 4), (timer) {
      if (mounted) {
        setState(() {
          currentOffer = (currentOffer + 1) % offers.length;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: Column(
            children: [
              _buildHeader(),
              const SizedBox(height: 10),
              _buildSearchBox(),
              const SizedBox(height: 20),
              _buildOffersCarousel(),
              const SizedBox(height: 25),
              _buildCategoriesSection(),
              const SizedBox(height: 20),
              _buildProductsGrid(),
              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text("Welcome back,",
                  style: TextStyle(fontSize: 13, color: Colors.grey)),
              SizedBox(height: 2),
              Text("Mariam Badr",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ],
          ),
          Row(
            children: [
              Stack(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.notifications_none_rounded, size: 26),
                  ),
                  Positioned(
                    right: 10,
                    top: 10,
                    child: Container(
                      width: 9,
                      height: 9,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
              const CircleAvatar(
                radius: 20,
                backgroundColor: Colors.deepOrange,
                child: Text("MR", style: TextStyle(color: Colors.white)),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildSearchBox() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const TextField(
          decoration: InputDecoration(
            hintText: "Search products...",
            border: InputBorder.none,
            prefixIcon: Icon(Icons.search, color: Colors.grey),
            contentPadding: EdgeInsets.symmetric(vertical: 14),
          ),
        ),
      ),
    );
  }

  Widget _buildOffersCarousel() {
    final offer = offers[currentOffer];
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      transitionBuilder: (child, animation) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: const Offset(0, 0),
          ).animate(animation),
          child: child,
        );
      },
      child: Container(
        key: ValueKey<int>(currentOffer),
        margin: const EdgeInsets.symmetric(horizontal: 16),
        height: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: offer["color"].cast<Color>(),
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(offer["title"],
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                )),
            const SizedBox(height: 6),
            Text(offer["subtitle"],
                style: const TextStyle(color: Colors.white70, fontSize: 14)),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text("Code: ${offer["code"]}",
                      style: const TextStyle(color: Colors.white, fontSize: 12)),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.deepOrange,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text("Shop Now"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCategoriesSection() {
    return FutureBuilder<List<CategoryModel>>(
      future: categoriesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text("No categories available");
        }

        final categories = snapshot.data!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("Categories",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text("See All",
                      style: TextStyle(color: Colors.deepOrange, fontSize: 14)),
                ],
              ),
            ),
            SizedBox(
              height: 60,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  CategoryChip(
                    category: CategoryModel(id: 0, name: "All", slug: ""),
                    selected: selectedCategorySlug.isEmpty,
                    onSelected: (_) => _selectCategory(""),
                  ),
                  ...categories.map(
                        (cat) => CategoryChip(
                      category: cat,
                      selected: cat.slug == selectedCategorySlug,
                      onSelected: (_) => _selectCategory(cat.slug),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildProductsGrid() {
    return FutureBuilder<List<Product>>(
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
          padding: const EdgeInsets.symmetric(horizontal: 16),
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
            itemBuilder: (_, index) => ProductCard(
              product: products[index],
              onDelete: () {},
            ),
          ),
        );
      },
    );
  }


  void _selectCategory(String slug) {
    setState(() {
      selectedCategorySlug = slug;
      productsFuture = slug.isEmpty
          ? ApiService.getProducts()
          : ApiService.getProductsByCategory(slug);
    });
  }
}