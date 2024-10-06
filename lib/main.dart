import 'package:flutter/material.dart';
import 'video_card.dart';
import 'add_video_card_screen.dart';
import 'video_card_detail.dart';
import 'favorites_screen.dart';
import 'profile_screen.dart';

void main() {
  runApp(const VideoCardsApp());
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
      home: const VideoCardsList(),
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
  final List<VideoCard> favorites = [];

  int _selectedIndex = 0;

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

  void _toggleFavorite(VideoCard videoCard) {
    setState(() {
      if (favorites.contains(videoCard)) {
        favorites.remove(videoCard);
      } else {
        favorites.add(videoCard);
      }
    });
  }

  void _updateProfile(String newName, String newSurname, String newPhone) {
    // Обновление профиля можно реализовать здесь
    // Например, сохранить данные в переменные или в состояние
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget getBody() {
      switch (_selectedIndex) {
        case 0:
          return _buildVideoCardsList();
        case 1:
          return FavoritesScreen(favorites: favorites);
        case 2:
          return ProfileScreen(onUpdateProfile: _updateProfile);
        default:
          return Container();
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Магазин Видеокарт'),
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
      body: getBody(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Видеокарты',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Избранное',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Профиль',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildVideoCardsList() {
    return ListView.builder(
      itemCount: videoCards.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(videoCards[index].name),
          subtitle: Text('\$${videoCards[index].price}'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(
                  favorites.contains(videoCards[index])
                      ? Icons.favorite
                      : Icons.favorite_border,
                ),
                onPressed: () => _toggleFavorite(videoCards[index]),
              ),
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddVideoCardScreen(
                        onAdd: _addVideoCard,
                        onEdit: (videoCard) => _editVideoCard(index, videoCard),
                        onDelete: (videoCard) => _deleteVideoCard(index),
                        videoCard: videoCards[index], // Передаем текущую видеокарту для редактирования
                      ),
                    ),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => _deleteVideoCard(index), // Удаляем видеокарту
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
    );
  }
}