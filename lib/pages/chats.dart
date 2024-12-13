import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_4/pages/chat_page.dart';
import 'package:flutter_application_4/services/auth/auth_service_2.dart';
import 'package:provider/provider.dart';

class Chats extends StatefulWidget {
  const Chats({super.key});

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  //instance of auth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //sign out user
  void signOut() {
    //get auth service
    final authService = Provider.of<AuthService>(context, listen: false);

    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('ПРОФИЛЬ', style: TextStyle(fontSize: 24, color: Color.fromARGB(255, 255, 255, 255)),),), backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        actions: [
          IconButton(
            onPressed: signOut,
            icon: const Icon(Icons.logout))
        ],
      ),
      backgroundColor:  const Color.fromARGB(255, 255, 255, 255),

      body: _builduserList(),
    );
  }

  //build a list of users
  Widget _builduserList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('error');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Загрузка...');
        }

        if (_auth.currentUser!.email != 'guest@gmail.com') {
          return ListView(
            children: snapshot.data!.docs.where((x) => x['email'] == 'guest@gmail.com')
            .map<Widget>((doc) => _builduserListItem(doc))
            .toList(),
          );
        } 
        else {
          return ListView(
            children: snapshot.data!.docs
            .map<Widget>((doc) => _builduserListItem(doc))
            .toList(),
          );
        }
      }
    );
  }

  //build individual user list items
  Widget _builduserListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    //display all users except current user
    if (_auth.currentUser!.email != data['email']) {
      return ListTile(
        title: Text(data['email']),
        onTap: () {
          //pass the user`s UID
          Navigator.push(
            context, 
            MaterialPageRoute(builder: (context) => 
              ChatPage(
                receiverUserEmail: data['email'],
                receiverUserId: data['uid'],
              ),
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }
}