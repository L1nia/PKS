import 'package:flutter/material.dart';
import 'package:flutter_application_4/components/item_note.dart';
import 'package:flutter_application_4/pages/add_page.dart';
import 'package:flutter_application_4/pages/note_page.dart';
import 'package:flutter_application_4/pages/favorite_page.dart';
import 'package:flutter_application_4/pages/cart_page.dart';
import 'package:flutter_application_4/models/note.dart';
import 'package:flutter_application_4/api_service.dart';

List<Tovar> products = <Tovar>[]; 
List<Tovar> filteredProducts = <Tovar>[];
List<String> listName = <String>['А-Я', 'Я-А'];
List<String> listPrice = <String>['По возрастанию', 'По убыванию'];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late Future<List<Tovar>> _products;
  String dropdownValue1 = listName.first;
  String dropdownValue2 = listPrice.first;

  @override
  void initState() {
    super.initState();
    _products = ApiService().getProducts();
  }

  void _removeTovar(int index) {
    ApiService().deleteProduct(index);
    Navigator.pop(context);
  }

  void _addTovar(Tovar tovar) {
    ApiService().createProduct(tovar);
    _products = ApiService().getProducts();
  }

  void _addToFavorite(Tovar tovar) {
    int flag = 0;
    for (int i = 0; i < favorites.length; i++){
      if (favorites[i].description == tovar.description){
        flag = 1;
      }
    }
    if (flag == 0){
      ApiService().addProductToFavorite(tovar);
      Navigator.push(
        context, 
        MaterialPageRoute(
          builder: (context) => const FavoritePage()
        )
      );
    }
  }

  void _addToCart(Tovar cartItem) {
    int flag = 0;
    for (int i = 0; i < cart.length; i++){
      if (cart[i].url == cartItem.url){
        flag = 1;
      }
    }
    if (flag == 0){
      ApiService().addProductToCart(cartItem);
      Navigator.push(
        context, 
        MaterialPageRoute(
          builder: (context) => const CartPage()
        )
      );
    }
  }
  
  void _filter(String query) {
    if (query.isEmpty) {
      filteredProducts = products;
    } 
    else {
      filteredProducts = products.where((product) {
        return product.description.toLowerCase().contains(query.toLowerCase()) || 
               product.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    setState(() {});
  }

  void _sortByName(String? value) {
    setState(() {
      if (value == 'А-Я') {
        filteredProducts.sort((a, b) => a.name.compareTo(b.name));
      } else {
        filteredProducts.sort((a, b) => b.name.compareTo(a.name));
      }
    });
  }

  void _sortByPrice(String? value) {
    setState(() {
      if (value == 'По возрастанию') {
        filteredProducts.sort((a, b) => a.price.compareTo(b.price));
      } else {
        filteredProducts.sort((a, b) => b.price.compareTo(a.price));
      }
    });
  }

  @override 
  Widget build(BuildContext context) { 
    return Scaffold( 
      appBar: AppBar(
        title: const Center(child: Text('ТОВАРЫ', style: TextStyle(fontSize: 24, color: Colors.white),)),
        backgroundColor: Colors.black,
      ), 
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                _filter(value); 
              },
              decoration: const InputDecoration(
                labelText: 'Поиск товаров',
                labelStyle: TextStyle(color: Colors.black),
                // filled: true,
                // fillColor: Color.fromARGB(255,255, 113, 205),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 0, bottom:0, left:8, right:8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 0, bottom:0, left:0, right:8),
                  child: DropdownMenu<String>(
                    // menuStyle: const MenuStyle(
                    //   backgroundColor: WidgetStatePropertyAll<Color>(Color.fromARGB(255,255, 113, 205),),
                    // ),
                    initialSelection: listName.first,
                    onSelected: (String? value) {
                      // This is called when the user selects an item.
                      _sortByName(value);
                      setState(() {
                        dropdownValue1 = value!;
                      });
                    },
                    dropdownMenuEntries: listName.map<DropdownMenuEntry<String>>((String value) {
                      return DropdownMenuEntry<String>(value: value, label: value);
                    }).toList(),
                  ),
                ),
                DropdownMenu<String>(
                  // menuStyle: const MenuStyle(
                  //     backgroundColor: WidgetStatePropertyAll<Color>(Color.fromARGB(255,255, 113, 205),),
                  //   ),
                  initialSelection: listPrice.first,
                  onSelected: (String? value) {
                    // This is called when the user selects an item.
                    _sortByPrice(value);
                    setState(() {
                      dropdownValue2 = value!;
                    });
                  },
                  dropdownMenuEntries: listPrice.map<DropdownMenuEntry<String>>((String value) {
                    return DropdownMenuEntry<String>(value: value, label: value);
                  }).toList(),
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Tovar>>( 
              future: _products, 
              builder: (context, snapshot) { 
                if (snapshot.connectionState == ConnectionState.waiting) { 
                  return const Center(child: CircularProgressIndicator()); 
                } else if (snapshot.hasError) { 
                  return Center(child: Text('Error: ${snapshot.error}')); 
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) { 
                  return const Center(child: Text('No products found')); 
                } 

                products = snapshot.data!;
                // filteredProducts = products;

                return Padding(
                  padding: const EdgeInsets.all(8), 
                  child: ListView.builder( 
                    padding: const EdgeInsets.all(8), 
                    itemCount: filteredProducts.length,
                    itemBuilder: (BuildContext context, int index) { 
                      final product = filteredProducts[index]; 
                      return GestureDetector( 
                        onTap: () => Navigator.push( 
                          context,  
                          MaterialPageRoute( 
                            builder: (context) => NotePage(
                              tovar: product, 
                              onRemove: () { _removeTovar(product.id); }, 
                              onFavorite: () {  
                                _addToFavorite(product);  
                              }, 
                              onCart: () { 
                                _addToCart(product); 
                              },  
                            ), 
                          ), 
                        ), 
                        child: ItemNote(tovar: product), 
                      ); 
                    }, 
                  ), 
                );  
              },       
            ),
          ),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255), 

      floatingActionButton: FloatingActionButton( 
        onPressed: () => Navigator.push( 
          context, 
          MaterialPageRoute(builder: (context) => AddPage(onAdd: _addTovar, tovar: products[0]),), 
        ), 
        hoverColor: Colors.black, 
        foregroundColor: Colors.white, 
        backgroundColor: const Color.fromARGB(255, 0, 0, 0), 
        child: const Icon(Icons.add), 
      ), 
    ); 
    
  } 
}