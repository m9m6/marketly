class Product {
  final int id;
  final String title;
  final String description;
  final double price;
  final double rating;
  final String thumbnail;
  final String category;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.rating,
    required this.thumbnail,
    required this.category,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      rating: (json['rating'] ?? 0).toDouble(),
      thumbnail: json['thumbnail'] ??
          'https://via.placeholder.com/150', // fallback image
      category: json['category'] ?? '',
    );
  }
}
