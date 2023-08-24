import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ApiCalls/ChatCall.dart';
import 'package:http/http.dart' as http;

class Chat extends StatefulWidget {
  final int id;
  final String name;

  Chat({
    required this.id,
    required this.name,
  });
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<Chat> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchThread(widget.id);
  }

  final TextEditingController _textController = TextEditingController();
  bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          leading: Padding(
            padding: EdgeInsets.all(8.0),
            child: isPressed
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        isPressed = false;
                      });
                    },
                    icon: Icon(Icons.arrow_back))
                : CircleAvatar(
                    maxRadius: 0.3,
                    backgroundImage: NetworkImage(
                        'https://w7.pngwing.com/pngs/340/946/png-transparent-avatar-user-computer-icons-software-developer-avatar-child-face-heroes-thumbnail.png'),
                  ),
          ),
          title: const Center(
              child: Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Text(
              'Chat Room',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 10.0, top: 5),
              child: Icon(
                Icons.notifications,
                color: Colors.white,
              ),
            )
          ],
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(15),
            ),
          )),
      body: Column(
        children: [
          Expanded(child: MessageWidget(id: widget.id)),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    setState(() {
                      sendMessage(_textController.text, widget.id);
                      isPressed = true;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MessageWidget extends StatefulWidget {
  final int id;

  MessageWidget({required this.id});

  @override
  State<MessageWidget> createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Messages>>(
        future: fetchThread(widget.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Show a loading indicator while fetching data.
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Text('No data available.');
          } else {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final user = snapshot.data![index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: user.senderUserAccountId == 1
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            color: user.receiverUserAccountId == 1
                                ? Colors.blueAccent
                                : Colors.greenAccent,
                          ),
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            user.message,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                });
          }
        });
  }
}

class UserListItem extends StatefulWidget {
  @override
  State<UserListItem> createState() => _UserListItemState();
}

class _UserListItemState extends State<UserListItem> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Users1>>(
        future: fetchUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Show a loading indicator while fetching data.
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Text('No data available.');
          } else {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final user = snapshot.data![index];
                  print(user.fullName);
                  return Card(
                    elevation: 3,
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://w7.pngwing.com/pngs/340/946/png-transparent-avatar-user-computer-icons-software-developer-avatar-child-face-heroes-thumbnail.png'), // Use AssetImage to load local images
                        radius: 30,
                      ),
                      title: Text(
                        user.fullName,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        user.roleName,
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      trailing: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          user.unreadMessageCount.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Chat(
                                      name: user.fullName,
                                      id: user.id,
                                    )));
                      },
                    ),
                  );
                });
          }
        });
  }
}

class ChatRoom extends StatefulWidget {
  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
              backgroundColor: Colors.blueAccent,
              leading: const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircleAvatar(
                  maxRadius: 0.3,
                  backgroundImage: NetworkImage(
                      'https://w7.pngwing.com/pngs/340/946/png-transparent-avatar-user-computer-icons-software-developer-avatar-child-face-heroes-thumbnail.png'),
                ),
              ),
              title: const Center(
                  child: Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Text(
                  'Chat Room',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              )),
              actions: const [
                Padding(
                  padding: EdgeInsets.only(right: 10.0, top: 5),
                  child: Icon(
                    Icons.notifications,
                    color: Colors.white,
                  ),
                )
              ],
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(15),
                ),
              )),
          body: UserListItem()),
    );
  }
}
