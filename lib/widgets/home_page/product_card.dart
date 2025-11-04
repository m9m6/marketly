import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/cart_service.dart';
import '../../../model/product_model.dart';
import '../../screens/products_details_screen.dart';
import '../../screens/cart_screen.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  final VoidCallback? onDelete;

  const ProductCard({
    super.key,
    required this.product,
    required this.onDelete,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsScreen(product: widget.product),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    child: Image.network(
                      widget.product.thumbnail,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.product.title,
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 14)),
                      const SizedBox(height: 4),
                      Text("\$${widget.product.price.toStringAsFixed(2)}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                              fontSize: 14)),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text("${widget.product.rating}",
                              style: const TextStyle(fontSize: 13)),
                          const SizedBox(width: 3),
                          const Icon(Icons.star,
                              color: Colors.amber, size: 14),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            ///  DELETE BUTTON WITH CONFIRMATION
            if (widget.onDelete != null)
              Positioned(
                right: 8,
                top: 8,
                child: InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("Delete Product"),
                        content: const Text(
                            "Are you sure you want to delete this product?"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context); // Close dialog
                            },
                            child: const Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context); // Close dialog
                              widget.onDelete!(); // Removes card from parent
                            },
                            child: const Text(
                              "OK",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  child: const CircleAvatar(
                    radius: 14,
                    backgroundColor: Colors.red,
                    child: Icon(Icons.delete, size: 16, color: Colors.white),
                  ),
                ),
              ),

            ///  ADD TO CART BUTTON
            Positioned(
              left: 8,
              top: 8,
              child: InkWell(
                onTap: () {
                  CartService.addToCart(widget.product);                     
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("${widget.product.title} added to cart"),
                      duration: const Duration(seconds: 1),
                    ),
                  );

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CartScreen(),
                    ),
                  );
                },
                child: const CircleAvatar(
                  radius: 14,
                  backgroundColor: Colors.blue,
                  child: Icon(Icons.shopping_cart,
                      size: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
