import 'package:flutter/material.dart';
import 'cart.dart';
import 'video_card.dart';

class CartScreen extends StatelessWidget {
  final Cart cart;

  const CartScreen({super.key, required this.cart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Корзина')),
      body: ListView.builder(
        itemCount: cart.getItems().length,
        itemBuilder: (context, index) {
          VideoCard videoCard = cart.getItems()[index];
          return Dismissible(
            key: Key(videoCard.name), 
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              cart.remove(videoCard);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${videoCard.name} удален из корзины'),
                ),
              );
            },
            child: Card(
              elevation: 2,
              margin: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(videoCard.name, style: const TextStyle(color: Colors.black)),
                          Text('\$${videoCard.price}', style: const TextStyle(color: Colors.green)),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 80, 
                      height: 80, 
                      child: Image.network(videoCard.imageUrl, fit: BoxFit.cover),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}