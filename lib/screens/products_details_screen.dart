import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/product_model.dart';
import 'package:flutter_application_1/widgets/product_details/small_dot.dart';
import 'package:flutter_application_1/widgets/product_details/spec_tile.dart';
import 'package:flutter_application_1/widgets/product_details/rating_bars.dart';
import 'package:flutter_application_1/widgets/product_details/review_card.dart';
import 'package:flutter_application_1/widgets/product_details/related_item.dart';

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
        title: const Text("Product Details",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: Icon(Icons.favorite_border, color: Colors.black),
          )
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Product Image
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

            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SmallDot(color: Colors.orange),
                  SmallDot(color: Colors.grey.shade400),
                  SmallDot(color: Colors.grey.shade400),
                ],
              ),
            ),
            const SizedBox(height: 15),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.product.title,
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.product.price.toString(),
                  style: const TextStyle(
                    fontSize: 22,
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            Row(
              children: [
                Row(
                  children: List.generate(
                    widget.product.rating.toInt(),
                    (index) => const Icon(Icons.star, color: Colors.orange, size: 18),
                  ),
                ),
                const SizedBox(width: 6),
                Text("${widget.product.rating}", style: const TextStyle(color: Colors.grey)),
              ],
            ),

            const SizedBox(height: 20),

            const Text("Specifications",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                SpecTile(title: "Color:", value: "Brown"),
                SpecTile(title: "Size:", value: "Medium"),
                SpecTile(title: "Material:", value: "Full-grain Leather"),
              ],
            ),

            const SizedBox(height: 18),

            Row(
              children: [
                IconButton(
                  onPressed: () => setState(() => quantity > 1 ? quantity-- : null),
                  icon: const Icon(Icons.remove_circle_outline),
                  color: Colors.teal,
                ),
                Text("$quantity", style: const TextStyle(fontSize: 18)),
                IconButton(
                  onPressed: () => setState(() => quantity++),
                  icon: const Icon(Icons.add_circle_outline),
                  color: Colors.teal,
                ),
              ],
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(14),
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () {},
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
                        side: const BorderSide(color: Colors.teal),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.all(14)),
                    onPressed: () {},
                    child: const Text(
                      "Buy Now",
                      style: TextStyle(color: Colors.teal, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Reviews",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text("Rate", style: TextStyle(color: Colors.orange))
              ],
            ),

            const SizedBox(height: 10),

            RatingBars(rating: widget.product.rating),

            const SizedBox(height: 20),

            const ReviewCard(
              name: "Jane Doe",
              comment: "Absolutely stunning bag! The leather is top-notch!",
              stars: 5,
            ),

            const ReviewCard(
              name: "John Smith",
              comment: "Very stylish. A bit smaller than expected.",
              stars: 3,
            ),

            const SizedBox(height: 25),

            const Text(
              "You might also like",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),

            const RelatedItem(title: "Leather Wallet", price: "\$45.00", image: "assets/wallet.jpg"),
            const RelatedItem(title: "Ankle Boots", price: "\$180.00", image: "assets/boots.jpg"),
            const RelatedItem(title: "Classic Bag", price: "\$65.00", image: "assets/bag.webp"),
          ],
        ),
      ),
    );
  }
}
