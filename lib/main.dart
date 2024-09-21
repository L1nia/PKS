import 'package:flutter/material.dart';
import 'video_card.dart';

void main() {
  runApp(VideoCardsApp());
}

class VideoCardsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Магазин Видеокарт',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color.fromARGB(255, 218, 210, 210), 
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white), 
          bodyMedium: TextStyle(color: Colors.white), 
      ),
      ), home: VideoCardsList(),
    );
  }
}

class VideoCardsList extends StatelessWidget {
  final List<VideoCard> videoCards = [
    VideoCard(
      name: 'NVIDIA GeForce RTX 3080',
      imageUrl:
          'https://cdn.citilink.ru/j_8zaDaHg5JiJOE9ErnYZxFqCZ3_Ym3w_VUv3I7aV4A/resizing_type:fit/gravity:sm/width:400/height:400/plain/product-images/3e472bc4-1daf-4697-a7fd-28e2af6fc043.jpg',
      price: 699.99,
    ),
    VideoCard(
      name: 'AMD Radeon RX 6800',
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTSOuW9yNs4Ji2B8LTsGUJiQOlYwZVR0pIjQQ&s',
      price: 579.99,
    ),
    VideoCard(
      name: 'Nvidia GeForce GTX 1050',
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRnevX70AXnjaE0Lp0Haz3yCvj25EA3b_yj3w&s',
      price: 159.99,
    ),
    VideoCard(
      name: 'Nvidia GeForce RTX 2060',
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSf2RXovjdiF1Ne0O46ID7FAPwqgHEGHrWn9A&s',
      price: 259.99,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Доступные Видеокарты'),
      ),
      body: ListView.builder(
        itemCount: videoCards.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(videoCards[index].name),
            subtitle: Text('\$${videoCards[index].price}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      VideoCardDetail(videoCard: videoCards[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class VideoCardDetail extends StatelessWidget {
  final VideoCard videoCard;

  VideoCardDetail({required this.videoCard});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(videoCard.name),
      ),
      body: Center( // Используем Center для центрирования содержимого
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center, // Центрируем содержимое по вертикали
            crossAxisAlignment:
                CrossAxisAlignment.center, // Центрируем содержимое по горизонтали
            children: [
              Image.network(videoCard.imageUrl),
              const SizedBox(height: 8),
              Text(videoCard.name,
                  style:
                      const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)), // Устанавливаем цвет текста
              const SizedBox(height: 16),
              Text('\$${videoCard.price}',
                  style:
                      const TextStyle(fontSize: 20, color: Colors.green)), // Цвет текста для цены
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title:
                          Text('Купить ${videoCard.name}', style: TextStyle(color: Colors.black)),
                      content:
                          const Text('Вы уверены, что хотите купить этот товар?', style: TextStyle(color: Colors.black)),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child:
                              const Text('Да', style: TextStyle(color: Colors.black)),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child:
                              const Text('Нет', style: TextStyle(color: Colors.black)),
                        ),
                      ],
                    ),
                  );
                },
                child:
                    const Text('Купить'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}