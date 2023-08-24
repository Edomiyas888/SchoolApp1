import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CourseTotalDTO {
  final int courseId;
  final String courseName;
  final int total;
  final String letterGrade;

  CourseTotalDTO({
    required this.courseId,
    required this.courseName,
    required this.total,
    required this.letterGrade,
  });

  factory CourseTotalDTO.fromJson(Map<String, dynamic> json) {
    return CourseTotalDTO(
      courseId:
          json['courseId'] ?? 0, // Provide a default value if courseId is null.
      courseName: json['courseName'] ??
          '', // Provide a default value if courseName is null.
      total: json['total'] ?? 0, // Provide a default value if total is null.
      letterGrade: json['letterGrade'] ?? '',
    );
  }
}

class StudentData {
  final int id;
  final String status;
  final dynamic average;
  final dynamic rank;
  final int studentId;
  final dynamic student;
  final int gradeId;
  final dynamic grade;
  final int sectionId;
  final dynamic section;
  final int academicPeriodId;
  final dynamic academicPeriod;
  final dynamic assessments;
  final dynamic attendances;
  final int attendanceMissedDays;
  final List<CourseTotalDTO> courseTotalDTOs;

  StudentData({
    required this.id,
    required this.status,
    required this.average,
    required this.rank,
    required this.studentId,
    required this.student,
    required this.gradeId,
    required this.grade,
    required this.sectionId,
    required this.section,
    required this.academicPeriodId,
    required this.academicPeriod,
    required this.assessments,
    required this.attendances,
    required this.attendanceMissedDays,
    required this.courseTotalDTOs,
  });

  factory StudentData.fromJson(Map<String, dynamic> json) {
    return StudentData(
      id: json['id'],
      status: json['status'],
      average: json['average'],
      rank: json['rank'],
      studentId: json['studentId'],
      student: json['student'],
      gradeId: json['gradeId'],
      grade: json['grade'],
      sectionId: json['sectionId'],
      section: json['section'],
      academicPeriodId: json['academicPeriodId'],
      academicPeriod: json['academicPeriod'],
      assessments: json['assessments'],
      attendances: json['attendances'],
      attendanceMissedDays: json['attendanceMissedDays'],
      courseTotalDTOs: (json['courseTotalDTOs'] as List<dynamic>)
          .map((courseJson) => CourseTotalDTO.fromJson(courseJson))
          .toList(),
    );
  }
}

Future<List<StudentData>> fetchStudentReportCard() async {
  String? token;
  final prefs = await SharedPreferences.getInstance();
  token = prefs.getString('userToken');
  final url = Uri.parse(
    'http://localhost:5183/api/Enrollments/ReportCardOfStudent/1/2024',
  ); // Replace with your API endpoint

  try {
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    });
    print(response.statusCode);
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);

      final List<StudentData> attendanceList =
          jsonData.map((json) => StudentData.fromJson(json)).toList();

      return attendanceList;
    } else {
      throw Exception('Failed to fetch data');
    }
  } catch (e) {
    throw Exception('Failed to fetch data: $e');
  }
}
