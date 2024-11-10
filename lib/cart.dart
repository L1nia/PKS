import 'video_card.dart';

class Cart {
  final List<CartItem> items = [];

  void add(VideoCard videoCard) {
    final existingItem = items.firstWhere((item) => item.videoCard.id == videoCard.id); //null);

    if (existingItem != null) {
      existingItem.quantity++;
    } else {
      items.add(CartItem(videoCard: videoCard, quantity: 1));
    }
  }

  void remove(VideoCard videoCard) {
    items.removeWhere((item) => item.videoCard.id == videoCard.id);
  }

  void clear() {
    items.clear();
  }

  List<CartItem> getItems() {
    return items;
  }

  double getTotalPrice() {
    return items.fold(0, (sum, item) => sum + item.videoCard.price * item.quantity);
  }
}

class CartItem {
  final VideoCard videoCard;
  int quantity;

  CartItem({required this.videoCard, required this.quantity});
}