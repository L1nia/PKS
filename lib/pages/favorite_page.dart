import 'package:flutter/material.dart';
// import 'package:flutter_application_1/pages/home_page.dart';
import 'package:flutter_application_4/components/favourite_item_note.dart';
import 'package:flutter_application_4/models/note.dart';
import 'package:flutter_application_4/api_service.dart';


List<Tovar> favorites = <Tovar>[];

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key,});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {

  late Future<List<Tovar>> _favorites;

  @override
  void initState() {
    super.initState();
    _favorites = ApiService().getFavoriteProducts(1);
  }

  void _removeTovarFromFavorite(int index) {
    ApiService().deleteProductFromFavorite(index);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('ИЗБРАННОЕ', style: TextStyle(fontSize: 24, color: Colors.white),),), backgroundColor: Colors.black,
      ),
      backgroundColor:  const Color.fromARGB(255, 255, 255, 255),
      body: FutureBuilder<List<Tovar>>(
        future: _favorites,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No products found'));
          }
          favorites = snapshot.data!;
          if(favorites.isEmpty){
            return Scaffold(
            appBar: AppBar(
              title: const Center(child: Text('ИЗБРАННОЕ', style: TextStyle(fontSize: 24, color: Colors.white),),), backgroundColor: Colors.black,
            ),
            backgroundColor:  const Color.fromARGB(255, 255, 255, 255),
              body: Padding(padding: const EdgeInsets.all(8),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset('../2.webp', width: 300, height: 300,),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Ничего пока что нет', style: TextStyle(fontSize: 32, color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }
          return
          Padding(padding: const EdgeInsets.all(8),
            child: ListView.builder(
            padding: const EdgeInsets.all(8),
              itemCount: favorites.length,
              itemBuilder: (BuildContext context, int index) {
                final favorite = favorites[index];
                return FavItemNote(
                  tovar: favorite, 
                  onRemove: () => {_removeTovarFromFavorite(favorite.id)}, 
                );
              },
            ),
          ); 
        },
      ),

    );
  }
}