class Tovar {
  final int id;
  final String name;
  final String description;
  final int price;
  final String url; // Новое поле для изображения

  Tovar({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.url, // Новое поле для изображения
  });

  factory Tovar.fromJson(Map<String, dynamic> json) {
    return Tovar(
      id: json['product_id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      url: json['image_url'], // Предполагаем, что API возвращает это поле
    );
  }

  Map<String, dynamic> toJson() =>
    {
      'product_id': id,
      'name': name,
      'description': description,
      'price': price,
      'image_url': url,
    };
}