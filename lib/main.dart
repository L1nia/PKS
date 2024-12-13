import 'package:flutter/material.dart';
import 'package:flutter_application_4/pages/cart_page.dart';
import 'package:flutter_application_4/pages/home_page.dart';
import 'package:flutter_application_4/pages/favorite_page.dart';
// import 'package:flutter_application_1/pages/login_page.dart';
// import 'package:flutter_application_1/pages/login_page_2.dart';
import 'package:flutter_application_4/pages/profile.dart';
import 'package:flutter_application_4/services/auth/auth_gate_2.dart';
import 'package:flutter_application_4/services/auth/auth_service_2.dart';
// import 'package:flutter_application_1/services/auth/login_or_register.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
// import 'package:firebase_auth/firebase_auth.dart';

void main() async{
  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'X_X', 
      appId: 'X_X', 
      messagingSenderId: 'X_X', 
      projectId: 'X_X'
    )
  );

  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthService(),
      child: const MyApp(),
    )
  );
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
    AuthGate2(),
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
        selectedItemColor: const Color.fromARGB(255, 113, 255, 120),
        unselectedItemColor: Colors.white, 
        selectedLabelStyle: const TextStyle(color: Color.fromARGB(255, 120, 245, 120)), 
        unselectedLabelStyle: const TextStyle(color: Colors.white),
        onTap: _onItemTapped,
      ),
    );
  }
}