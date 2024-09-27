import 'package:flutter/material.dart';
import 'video_card.dart';

class VideoCardDetail extends StatelessWidget {
  final VideoCard videoCard;

  const VideoCardDetail({super.key, required this.videoCard});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title :Text(videoCard.name)),
      body :Center (
        child :Padding (
          padding :const EdgeInsets.all(16.0),
          child :Column (
            mainAxisAlignment :MainAxisAlignment.center ,
            crossAxisAlignment :CrossAxisAlignment.center ,
            children :[
              Image.network(videoCard.imageUrl),
              const SizedBox(height :8),
              Text(videoCard.name ,
                  style :const TextStyle(fontSize :24 ,fontWeight :FontWeight.bold ,color :Colors.white)),
              const SizedBox(height :16),
              Text('\$${videoCard.price}' ,
                  style :const TextStyle(fontSize :20 ,color :Colors.green)),
              const SizedBox(height :20),
              ElevatedButton (
                onPressed :() {
                  showDialog (
                    context :context ,
                    builder :(context ) =>
                        AlertDialog (
                          title :
                              Text('Купить ${videoCard.name}' ,style :const TextStyle(color :Colors.black)),
                          content :
                              const Text('Вы уверены, что хотите купить этот товар?' ,style :TextStyle(color :Colors.black)),
                          actions :[
                            TextButton (
                              onPressed :() {Navigator.of(context).pop();},
                              child :
                                  const Text('Да' ,style :TextStyle(color :Colors.black)),
                            ),
                            TextButton (
                              onPressed :() {Navigator.of(context).pop();},
                              child :
                                  const Text('Нет' ,style :TextStyle(color :Colors.black)),
                            ),
                          ],
                        ),
                  );
                },
                child :
                    const Text('Купить'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}