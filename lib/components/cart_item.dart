import 'package:flutter/material.dart';
import 'package:flutter_application_4/models/cart_model.dart';
// import 'package:flutter_application_1/pages/cart_page.dart';

class CartItem extends StatefulWidget {
  const CartItem({
    super.key, 
    required this.cart, 
    required this.onAdd, 
    required this.onDeleate, 
    required this.onRemove,

  });

  final VoidCallback onAdd;
  final VoidCallback onDeleate;
  final VoidCallback onRemove;
  final CartModel cart;

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.195,
          decoration: BoxDecoration(color: const Color.fromARGB(255, 255, 255, 255), borderRadius: BorderRadius.circular(8), 
          border: Border.all(color: const Color.fromARGB(255, 0, 0, 0), width: 2),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(widget.cart.url, height: 50, width: 50,),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 80,
                  height: 50,
                  decoration: BoxDecoration(color: const Color.fromARGB(255, 255, 255, 255), borderRadius: BorderRadius.circular(8), 
                  border: Border.all(color: const Color.fromARGB(255, 0, 0, 0), width: 2),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text('${widget.cart.price} ₽', style: const TextStyle(fontSize: 16, color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(padding: const EdgeInsets.all(0.0),
                child: TextButton(
                  onPressed: widget.onDeleate,
                    child: Container(width: 50, height: 50,
                      decoration: BoxDecoration(color: const Color.fromARGB(255, 255, 255, 255), 
                        borderRadius: BorderRadius.circular(8), 
                        border: Border.all(color: const Color.fromARGB(255, 0, 0, 0), width: 2),
                      ),
                      child: const Center(
                        child: Text('-', 
                        style: TextStyle(fontSize: 24, color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                      ),
                    ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(color: const Color.fromARGB(255, 255, 255, 255), borderRadius: BorderRadius.circular(8), 
                  border: Border.all(color: const Color.fromARGB(255, 0, 0, 0), width: 2),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(widget.cart.count.toString(), style: const TextStyle(fontSize: 16, color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(padding: const EdgeInsets.all(0.0),
                child: TextButton(
                  onPressed: widget.onAdd,
                    child: Container(width: 50, height: 50,
                      decoration: BoxDecoration(color: const Color.fromARGB(255, 255, 255, 255), 
                        borderRadius: BorderRadius.circular(8), 
                        border: Border.all(color: const Color.fromARGB(255, 0, 0, 0), width: 2),
                      ),
                      child: const Center(
                        child: Text('+', 
                        style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                      ),
                    ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}