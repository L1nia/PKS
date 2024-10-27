import 'package:flutter/material.dart';
import 'cart.dart';
import 'video_card.dart';

class CartScreen extends StatefulWidget {
  final Cart cart;

  const CartScreen({super.key, required this.cart});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double totalPrice = 0; 

  @override
  void initState() {
    super.initState();
    _calculateTotalPrice(); 
  }

  void _calculateTotalPrice() {
    totalPrice = widget.cart.getItems().fold(0, (sum, item) => sum + item.price); 
    setState(() {});
  }

  void _updateTotalPrice(double priceChange) {
    setState(() {
      totalPrice += priceChange; 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Корзина')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.cart.getItems().length,
              itemBuilder: (context, index) {
                VideoCard videoCard = widget.cart.getItems()[index];
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(videoCard.name, style: const TextStyle(color: Colors.black)),
                              Text('\$${videoCard.price}', style: const TextStyle(color: Colors.green)),
                              _QuantityCounter(videoCard: videoCard, onQuantityChanged: _updateTotalPrice),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 80,
                          height: 80,
                          child: Image.network(videoCard.imageUrl, fit: BoxFit.cover),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            _confirmDelete(context, videoCard);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          _buildTotalPrice(), 
          _buildBuyButton(context), 
        ],
      ),
    );
  }

  Widget _buildTotalPrice() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        'Итого: \$${totalPrice.toStringAsFixed(2)}',
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildBuyButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Спасибо за покупку!')));
        }, 
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueAccent,
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          textStyle: const TextStyle(fontSize: 18),
        ),
        child: Text('Купить'),
      ),
    );
  }

  void _confirmDelete(BuildContext context, VideoCard videoCard) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Подтверждение удаления'),
          content: Text('Вы точно хотите удалить "${videoCard.name}" из корзины?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Нет'),
              onPressed: () {
                Navigator.of(context).pop(); 
              },
            ),
            TextButton(
              child: const Text('Да'),
              onPressed: () {
                widget.cart.remove(videoCard);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${videoCard.name} удален из корзины')),
                );
                Navigator.of(context).pop(); 
                _calculateTotalPrice(); 
              },
            ),
          ],
        );
      },
    );
  }
}

class _QuantityCounter extends StatefulWidget {
  final VideoCard videoCard;
  final Function(double) onQuantityChanged; 

  const _QuantityCounter({required this.videoCard, required this.onQuantityChanged});

  @override
  __QuantityCounterState createState() => __QuantityCounterState();
}

class __QuantityCounterState extends State<_QuantityCounter> {
  int quantity = 1; 

  void _increment() {
    setState(() {
      quantity++;
      widget.onQuantityChanged(widget.videoCard.price); 
    });
  }

  void _decrement() {
    setState(() {
      if (quantity > 1) {
        quantity--;
        widget.onQuantityChanged(-widget.videoCard.price); 
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice = quantity * widget.videoCard.price; 

    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: _decrement,
        ),
        Text('$quantity', style: const TextStyle(fontSize: 16)),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: _increment,
        ),
        const SizedBox(width: 10),
        Text('Итого \$${totalPrice.toStringAsFixed(2)}', style: const TextStyle(color: Colors.green)),
      ],
    );
  }
}