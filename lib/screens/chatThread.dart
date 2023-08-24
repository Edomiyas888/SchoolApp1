import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatThread {
  final String contactName;
  final String lastMessage;
  final String time;

  ChatThread({
    required this.contactName,
    required this.lastMessage,
    required this.time,
  });
}

class MyApp extends StatelessWidget {
  final List<ChatThread> chatList = [
    ChatThread(
      contactName: 'John Doe',
      lastMessage: 'Hello!',
      time: '12:30 PM',
    ),
    ChatThread(
      contactName: 'Alice Smith',
      lastMessage: 'How are you?',
      time: '11:45 AM',
    ),
    ChatThread(
      contactName: 'Bob Johnson',
      lastMessage: 'See you later!',
      time: '10:15 AM',
    ),
    // Add more chat items here...
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Chat List'),
        ),
        body: ListView.builder(
          itemCount: chatList.length,
          itemBuilder: (context, index) {
            final chat = chatList[index];
            return ChatListItem(
              contactName: chat.contactName,
              lastMessage: chat.lastMessage,
              time: chat.time,
            );
          },
        ),
      ),
    );
  }
}

class ChatListItem extends StatelessWidget {
  final String contactName;
  final String lastMessage;
  final String time;

  ChatListItem({
    required this.contactName,
    required this.lastMessage,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        // You can add an image or initials for the contact's profile picture.
        backgroundColor: Colors.blue,
      ),
      title: Text(contactName),
      subtitle: Text(lastMessage),
      trailing: Text(time),
      onTap: () {
        // Add navigation to the chat screen when the item is tapped.
      },
    );
  }
}
