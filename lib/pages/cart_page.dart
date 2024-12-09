import 'package:flutter/material.dart'; 
import 'package:flutter_application_4/components/cart_item.dart'; 
import 'package:flutter_application_4/models/cart_model.dart';
import 'package:flutter_application_4/api_service.dart';
 
List<CartModel> cart = <CartModel>[]; 
// final List<Tovar> tovars = <Tovar>[]; 

class CartPage extends StatefulWidget { 
  const CartPage({super.key}); 

  @override 
  State<CartPage> createState() => _CartPageState(); 
} 

class _CartPageState extends State<CartPage> {

  late Future<List<CartModel>> _cart;

  @override
  void initState() {
    super.initState();
    _cart = ApiService().getCartProducts();
  }

  void _add(CartModel cartItem) { 
    ApiService().updateCartProductPlus(cartItem, cartItem.id);
  }

  void _deleate(CartModel cartItem) { 
    if(cartItem.count != 0){
      ApiService().updateCartProductMinus(cartItem, cartItem.id);
    }

    else{
      ApiService().deleteProductFromCart(cartItem.id);
    }
  } 

  void _removeAll(int index) { 
    ApiService().deleteProductFromCart(index);
  } 

  int _calculateTotal() {
    int total = 0;
    for (var item in cart) {
      total += item.price * item.count;
    }
    return total;
  }

  @override  
  Widget build(BuildContext context) {  
    return Scaffold(  
      appBar: AppBar(  
        title: const Center(  
          child: Text(  
            'КОРЗИНА', style: TextStyle(fontSize: 24, color: Colors.white),  
          ),  
        ),  
        backgroundColor: Colors.black,  
      ),  
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),  
      body: FutureBuilder<List<CartModel>>(
        future: _cart,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No products found'));
          }
          cart = snapshot.data!;
          return
          Padding( 
            padding: const EdgeInsets.all(8.0),  
            child: Column( 
              children: [ 
                Expanded( 
                  child: ListView.builder(  
                    padding: const EdgeInsets.all(8.0),  
                    itemCount: cart.length,  
                    itemBuilder: (BuildContext context, int index) {  
                      final cartItem = cart[index];
                      return Dismissible(  
                        key: Key(cartItem.url),
                        background: Container(color: Colors.red,),
                        direction: DismissDirection.endToStart,
                        confirmDismiss: (DismissDirection direction) async {
                          return await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Подтверждение"),
                                content: const Text("Хотите удалить товар из корзины?"),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () => Navigator.of(context).pop(true),
                                    child: const Text("УДАЛИТЬ")
                                  ),
                                  TextButton(
                                    onPressed: () => Navigator.of(context).pop(false),
                                    child: const Text("ОТМЕНИТЬ"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        onDismissed: (direction) {  
                          _removeAll(cartItem.id);  

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('${cartItem.url} удален из корзины'))
                          );  
                        },  
                        child: CartItem(  
                          cart: cartItem,   
                          onAdd: () => {
                            _add(
                              CartModel(
                                id: cartItem.id, 
                                price: cartItem.price, 
                                url: cartItem.url, 
                                count: cartItem.count + 1
                              )
                            )
                          },
                          onDeleate: () => {
                            _deleate(
                              CartModel(
                                id: cartItem.id, 
                                price: cartItem.price, 
                                url: cartItem.url, 
                                count: cartItem.count - 1
                              )
                            )
                          },
                          onRemove: () => {_removeAll(cartItem.id)}, 
                        ),  
                      ); 
                    },  
                  ),  
                ), 
                Padding( 
                  padding: const EdgeInsets.all(16.0), 
                  child: Container( 
                    decoration: BoxDecoration(color: const Color.fromARGB(255, 0, 0, 0), borderRadius: BorderRadius.circular(8),  
                        border: Border.all(color: Colors.white, width: 2),), 
                    padding: const EdgeInsets.all(16.0), 
                    child: Row( 
                      mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                      children: [ 
                        const Text( 
                          'Итого:', 
                          style: TextStyle(fontSize: 24, color: Colors.white), 
                        ), 
                        Text( 
                          '${_calculateTotal().toString()} ₽', 
                          style: const TextStyle(fontSize: 24, color: Colors.white), 
                        ), 
                      ], 
                    ), 
                  ), 
                ), 
              ],
            ),
          );
        },
      ), 
    );
  } 
}