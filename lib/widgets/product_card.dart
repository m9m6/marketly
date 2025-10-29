import 'package:flutter/material.dart';
import '../../../model/product_model.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  child: Image.network(product.thumbnail,
                      fit: BoxFit.cover, width: double.infinity),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 14,
                    child: const Icon(Icons.favorite_border,
                        color: Colors.redAccent, size: 18),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 14)),
                const SizedBox(height: 4),
                Text("\$${product.price.toStringAsFixed(2)}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                        fontSize: 14)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text("${product.rating}",
                        style: const TextStyle(fontSize: 13)),
                    const SizedBox(width: 3),
                    const Icon(Icons.star, color: Colors.amber, size: 14),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
