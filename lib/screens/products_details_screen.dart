import 'package:flutter/material.dart';

import '../model/product_model.dart';
import '../services/cart_service.dart';
import '../widgets/product_details/rating_bars.dart';
import '../widgets/product_details/related_item.dart';
import '../widgets/product_details/review_card.dart';
import '../widgets/product_details/small_dot.dart';
import '../widgets/product_details/spec_tile.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Product Details",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: Icon(Icons.favorite_border, color: Colors.black),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ Product Image
            SizedBox(
              height: 250,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  widget.product.thumbnail,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 10),

            // ✅ Dots below image fixed
            Center(
              child: Wrap(
                spacing: 6,
                children: [
                  SmallDot(color: Colors.deepOrange),
                  SmallDot(color: Colors.grey.shade400),
                  SmallDot(color: Colors.grey.shade400),
                ],
              ),
            ),
            const SizedBox(height: 15),

            // ✅ Product title and price fixed (prevent overflow)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    widget.product.title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  "\$${widget.product.price}",
                  style: const TextStyle(
                    fontSize: 22,
                    color: Colors.deepOrange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 6),

            // ✅ Rating stars
            Row(
              children: [
                Row(
                  children: List.generate(
                    widget.product.rating.toInt(),
                        (index) => const Icon(
                      Icons.star,
                      color: Colors.deepOrange,
                      size: 18,
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  "${widget.product.rating}",
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),

            const SizedBox(height: 20),

            const Text(
              "Specifications",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: const [
                  SpecTile(title: "Color:", value: "Brown"),
                  SizedBox(width: 10),
                  SpecTile(title: "Size:", value: "Medium"),
                  SizedBox(width: 10),
                  SpecTile(title: "Material:", value: "Full-grain Leather"),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // ✅ Quantity selector
            Row(
              children: [
                IconButton(
                  onPressed: () =>
                      setState(() => quantity > 1 ? quantity-- : null),
                  icon: const Icon(Icons.remove_circle_outline),
                  color: Colors.deepOrange,
                ),
                Text("$quantity", style: const TextStyle(fontSize: 18)),
                IconButton(
                  onPressed: () => setState(() => quantity++),
                  icon: const Icon(Icons.add_circle_outline),
                  color: Colors.deepOrange,
                ),
              ],
            ),

            const SizedBox(height: 10),

            // ✅ Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(14),
                      backgroundColor: Colors.deepOrange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      CartService.addToCart(widget.product);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "${widget.product.title} added to cart",
                          ),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                    child: const Text(
                      "Add to Cart",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.deepOrange),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(14),
                    ),
                    onPressed: () {},
                    child: const Text(
                      "Buy Now",
                      style: TextStyle(color: Colors.deepOrange, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            // ✅ Reviews
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Reviews",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text("Rate", style: TextStyle(color: Colors.deepOrange)),
              ],
            ),

            const SizedBox(height: 10),

            RatingBars(rating: widget.product.rating),

            const SizedBox(height: 20),

            const ReviewCard(
              name: "Mariam",
              comment: "Absolutely stunning bag! The leather is top-notch!",
              stars: 5,
            ),

            const ReviewCard(
              name: "Hagar",
              comment: "Very stylish. A bit smaller than expected.",
              stars: 3,
            ),

            const SizedBox(height: 25),

            const Text(
              "You might also like",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),

            const RelatedItem(
              title: "Leather Wallet",
              price: "\$45.00",
              image: 'assets/wallet.png',
            ),
            const RelatedItem(
              title: "Ankle Boots",
              price: "\$180.00",
              image: 'assets/image.png',
            ),
            const RelatedItem(
              title: "Classic Bag",
              price: "\$65.00",
              image: 'assets/image2.png',
            ),
          ],
        ),
      ),
    );
  }
}
