import 'package:flutter/material.dart';
import 'package:schoolapp/screens/LoginScreen.dart';
import '../ApiCalls/profileController.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class sharedData {
  static Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  static Future<void> saveUsername(String username) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString('username', username);
    print(prefs.getString('username'));
  }

  static Future<String> getUsername() async {
    final SharedPreferences prefs = await _prefs;

    return prefs.getString('username') ?? 'Guest';
  }
}

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late Future<Student> futureAlbum;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

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
          title: const Center(
              child: Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Text(
              'Profile',
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
          const SizedBox(
            height: 40,
          ),
          const CircleAvatar(
            minRadius: 70,
          ),
          const SizedBox(
            height: 10,
          ),
          FutureBuilder<List<Student>>(
            future: fetchProfile(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final student = snapshot.data;
                Student students = student![0];
                sharedData.saveUsername(students.firstName);

                return Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(students.firstName),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(students.phone1),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
          const SizedBox(
            height: 10,
          ),
          profileList('Our Location', Icon(Icons.map)),
          profileList('Notification', Icon(Icons.notification_add)),
          profileList('Language', Icon(Icons.language)),
          profileList('Edit Profile', Icon(Icons.person)),
          LogoutButton()
        ],
      ),
    );
  }
}

class profileList extends StatelessWidget {
  const profileList(this.name, this.precedingIcon);
  final String name;
  final Icon precedingIcon;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30, left: 30),
            child: Container(
              decoration: BoxDecoration(),
              child: Row(
                children: [
                  Icon(precedingIcon.icon),
                  Padding(
                    padding: const EdgeInsets.only(left: 40),
                    child: Text(
                      name,
                      style: TextStyle(fontSize: 14),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LogoutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final token = await getTokenFromSharedPreferences();

        if (token != null) {
          // Token exists, perform logout and clear it from shared preferences.
          await clearTokenFromSharedPreferences();
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) =>
                HomeView(), // Replace with your login or home screen.
          ));
        } else {
          // No token found, can't log out.
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Logout Error'),
              content: Text('You are not logged in.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            ),
          );
        }
      },
      child: Text('Logout'),
    );
  }

  Future<void> clearTokenFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userToken');
  }
}
