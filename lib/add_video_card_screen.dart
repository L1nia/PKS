import 'package:flutter/material.dart';
import 'video_card.dart';

class AddVideoCardScreen extends StatelessWidget {
  final Function(VideoCard) onAdd;
  final Function(VideoCard) onEdit;
  final Function(VideoCard) onDelete;
  final VideoCard? videoCard;

  const AddVideoCardScreen({
    super.key,
    required this.onAdd,
    required this.onEdit,
    required this.onDelete,
    this.videoCard,
  });

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController(text: videoCard?.name);
    final imageUrlController = TextEditingController(text: videoCard?.imageUrl);
    final priceController = TextEditingController(text: videoCard != null ? videoCard!.price.toString() : '');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Добавить Видеокарту'),
        actions:[
          if (videoCard != null)
            IconButton(
              icon :const Icon(Icons.delete),
              onPressed :() {
                onDelete(videoCard!);
                Navigator.pop(context);
              },
            ),
        ],
      ),
      body :Padding (
        padding :const EdgeInsets.all(16.0),
        child :Column (
          children :[
            TextField (
              controller :nameController,
              decoration :const InputDecoration(labelText :'Название'),
            ),
            TextField (
              controller :imageUrlController,
              decoration :const InputDecoration(labelText :'Ссылка на изображение'),
            ),
            TextField (
              controller :priceController,
              decoration :const InputDecoration(labelText :'Цена'),
              keyboardType :TextInputType.number,
            ),
            const SizedBox(height :20),
            ElevatedButton (
              onPressed :() {
                final name = nameController.text;
                final imageUrl = imageUrlController.text;
                final price = double.tryParse(priceController.text) ?? 0;
                if (name.isNotEmpty && imageUrl.isNotEmpty && price > 0) {
                  if (videoCard == null) {
                    onAdd(VideoCard(name:name, imageUrl:imageUrl, price :price, id: null, description: ''));
                  } else {
                    onEdit(VideoCard(name:name, imageUrl:imageUrl, price :price, id: null, description: ''));
                  }
                  Navigator.pop(context);
                }
              },
              child :
                  Text(videoCard == null ? 'Добавить' : 'Сохранить'),
            ),
          ],
        ),
      ),
    );
  }
}