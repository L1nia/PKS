import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_4/cart_screen.dart';
import 'video_card.dart';
import 'add_video_card_screen.dart';
import 'video_card_detail.dart';
import 'favorites_screen.dart';
import 'profile_screen.dart';
import 'cart.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
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
  final List<VideoCard> videoCards = [VideoCard(id: 1, name: 'NVIDIA GEFORCE GTX 1080 Ti', imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTP_a8-t33HEfFvhddCYIb_4L6E0_AjA3rPpg&s', price: 109.99)];
  final List<VideoCard> favorites = [];
  final Cart cart = Cart();
  
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }


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

  void _updateProfile(String newName, String newSurname, String newPhone) {}

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
          return FavoritesScreen(favorites: favorites, cart: cart);
        case 2:
          return ProfileScreen(onUpdateProfile: _updateProfile);
        case 3:
          return CartScreen(cart: cart);
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
            icon: Icon(Icons.home, color: Colors.black),
            label: 'Видеокарты',
            backgroundColor: Color.fromARGB(255, 198, 193, 152),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite, color: Colors.black),
            label: 'Избранное',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.black),
            label: 'Профиль',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_shopping_cart, color: Colors.black),
            label: 'Корзина',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

 Widget _buildVideoCardsList() {
  return GridView.builder(
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: 0.6,
    ),
    itemCount: videoCards.length,
    itemBuilder: (context, index) {
      final videoCard = videoCards[index];
      final isFavorite = favorites.contains(videoCard); 

      return Card(
        elevation: 2,
        margin: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(videoCard.imageUrl),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                videoCard.name,
                style: const TextStyle(color: Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                '\$${videoCard.price}',
                style: const TextStyle(color: Colors.green),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VideoCardDetail(videoCard: videoCard, cart: cart, toggleFavorite: _toggleFavorite),
                      ),
                    );
                  },
                  child: const Text('Просмотреть'),
                ),
                IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : Colors.grey,
                  ),
                  onPressed: () {
                    _toggleFavorite(videoCard); 
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}