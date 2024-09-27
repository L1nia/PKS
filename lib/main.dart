import 'package:flutter/material.dart';
import 'video_card.dart';
import 'add_video_card_screen.dart';
import 'video_card_detail.dart'; 

void main() {
  runApp(VideoCardsApp());
}

class VideoCardsApp extends StatelessWidget {
  const VideoCardsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Магазин Видеокарт',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color.fromARGB(255, 218, 210, 210),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
        ),
      ),
      home: VideoCardsList(),
    );
  }
}

class VideoCardsList extends StatefulWidget {
  const VideoCardsList({super.key});

  @override
  _VideoCardsListState createState() => _VideoCardsListState();
}

class _VideoCardsListState extends State<VideoCardsList> {
  final List<VideoCard> videoCards = [];

  void _addVideoCard(VideoCard videoCard) {
    setState(() {
      videoCards.add(videoCard);
    });
  }

  void _editVideoCard(int index, VideoCard videoCard) {
    setState(() {
      videoCards[index] = videoCard;
    });
  }

  void _deleteVideoCard(int index) {
    setState(() {
      videoCards.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Доступные Видеокарты'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddVideoCardScreen(
                    onAdd: _addVideoCard,
                    onEdit: (videoCard) {},
                    onDelete: (videoCard) {},
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: videoCards.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(videoCards[index].name),
            subtitle: Text('\$${videoCards[index].price}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddVideoCardScreen(
                          onAdd: _addVideoCard,
                          onEdit: (videoCard) => _editVideoCard(index, videoCard),
                          onDelete: (videoCard) {},
                          videoCard: videoCards[index],
                        ),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    _deleteVideoCard(index);
                  },
                ),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VideoCardDetail(videoCard: videoCards[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
  
