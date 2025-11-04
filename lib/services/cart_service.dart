import '../model/product_model.dart';

class CartService {
  static List<Product> cartList = [];

  static double getTotal() {
    double total = 0;
    for (var item in cartList) {
      total += item.price;
    }
    return total;
  }

  static void addToCart(Product product) {
    cartList.add(product);
  }

  static void removeFromCart(int index) {
    cartList.removeAt(index);
  }

  static void clearCart() {
    cartList.clear();
  }
}
