import 'video_card.dart';

class Cart {
  final List<VideoCard> items = [];

  void add(VideoCard videoCard) {
    items.add(videoCard);
  }

  void remove(VideoCard videoCard) {
    items.remove(videoCard);
  }

  List<VideoCard> getItems() {
    return items;
  }
}