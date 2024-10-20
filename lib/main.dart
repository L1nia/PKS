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
  final List<VideoCard> videoCards = [
    VideoCard(id: 1, name: 'NVIDIA GEFORCE GTX 1080 Ti', imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTP_a8-t33HEfFvhddCYIb_4L6E0_AjA3rPpg&s', price: 109.99),
    
  ];
  
  final List<VideoCard> favorites = [];
  final Cart cart = Cart();
  
  int _selectedIndex = 0;

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
               borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
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