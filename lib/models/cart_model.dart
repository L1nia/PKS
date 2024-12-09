class CartModel {
  final int id;
  final int price;
  final String url; 
  final int count;

  CartModel({
    required this.id,
    required this.price,
    required this.url,
    required this.count
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['product_id'],
      price: json['price'],
      url: json['image_url'], 
      count: json['quantity']
    );
  }

  Map<String, dynamic> toJson() =>
    {
      'id': id,
      'price': price,
      'image_url': url,
      'quantity': count
    };
}