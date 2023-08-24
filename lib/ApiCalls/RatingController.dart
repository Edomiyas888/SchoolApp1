import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserRole {
  final int id;
  final String roleName;
  final bool
      isAdmin; // You may need to change the data type based on your API response
  // Add other fields as needed

  UserRole({
    required this.id,
    required this.roleName,
    required this.isAdmin,
  });

  factory UserRole.fromJson(Map<String, dynamic> json) {
    return UserRole(
      id: json['id'] as int,
      roleName: json['roleName'] as String,
      isAdmin: json['isAdmin'] as bool,
      // Add other fields as needed
    );
  }
}

class Employee {
  final int id;
  final String? photo;
  final String? photoPath;
  final String firstName;
  final String middleName;
  final String lastName;
  final String fullName;
  final String gender;
  final String phone;
  final String city;
  final String subCity;
  final String email;
  final String addressInfo;
  final String educationLevel;
  final String jobPosition;

  final double ratingAverage;

  Employee({
    required this.id,
    this.photo,
    this.photoPath,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.fullName,
    required this.gender,
    required this.phone,
    required this.city,
    required this.subCity,
    required this.email,
    required this.addressInfo,
    required this.educationLevel,
    required this.jobPosition,
    required this.ratingAverage,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'] as int,
      photo: json['photo'] as String?,
      photoPath: json['photoPath'] as String?,
      firstName: json['firstName'] as String,
      middleName: json['middleName'] as String,
      lastName: json['lastName'] as String,
      fullName: json['fullName'] as String,
      gender: json['gender'] as String,
      phone: json['phone'] as String,
      city: json['city'] as String,
      subCity: json['subCity'] as String,
      email: json['email'] as String,
      addressInfo: json['addressInfo'] as String,
      educationLevel: json['educationLevel'] as String,
      jobPosition: json['jobPosition'] as String,
      ratingAverage: json['ratingAverage'] as double,
    );
  }
}

Future<List<Employee>> fetchTeachers() async {
  String? token;
  final prefs = await SharedPreferences.getInstance();
  token = prefs.getString('userToken');
  final url = Uri.parse(
    'http://localhost:5183/api/Employees',
  ); // Replace with your API endpoint

  try {
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    });
    print(response.statusCode);
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);

      final List<Employee> attendanceList =
          jsonData.map((json) => Employee.fromJson(json)).toList();

      return attendanceList;
    } else {
      throw Exception('Failed to fetch data');
    }
  } catch (e) {
    throw Exception('Failed to fetch data: $e');
  }
}

Future<List<Employee>> rateTeachers(double rating, int employeeId) async {
  String? token;
  final prefs = await SharedPreferences.getInstance();
  token = prefs.getString('userToken');
  final url = Uri.parse(
    'http://localhost:5183/api/Rating',
  ); // Replace with your API endpoint
  final Map<String, dynamic> requestBody = {
    "employeeId": "$employeeId", "rate": "$rating"
    // Add more key-value pairs as needed
  };
  try {
    print(employeeId);
    final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(requestBody));
    print(response.statusCode);
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);

      final List<Employee> attendanceList =
          jsonData.map((json) => Employee.fromJson(json)).toList();

      return attendanceList;
    } else {
      throw Exception('Failed to fetch data');
    }
  } catch (e) {
    throw Exception('Failed to fetch data: $e');
  }
}
