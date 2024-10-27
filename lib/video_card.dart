class VideoCard {
     final String name;
     final String imageUrl;
     final double price;
     final String description;

     VideoCard({required this.name, required this.imageUrl, required this.price, required id, required this.description});
   
    factory VideoCard.fromJson(Map<String, dynamic> json) {
    return VideoCard(
      id: json['ID'],
      imageUrl: json['ImageURL'],
      name: json['Name'],
      price: json['Price'].toDouble(),
      description: json['Description']
    );
   }
}