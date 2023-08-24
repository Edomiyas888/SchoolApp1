import 'package:flutter/material.dart';
import '../ApiCalls/AcademicEvent.dart';

class MeetingsandEvents extends StatefulWidget {
  const MeetingsandEvents({super.key});

  @override
  State<MeetingsandEvents> createState() => _MeetingsandEventsState();
}

class _MeetingsandEventsState extends State<MeetingsandEvents> {
  @override
  Widget build(BuildContext context) {
    String des = '';
    Future<void> _showMyDialog(String des) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Description'),
            content: const SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(''),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Approve'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
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
            padding: EdgeInsets.only(right: 10.0),
            child: Text(
              'Events',
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
      body: FutureBuilder<List<Event>>(
        future: fetchAlbum(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final events = snapshot.data;

            if (events == null || events.isEmpty) {
              return Center(child: Text('No events found.'));
            }

            return ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) {
                Event event = events[index];
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    height: 80,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 1.0), //(x,y)
                          blurRadius: 6.0,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text(event.eventName),
                        subtitle: Text(
                            'Start Date: ${(event.startDateTime)!.substring(0, 10)}'),
                        trailing: Icon(event.startDateTime != null
                            ? Icons.star
                            : Icons.star_border),
                        onTap: () {
                          // Handle tapping on the ListTile if needed.
                        },
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
