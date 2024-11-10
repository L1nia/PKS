class VideoCard {
  final int id;
  final String imageUrl;
  final String name;
  final String description;
  final double price;

  VideoCard({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.description,
    required this.price,
  });

  factory VideoCard.fromJson(Map<String, dynamic> json) {
    return VideoCard(
      id: json['id'],
      imageUrl: json['imageUrl'],
      name: json['name'],
      description: json['description'],
      price: json['price'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'name': name,
      'description': description,
      'price': price.toDouble(),
    };
  }
}