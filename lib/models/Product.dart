class Product {
  final String id;
  String name;
  String description;
  double price;
  String? imageUrl;
  bool isAvailable;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.imageUrl,
    this.isAvailable = true,
  });

  // Getters
  String get getId => id;
  String get getName => name;
  String get getDescription => description;
  double get getPrice => price;
  String? get getImageUrl => imageUrl;
  bool get getIsAvailable => isAvailable;
}
