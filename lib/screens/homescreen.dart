import 'package:flutter/material.dart';
import 'package:schoolapp/screens/Scoresheet.dart';
import 'package:schoolapp/screens/announcement.dart';
import 'package:schoolapp/screens/applyfortutor.dart';
import 'package:schoolapp/screens/attendance.dart';
import 'package:schoolapp/screens/notifications.dart';
import 'package:schoolapp/screens/rateings.dart';
import 'package:schoolapp/screens/register.dart';
import 'package:schoolapp/screens/schedule.dart';

//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
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
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
            title: Center(
                child: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Container(
                height: 30,
                width: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                //child: Center(child: Text('Home',style: TextStyle(fontSize: 15,fontFamily: 'poppins'),)),
              ),
            )),
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 20.0, top: 4),
                child: GestureDetector(
                  child: const Icon(
                    Icons.notifications,
                    color: Colors.white,
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Notifications()));
                  },
                ),
              )
            ],
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(15),
              ),
            )),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              const Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: Text(
                    'Upcoming Events',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 180,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    events(),
                    events(),
                    events(),
                    events(),
                    events(),
                    events(),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const SizedBox(
                width: 250,
                child: Divider(
                  color: const Color.fromARGB(255, 158, 157, 157),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    child: Container(
                      height: 100,
                      width: 100,
                      child: const Column(
                        children: [
                          Icon(
                            Icons.schedule,
                            color: Colors.purple,
                            size: 40,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Schedule',
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SChedule()));
                    },
                  ),
                  GestureDetector(
                    child: Container(
                      height: 100,
                      width: 100,
                      child: const Column(
                        children: [
                          Icon(
                            Icons.announcement,
                            color: Colors.greenAccent,
                            size: 40,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Announcement',
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Announcement()));
                    },
                  ),
                  GestureDetector(
                    child: Container(
                      height: 100,
                      width: 100,
                      child: const Column(
                        children: [
                          Icon(
                            Icons.rate_review_outlined,
                            color: Color.fromARGB(255, 230, 133, 42),
                            size: 40,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Rate Teachers',
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RateTeachers()));
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    child: Container(
                      height: 100,
                      width: 100,
                      child: const Column(
                        children: [
                          Icon(
                            Icons.folder,
                            color: Color.fromARGB(255, 22, 63, 177),
                            size: 40,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Attendance',
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Attendance()));
                    },
                  ),
                  GestureDetector(
                    child: Container(
                      height: 100,
                      width: 100,
                      child: const Column(
                        children: [
                          Icon(
                            Icons.book,
                            color: Color.fromARGB(255, 93, 138, 51),
                            size: 40,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'ScoreSheet',
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Scoresheet()));
                    },
                  ),
                  GestureDetector(
                    child: Container(
                      height: 100,
                      width: 100,
                      child: const Column(
                        children: [
                          Icon(
                            Icons.chrome_reader_mode,
                            color: Color.fromARGB(255, 72, 94, 218),
                            size: 40,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Apply For Tutor',
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ApplyForTutor()));
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    child: Container(
                      height: 100,
                      width: 120,
                      child: const Column(
                        children: [
                          Icon(
                            Icons.payment,
                            color: Color.fromARGB(255, 46, 185, 12),
                            size: 40,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Payment',
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Attendance()));
                    },
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    child: const Column(
                      children: [
                        Icon(
                          Icons.help,
                          color: Color.fromARGB(255, 230, 42, 73),
                          size: 40,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Help and Support',
                          style: TextStyle(fontSize: 12),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                width: 250,
                child: Divider(
                  color: Color.fromARGB(255, 158, 157, 157),
                ),
              ),
            ],
          ),
        ));
  }
}

class events extends StatelessWidget {
  const events({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        height: 250,
        width: 120,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Color.fromARGB(255, 204, 203, 203))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  'https://images.pexels.com/photos/2774556/pexels-photo-2774556.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                  fit: BoxFit.cover,
                  height: 100,
                  width: 140,
                )),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: const EdgeInsets.only(left: 7.0),
              child: Text(
                '7/07/2023',
                style: TextStyle(color: Colors.grey, fontSize: 10),
              ),
            ),
            const Padding(
              padding: const EdgeInsets.only(left: 7.0),
              child: Text(
                'Parents Day',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
