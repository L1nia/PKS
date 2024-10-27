import 'package:flutter/material.dart';
import 'package:flutter_application_4/cart_screen.dart';
import 'video_card.dart';
import 'add_video_card_screen.dart';
import 'video_card_detail.dart';
import 'favorites_screen.dart';
import 'profile_screen.dart';
import 'cart.dart';
import 'package:dio/dio.dart';

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
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          color: Colors.blueAccent,
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: Colors.blueAccent,
          unselectedItemColor: Colors.grey,
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
  List<VideoCard> videoCards = []; 
  final List<VideoCard> favorites = [];
  final Cart cart = Cart();
  
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    fetchVideoCards(); 
  }

  Future<void> fetchVideoCards() async {
    try {
      final response = await Dio().get('http://localhost:8080/products/all'); 

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = response.data;
        setState(() {
          videoCards = jsonResponse.map((data) => VideoCard.fromJson(data)).toList();
        });
      } else {
        throw Exception('Failed to load video cards');
      }
    } catch (e) {
      print('Ошибка: $e');
    }
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
          return ProfileScreen(onUpdateProfile: (name, surname, phone) {});
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
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartScreen(cart: cart)),
              );
            },
          ),
        ],
      ),
      body: getBody(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Главная'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Избранное'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Профиль'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

 Widget _buildVideoCardsList() {
   if (videoCards.isEmpty) {
     return const Center(
       child: Text(
         'Товары не найдены',
         style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
       ),
     );
   }
   
   return GridView.builder(
     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
       crossAxisCount: 2,
       childAspectRatio: 0.7,
     ),
     itemCount: videoCards.length,
     itemBuilder: (context, index) {
       final videoCard = videoCards[index];
       final isFavorite = favorites.contains(videoCard); 

       return Card(
         elevation: 4,
         margin: const EdgeInsets.all(10.0),
         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.center,
           children: [
             ClipRRect(
               borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
               child: Image.network(videoCard.imageUrl, fit: BoxFit.cover),
             ),
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: Text(
                 videoCard.name,
                 style: const TextStyle(fontWeight: FontWeight.bold),
               ),
             ),
             Padding(
               padding: const EdgeInsets.symmetric(vertical: 4.0),
               child: Text(
                 '\$${videoCard.price}',
                 style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
               ),
             ),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               children: [
                 ElevatedButton(
                   style:
                     ElevatedButton.styleFrom(backgroundColor : Colors.blueAccent),
                   onPressed : () {
                     Navigator.push(
                       context,
                       MaterialPageRoute(builder:(context) => VideoCardDetail(videoCard : videoCard, cart : cart, toggleFavorite : _toggleFavorite)),
                     );
                   },
                   child : const Text('Просмотреть'),
                 ),
                 IconButton(
                   iconSize :30,
                   icon : Icon(isFavorite ? Icons.favorite : Icons.favorite_border, color:isFavorite ? Colors.red : Colors.grey),
                   onPressed : () => _toggleFavorite(videoCard),
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