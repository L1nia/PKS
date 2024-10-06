import 'package:flutter/material.dart';
import 'video_card.dart';

class FavoritesScreen extends StatelessWidget {
  final List<VideoCard> favorites;

  const FavoritesScreen({super.key, required this.favorites});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Избранное')),
      body: ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(favorites[index].name),
            subtitle: Text('\$${favorites[index].price}'),
          );
        },
      ),
    );
  }
}