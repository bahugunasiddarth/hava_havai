class Product {
  final int id;
  final String title;
  final String thumbnail;
  final double price;
  final double discountPercentage;

  Product({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.price,
    required this.discountPercentage,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      thumbnail: json['thumbnail'],
      price: json['price'].toDouble(),
      discountPercentage: json['discountPercentage'].toDouble(),
    );
  }

  double get discountedPrice => price * (1 - discountPercentage / 100);
}
