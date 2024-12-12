import 'package:flutter/material.dart';
import 'package:flutter_application_4/pages/cart_page.dart';
import 'package:flutter_application_4/pages/home_page.dart';
import 'package:flutter_application_4/pages/favorite_page.dart';
import 'package:flutter_application_4/pages/login_page.dart';
import 'package:flutter_application_4/pages/profile.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async{
  await Supabase.initialize(
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZmaW9jY2tvbmpzYW5pb3FrZWh4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzM3MzAyMzYsImV4cCI6MjA0OTMwNjIzNn0.cjVyHXgysHg9YUyw3baBuHm_BinYtI8AUZ-7p-LNJRE',
    url: 'https://vfiocckonjsanioqkehx.supabase.co',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Видеокарты.ру',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    FavoritePage(),
    ProfilePage(),
    CartPage(),
    LoginPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      body: 
      _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        items: const <BottomNavigationBarItem>[
          
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.white,),
            label: 'Главная',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite, color: Colors.white,),
            label: 'Избранное',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.white,),
            label: 'Профиль',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart, color: Colors.white,),
            label: 'Корзина',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.login, color: Colors.white,),
            label: 'Авторизация',
            backgroundColor: Colors.black,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 109, 249, 101),
        unselectedItemColor: Colors.white, 
        selectedLabelStyle: const TextStyle(color: Color.fromARGB(255, 0, 255, 0)), // Цвет для выбранного элемента
        unselectedLabelStyle: const TextStyle(color: Colors.white),
        onTap: _onItemTapped,
      ),
    );
  }
}