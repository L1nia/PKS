import 'package:flutter/material.dart';
import 'package:flutter_application_4/models/note.dart';

class UpdatePage extends StatelessWidget {
  const UpdatePage({super.key, required this.tovar, required this.onUpdate});

  final Tovar tovar;
  final Function(Tovar) onUpdate;  

  @override
  Widget build(BuildContext context) {
    final TextEditingController _urlController = TextEditingController(text: tovar.url);

    final TextEditingController _priceController = TextEditingController(text: tovar.price.toString());

    final TextEditingController _descriptionController = TextEditingController(text: tovar.description);
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text('Редактирование товара', style: TextStyle(fontSize: 24, color: Colors.white),),), backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _urlController,
              style: const TextStyle(fontSize: 24, color: Colors.black),
              decoration: const InputDecoration(
                labelText: 'Введите URL',
              ),
              maxLines: 2,
            ),
            TextField(
              controller: _priceController,
              style: const TextStyle(fontSize: 24, color: Colors.black),
              decoration: const InputDecoration(
                labelText: 'Введите цену',
              ),
              maxLines: 2,
            ),
            TextField(
              controller: _descriptionController,
              style: const TextStyle(fontSize: 24, color: Colors.black),
              decoration: const InputDecoration(
                labelText: 'Введите описание',
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: () {
                final url = _urlController.text;
                final price = _priceController.text;
                final description = _descriptionController.text;
                if (url.isNotEmpty) {
                  if (price.isNotEmpty) {
                    if (description.isNotEmpty) {
                      onUpdate(
                        Tovar(
                          id: tovar.id,
                          name: tovar.name,
                          url: url,
                          price: int.parse(price), 
                          description: description,
                        )
                      );
                      Navigator.pop(context, Tovar);
                      Navigator.pop(context, Tovar);
                    }
                  }
                }
              },
              style: FilledButton.styleFrom(backgroundColor: Colors.black),
              child: const Text('Редактировать'),
            ),
          ],
      ),
      ),
      backgroundColor:  const Color.fromARGB(255, 255, 255, 255),
    );
  }
}