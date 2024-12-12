// import 'package:flutter_application_1/models/cart_model.dart';

class Order {
  final int id;
  final int user;
  final int total;
  final String status;
  // final List<CartModel>products;

  Order({
    required this.id,
    required this.user,
    required this.total,
    required this.status,
    // required this.products
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['order_id'],
      user: json['user_id'],
      total: json['total'],
      status: json['status'],
      // products: json['cart_products'],
    );
  }

  Map<String, dynamic> toJson() =>
    {
      'porder_id': id,
      'user_id': user,
      'total': total,
      'status': status,
      // 'cart_products': products,
    };
}