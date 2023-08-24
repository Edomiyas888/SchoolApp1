import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationState();
}

class _NotificationState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white
        ),
        backgroundColor: Colors.blueAccent,
        title: Text('Notifications',style: TextStyle(color: Colors.white,fontSize: 19),),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            notify(),
             notify(),
              notify(),
               notify(),
                notify(),
                 notify(),
                  notify(),
                   notify(),
                    notify(),
      
          ],
        ),
      ),

    );
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
          boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0.0, 1.0), //(x,y)
                blurRadius: 6.0,
              ),
            ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(13.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('There will be a holiday on Monday'),
              SizedBox(height: 10,),
              Text('7/7/2023',style: TextStyle(color: Colors.grey,fontSize: 12),)
            ],
          ),
        ),
    
    
      ),
    );
  }
}