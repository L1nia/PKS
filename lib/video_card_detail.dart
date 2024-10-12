import 'package:flutter/material.dart';
import 'video_card.dart';
import 'cart.dart';

class VideoCardDetail extends StatelessWidget {
  final VideoCard videoCard;
  final Cart cart;
  final Function(VideoCard) toggleFavorite; 

  const VideoCardDetail({
    super.key,
    required this.videoCard,
    required this.cart,
    required this.toggleFavorite, 
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(videoCard.name),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border), 
            onPressed: () {
              toggleFavorite(videoCard); 
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(videoCard.imageUrl),
              const SizedBox(height: 8),
              Text(videoCard.name,
                  style:
                      const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(height: 16),
              Text('\$${videoCard.price}',
                  style:
                      const TextStyle(fontSize: 20, color: Colors.green)),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  cart.add(videoCard);
                  Navigator.of(context).pop(); 
                },
                child:
                    const Text('Купить'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}