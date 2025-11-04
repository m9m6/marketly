import '../model/category_model.dart';
import '../model/product_model.dart';
import 'package:dio/dio.dart';


class ApiService {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://dummyjson.com',
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      headers: {'Accept': 'application/json'},
    ),
  );

  //  Fetch Categories
  static Future<List<CategoryModel>> getCategories() async {
    try {
      final response = await _dio.get('/products/categories');

      if (response.statusCode == 200) {
        final List data = response.data;
        return data.map((json) => CategoryModel.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load categories");
      }
    } catch (e) {
      throw Exception("Error fetching categories: $e");
    }
  }

  // Fetch All Products
  static Future<List<Product>> getProducts() async {
    try {
      final response = await _dio.get('/products');

      if (response.statusCode == 200) {
        final List data = response.data['products'];
        return data.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load products");
      }
    } catch (e) {
      throw Exception("Error fetching products: $e");
    }
  }

  // Fetch Products by Category
  static Future<List<Product>> getProductsByCategory(String category) async {
    try {
      final response = await _dio.get('/products/category/$category');

      if (response.statusCode == 200) {
        final List data = response.data['products'];
        return data.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load products for category: $category");
      }
    } catch (e) {
      throw Exception("Error fetching products by category: $e");
    }
  }
}

