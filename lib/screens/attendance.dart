import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../ApiCalls/AttendannceCall.dart';

class Attendance extends StatefulWidget {
  @override
  _AttendanceState createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  // CalendarController _calendarController;

  @override
  void initState() {
    super.initState();
    //_calendarController = CalendarController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.blueAccent,
        title: const Text(
          'Attendance',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Overall Attendance Count',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
              NumberStatsCards(),
              const SizedBox(
                height: 50,
              ),
              Text(
                'Past five Days Attendance',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              FutureBuilder<List<AttendanceController>>(
                future: fetchAttendanceData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(); // Show a loading indicator while fetching data.
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Text('No data available.');
                  } else {
                    // Display the data here using a ListView, GridView, or other widgets.
                    return Container(
                      height: 250,
                      child: Container(
                        child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final attendance = snapshot.data![index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width - 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.grey, // Color of the shadow
                                      offset: Offset(0,
                                          2), // Offset of the shadow from the widget
                                      blurRadius:
                                          5, // Spread or blur of the shadow
                                      spreadRadius:
                                          2, // How much the shadow extends
                                    ),
                                  ],
                                ),
                                child: ListTile(
                                  title: Text(attendance.presence
                                      ? 'Attendance: Present'
                                      : 'Attendance: Absent'),
                                  subtitle: Text(
                                      ' Date: ${(attendance.attendanceDate.toString()).substring(0, 10)}'),
                                  trailing: Icon(
                                    Icons.check,
                                    color: Colors.green,
                                  ),
                                  // Add more fields as needed
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  }
                },
              ),

              // Add your attendance-related widgets below
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // _calendarController.dispose();
    super.dispose();
  }
}

class NumberStatsCards extends StatefulWidget {
  @override
  State<NumberStatsCards> createState() => _NumberStatsCardsState();
}

class _NumberStatsCardsState extends State<NumberStatsCards> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<AttendanceController>>(
        future: fetchAttendanceData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Show a loading indicator while fetching data.
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Text('No data available.');
          } else {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of columns in the grid
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 1.4),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 4,
              itemBuilder: (context, index) {
                int absentCount = 0;
                int presentCount = 0;

                for (final attendance in snapshot.data!) {
                  if (attendance.presence == false) {
                    absentCount += 1;
                  } else if (attendance.presence == true) {
                    presentCount += 1;
                  }
                }

                if (index == 0) {
                  return Container(
                    height: 150, // Set the desired height for the container
                    child: StatCard(
                      title: 'Total Class Days',
                      value: snapshot.data!.length.toString(),
                      icon: Icons.people,
                      color: Colors.blue,
                    ),
                  );
                } else if (index == 1) {
                  return Container(
                    height: 150, // Set the desired height for the container
                    child: StatCard(
                      title: 'Total Absent',
                      value: absentCount.toString(),
                      icon: Icons.people,
                      color: Colors.red,
                    ),
                  );
                } else if (index == 2) {
                  return Container(
                    height: 150, // Set the desired height for the container
                    child: StatCard(
                      title: 'Total Present',
                      value: presentCount.toString(),
                      icon: Icons.people,
                      color: Colors.green,
                    ),
                  );
                } else {
                  return Container(
                    height: 150, // Set the desired height for the container
                    child: StatCard(
                      title: 'Total Late',
                      value: '0',
                      icon: Icons.people,
                      color: Colors.yellow,
                    ),
                  );
                }
              },
            );
          }
        });
  }
}

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              size: 40,
              color: color,
            ),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              value,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
