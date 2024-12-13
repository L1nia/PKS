import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_4/components/chat_bubble.dart';
import 'package:flutter_application_4/components/my_text_field.dart';
import 'package:flutter_application_4/services/chat/chat_service.dart';

class ChatPage extends StatefulWidget {
  final String receiverUserId;
  final String receiverUserEmail;
  const ChatPage({super.key, required this.receiverUserEmail, required this.receiverUserId});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
        widget.receiverUserId,
        _messageController.text
      );

      //clear the controller
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text(widget.receiverUserEmail, style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),),), backgroundColor: const Color.fromARGB(255, 255, 255, 255),),
      backgroundColor:  const Color.fromARGB(255, 255, 255, 255),
      body: Column(
        children: [
          //message
          Expanded(
            child: _buildMessageList(),
          ),

          //user input
          _buildMessageinput(),

          const SizedBox(height: 25,)
        ],
      ),
    );
  }

  //build message list
  Widget _buildMessageList() {
    return StreamBuilder(
      stream: _chatService.getMessages(
        widget.receiverUserId,
        _firebaseAuth.currentUser!.uid
      ),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('error' + snapshot.error.toString());
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Загрузка..');
        }

        return ListView(
          children: snapshot.data!.docs.map((document) => _buildMessageItem(document))
          .toList(),
        );
      }
    );
  }

  //build message item
  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    //align the messages to right or left
    var alignment = (data['senderID'] == _firebaseAuth.currentUser!.uid)
      ? Alignment.centerRight
      : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: 
            (data['senderID'] == _firebaseAuth.currentUser!.uid)
              ? CrossAxisAlignment.end 
              : CrossAxisAlignment.start,
          mainAxisAlignment:
              (data['senderID'] == _firebaseAuth.currentUser!.uid)
                ? MainAxisAlignment.end 
                : MainAxisAlignment.start,
          children: [
            Text(data['senderEmail']),
            const SizedBox(height: 5,),
            ChatBubble(message: data['message'])
          ],
        ),
      ),
    );
  }

  //build message input
  Widget _buildMessageinput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Row(
        children: [
          Expanded(
            child: MyTextField(
              controller: _messageController,
              hintText: 'Напишите сообщение',
              obscureText: false
            ),
          ),
      
          //send button
          IconButton(
            onPressed: sendMessage,
            icon: Icon(
              Icons.arrow_upward,
              size: 40,
            )
          )
        ],
      ),
    );
  }
}