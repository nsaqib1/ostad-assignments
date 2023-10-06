// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProductModel {
  final String imageUrl;
  final String name;
  final String color;
  final String size;
  final double price;
  int qty = 1;

  ProductModel({
    required this.imageUrl,
    required this.name,
    required this.color,
    required this.size,
    required this.price,
  });
}
