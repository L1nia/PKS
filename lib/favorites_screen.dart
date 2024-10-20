import 'package:flutter/material.dart';
import 'video_card.dart';
import 'cart.dart';
import 'video_card_detail.dart';

class FavoritesScreen extends StatelessWidget {
  final List<VideoCard> favorites;
  final Cart cart;

  const FavoritesScreen({super.key, required this.favorites, required this.cart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
        AppBar(title:
          const Text('Избранное')),
      body:
        GridView.builder(
          gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:
              2,
              childAspectRatio:
                0.6),
          itemCount:
            favorites.length,
          itemBuilder:(context, index) {
            final videoCard =
              favorites[index];

            return Card(
              elevation:
                2,
              margin:
                const EdgeInsets.all(8.0),
              child:
                Column(crossAxisAlignment:
                  CrossAxisAlignment.center,
                  children:[
                    Image.network(videoCard.imageUrl),
                    Padding(padding:
                      const EdgeInsets.all(4.0),
                      child:
                        Text(videoCard.name, style:
                          const TextStyle(color:
                            Colors.black)
                            )
                    ),
                    Padding(padding:
                      const EdgeInsets.all(4.0),
                      child:
                        Text('\$${videoCard.price}', style:
                          const TextStyle(color:
                            Colors.green)
                            )
                    ),
                    Row(mainAxisAlignment:
                      MainAxisAlignment.spaceEvenly,
                      children:[
                        ElevatedButton(onPressed:( ) {
                          Navigator.push(context, MaterialPageRoute(builder:(context) =>
                            VideoCardDetail(videoCard:
                              videoCard, cart:
                              cart, toggleFavorite:(videoCard){})
                              )
                          );
                        }, child:
                          const Text('Просмотреть')),
                      ]),
                  ]),
            );
          },
        )
    );
   }
}