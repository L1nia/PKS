import 'package:flutter/material.dart';
import 'package:flutter_application_4/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  final Function(String, String, String) onUpdateProfile;

  const ProfileScreen({super.key, required this.onUpdateProfile});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  bool isEditable = false; // Флаг для редактирования

  @override
  void initState() {
    super.initState();
    _loadProfileData(); // Загрузка данных при инициализации
  }

  Future<void> _loadProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    nameController.text = prefs.getString('name') ?? '';
    surnameController.text = prefs.getString('surname') ?? '';
    phoneController.text = prefs.getString('phone') ?? '';
    emailController.text = prefs.getString('email') ?? '';
  }

  Future<void> _saveProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', nameController.text);
    await prefs.setString('surname', surnameController.text);
    await prefs.setString('phone', phoneController.text);
    await prefs.setString('email', emailController.text);
  }

  void _toggleEdit() {
    setState(() {
      isEditable = !isEditable; // Переключение режима редактирования
    });
    
    if (!isEditable) {
      _saveProfileData(); // Сохранение данных при выходе из режима редактирования
      widget.onUpdateProfile(nameController.text, surnameController.text, phoneController.text);
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Личный кабинет')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Имя:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            isEditable
                ? TextField(
                    controller: nameController,
                    decoration: const InputDecoration(border: OutlineInputBorder()),
                  )
                : Text(nameController.text.isEmpty ? 'Не указано' : nameController.text),
            const SizedBox(height: 16),

            const Text(
              'Фамилия:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            isEditable
                ? TextField(
                    controller: surnameController,
                    decoration: const InputDecoration(border: OutlineInputBorder()),
                  )
                : Text(surnameController.text.isEmpty ? 'Не указано' : surnameController.text),
            const SizedBox(height: 16),

            const Text(
              'Телефон:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            isEditable
                ? TextField(
                    controller: phoneController,
                    decoration: const InputDecoration(border: OutlineInputBorder()),
                    keyboardType: TextInputType.phone,
                  )
                : Text(phoneController.text.isEmpty ? 'Не указано' : phoneController.text),
            const SizedBox(height: 16),

            const Text(
              'Почта:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            isEditable
                ? TextField(
                    controller: emailController,
                    decoration: const InputDecoration(border: OutlineInputBorder()),
                    keyboardType: TextInputType.emailAddress,
                  )
                : Text(emailController.text.isEmpty ? 'Не указано' : emailController.text),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: _toggleEdit,
              child: Text(isEditable ? 'Сохранить' : 'Редактировать'),
            ),
          ],
        ),
      ),
    );
  }
}
