import 'package:flutter/material.dart';

import '../ApiCalls/AcademicEvent.dart';

class Announcement extends StatelessWidget {
  const Announcement({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colors.blueAccent,
          title: Text(
            'Announcement',
            style: TextStyle(color: Colors.white),
          ),
        ),
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
        ));
  }
}

class notify extends StatelessWidget {
  const notify({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
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
        child: const Padding(
          padding: EdgeInsets.all(13.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('There will be a holiday on Monday'),
              SizedBox(
                height: 10,
              ),
              Text(
                '7/7/2023',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              )
            ],
          ),
        ),
      ),
    );
  }
}
