import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AttendanceController {
  final int id;
  final bool presence;
  final String remark;
  final DateTime attendanceDate;
  final int enrollmentId;
  final dynamic enrollment; // You can specify the actual type of 'enrollment'

  AttendanceController({
    required this.id,
    required this.presence,
    required this.remark,
    required this.attendanceDate,
    required this.enrollmentId,
    required this.enrollment,
  });

  factory AttendanceController.fromJson(Map<String, dynamic> json) {
    return AttendanceController(
      id: json['id'] as int,
      presence: json['presence'] as bool,
      remark: json['remark'] as String,
      attendanceDate: DateTime.parse(json['attendanceDate'] as String),
      enrollmentId: json['enrollmentId'] as int,
      enrollment: json['enrollment'], // You can specify the actual type
    );
  }
}

Future<List<AttendanceController>> fetchAttendanceData() async {
  String? token;
  final prefs = await SharedPreferences.getInstance();
  token = prefs.getString('userToken');
  final url = Uri.parse(
    'http://localhost:5183/api/Attendances/OfStudentOfStartedPeriod/1',
  ); // Replace with your API endpoint

  try {
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    });
    print(response.statusCode);
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);

      final List<AttendanceController> attendanceList =
          jsonData.map((json) => AttendanceController.fromJson(json)).toList();

      return attendanceList;
    } else {
      throw Exception('Failed to fetch data');
    }
  } catch (e) {
    throw Exception('Failed to fetch data: $e');
  }
}
