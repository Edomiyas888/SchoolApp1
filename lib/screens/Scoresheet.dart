import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:schoolapp/ApiCalls/ScoresheetController.dart';
import 'package:schoolapp/ApiCalls/ScoresheetDetailController.dart';
import 'package:schoolapp/screens/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

Future<void> generateAndSavePDF() async {
  final pdf = pw.Document();

  // Add content to the PDF
  pdf.addPage(pw.Page(
    build: (context) {
      return pw.Center(
        child: pw.Text('Hello, PDF!'),
      );
    },
  ));

  // Get the document directory
  final directory = await getApplicationDocumentsDirectory();
  final path = '${directory.path}/example.pdf';

  // Save the PDF to the device
  final File file = File(path);
  await file.writeAsBytes(await pdf.save());

  // You can now use the `path` to display or share the PDF
}

class Scoresheet extends StatelessWidget {
  const Scoresheet({super.key});

  void _showCustomDialog(BuildContext context, int courseId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                // Add your custom UI here
                const Text(
                  'Assesment',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                Container(
                    height: 200,
                    child: FutureBuilder<List<Students>>(
                      future: fetchStudents(courseId),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return Text('No Data Available');
                        } else {
                          final students = snapshot.data;

                          return ListView.builder(
                            itemCount: students!.length,
                            itemBuilder: (context, studentIndex) {
                              final student = students[studentIndex];

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: student.assessments.length,
                                    itemBuilder: (context, assessmentIndex) {
                                      final assessment =
                                          student.assessments[assessmentIndex];

                                      return ListTile(
                                        title: Text('Assessment Name: {Name} '),
                                        subtitle: Text(
                                            'Assessment Evaluation: ${assessment!.evaluation}'),
                                      );
                                    },
                                  ),
                                  Divider(),
                                ],
                              );
                            },
                          );
                        }
                      },
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        generateAndSavePDF(); // Close the dialog
                      },
                      child: Text('Close'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.blueAccent,
          title: const Text(
            'Scoresheet',
            style: TextStyle(color: Colors.white, fontSize: 19),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Center(
            child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey, // Color of the shadow
                      offset:
                          Offset(0, 2), // Offset of the shadow from the widget
                      blurRadius: 5, // Spread or blur of the shadow
                      spreadRadius: 2, // How much the shadow extends
                    ),
                  ],
                ),
                child: FutureBuilder<List<StudentData>>(
                  future: fetchStudentReportCard(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator(); // Display a loading indicator while waiting for data.
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Text(
                          'No Data Available'); // Handle the case where there's no data or an empty list.
                    } else {
                      final studentReportCard = snapshot.data!;
                      print(studentReportCard.length);

                      // Display the studentReportCard data here using a ListView or other widget.
                      return ListView.builder(
                        itemCount: studentReportCard.length - 1,
                        itemBuilder: (context, studentIndex) {
                          final studentData = studentReportCard[studentIndex];

                          // Create a ListView.builder for courseTotalDTOs.
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                title: Text(
                                    'Student ID: ${studentData.studentId}'),
                                subtitle: Text('Rank: ${studentData.student}'),
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: studentData.courseTotalDTOs.length,
                                itemBuilder: (context, courseIndex) {
                                  final courseData =
                                      studentData.courseTotalDTOs[courseIndex];
                                  return GestureDetector(
                                    child: ListTile(
                                      title: Text(
                                          'Course Name: ${courseData.courseName}'),
                                      subtitle: Text(
                                          'Total Score: ${courseData.total}'),
                                    ),
                                    onTap: () {
                                      print(courseData.courseId);

                                      _showCustomDialog(
                                          context, courseData.courseId);
                                    },
                                  );
                                },
                              ),
                              Divider(),
                              // Add a divider between students.
                            ],
                          );
                        },
                      );
                    }
                  },
                )),
          ),
        ));
  }
}

Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
