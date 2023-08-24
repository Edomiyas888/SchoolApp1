import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Students {
  final int id;

  final List<Assessment?> assessments;

  Students({
    required this.id,
    required this.assessments,
  });

  factory Students.fromJson(Map<String, dynamic> json) {
    final studentData = json['student'] as Map<String, dynamic>;
    final List<dynamic> assessmentsData = json['assessments'];

    return Students(
      id: json['id'],
      assessments: assessmentsData
          .map((assessmentJson) => Assessment.fromJson(assessmentJson))
          .toList(),
    );
  }
}

class Assessment {
  final int id;
  final int evaluation;
  final AssessmentWeight? assessmentWeight;
  final int enrollmentId;

  Assessment({
    required this.id,
    required this.evaluation,
    required this.assessmentWeight,
    required this.enrollmentId,
  });

  factory Assessment.fromJson(Map<String, dynamic> json) {
    final assessmentWeightJson =
        json['assessmentWeight']; // Remove the null coalescing operator

    return Assessment(
      id: json['id'] ?? 0,
      evaluation: json['evaluation'] ?? 0,
      assessmentWeight: assessmentWeightJson != null
          ? AssessmentWeight.fromJson(assessmentWeightJson)
          : null,
      enrollmentId: json['enrollmentId'] ??
          0, // Provide a default value or handle null accordingly
    );
  }
}

class AssessmentWeight {
  final int id;
  final int outOf;
  final String title;

  AssessmentWeight({
    required this.id,
    required this.outOf,
    required this.title,
  });

  factory AssessmentWeight.fromJson(Map<String, dynamic> json) {
    return AssessmentWeight(
      id: json['id'] ?? 0,
      outOf: json['outOf'] ?? 0,
      title: json['title'] ?? 0,
    );
  }
}

Future<List<Students>> fetchStudents(int course) async {
  String? token;
  final prefs = await SharedPreferences.getInstance();
  token = prefs.getString('userToken');
  final url = Uri.parse(
      'http://localhost:5183/api/Assessments/ScoreDetail/1/$course'); // Replace with your API endpoint

  try {
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      final List<Students> studentList =
          jsonData.map((json) => Students.fromJson(json)).toList();
      return studentList;
    } else {
      throw Exception('Failed to fetch data');
    }
  } catch (e) {
    throw Exception('Failed to fetch data: $e');
  }
}
