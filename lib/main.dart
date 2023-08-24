import 'package:flutter/material.dart';
import 'package:schoolapp/screens/LoginScreen.dart';
import 'package:schoolapp/screens/chat.dart';
import 'package:schoolapp/screens/homescreen.dart';
import 'package:schoolapp/screens/meetings.dart';
import 'package:schoolapp/screens/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  runApp(const MyApp());
}

Future<String> getTokenFromSharedPreferences() async {
  final prefs = await SharedPreferences.getInstance();

  return prefs.getString('userToken').toString();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue, // This sets the primary color
          //accentColor: Colors.blueAccent,
          useMaterial3: true,
        ),
        home: SplashScreen());
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: getTokenFromSharedPreferences(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While waiting for the token, display a loading indicator.
          return CircularProgressIndicator();
        } else if (snapshot.hasData && snapshot.data != null) {
          // If a valid token exists, navigate to the authenticated home screen.
          return BottomNavigation();
        } else {
          // If there's no valid token, navigate to the login screen.
          return HomeView();
        }
      },
    );
  }
}

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    Home(),
    ChatRoom(),
    MeetingsandEvents(),
    Profile(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _screens[_currentIndex],
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
              color: Colors.blueAccent, // Set the background color
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              )),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
            child: new Theme(
              data: Theme.of(context).copyWith(
                  // sets the background color of the `BottomNavigationBar`
                  canvasColor: Colors.blueAccent,
                  // sets the active color of the `BottomNavigationBar` if `Brightness` is light
                  primaryColor: Colors.red,
                  textTheme: Theme.of(context).textTheme.copyWith(
                      caption: new TextStyle(
                          color: Colors
                              .yellow))), // sets the inactive color of the `BottomNavigationBar`
              child: new BottomNavigationBar(
                backgroundColor: Colors.black,
                currentIndex: _currentIndex,
                onTap: _onTabTapped,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.chat),
                    label: 'Messages',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.event),
                    label: 'Events',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'Profile',
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
