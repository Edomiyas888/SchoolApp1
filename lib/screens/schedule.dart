import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class SChedule extends StatefulWidget {
  const SChedule({super.key});

  @override
  State<SChedule> createState() => _SCheduleState();
}

class _SCheduleState extends State<SChedule> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.blueAccent,
        title: Text(
          'Schedule',
          style: TextStyle(color: Colors.white, fontSize: 19),
        ),
      ),
      body: Column(
        children: [
          TableCalendar(
            //calendarController: _calendarController,
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: DateTime.now(),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10)),
                ),
                const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text('Open School Days'))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 151, 26, 26),
                      borderRadius: BorderRadius.circular(10)),
                ),
                const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text('Closed School Days'))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 22, 13, 148),
                      borderRadius: BorderRadius.circular(10)),
                ),
                const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text('Meeting or Event Days'))
              ],
            ),
          )
        ],
      ),
    );
  }
}
