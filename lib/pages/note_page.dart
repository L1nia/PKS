import 'package:flutter/material.dart';
import 'package:flutter_application_4/api_service.dart';
import 'package:flutter_application_4/models/note.dart';
import 'package:flutter_application_4/pages/update_page.dart';

class NotePage extends StatelessWidget {
  const NotePage({super.key, required this.tovar, required this.onRemove, required this.onFavorite, required this.onCart,});

  final Tovar tovar;
  final VoidCallback onRemove;
  final VoidCallback onFavorite;
  final VoidCallback onCart;

  void _updateTovar(tovar) {
    ApiService().updateProduct(tovar, tovar.id);
  }

  @override
   Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text('', style: TextStyle(fontSize: 24, color: Colors.white),),), backgroundColor: Colors.black,
      ),
      body: 
        Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.8,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 120, 110, 110), borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.white, width: 2), 
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(tovar.description, style: const TextStyle(fontSize: 36, color: Colors.white),),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(child: Image.network(tovar.url, height: 200, width: 200,)),
                ),
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Text('Цена: ${tovar.price}', style: const TextStyle(fontSize: 36, color: Colors.white),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 200,
                    height: 50,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        side: BorderSide(
                          color: Colors.white,
                          width: 2,
                        ),
                      ),
                      backgroundColor: const Color.fromARGB(255, 0, 0, 0),),
                      onPressed: onRemove,
                      child: const Text('Удалить товар', style: TextStyle(fontSize: 20, color: Colors.white,),),),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 200,
                    height: 50,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        side: BorderSide(
                          color: Colors.white,
                          width: 2,
                        ),
                      ),
                      backgroundColor: const Color.fromARGB(255, 0, 0, 0),),
                      onPressed: 
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => UpdatePage(onUpdate: _updateTovar, tovar: tovar),),
                      ),
                      child: const Text('Редактировать', style: TextStyle(fontSize: 20, color: Colors.white,),),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                        onPressed: onFavorite,
                        icon: const Icon(
                          Icons.favorite, color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                        onPressed: onCart, 
                        icon: const Icon(
                          Icons.shopping_cart, color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ), backgroundColor: const Color.fromARGB(255, 255, 255, 255),
    );
  }
}