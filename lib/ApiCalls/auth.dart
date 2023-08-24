import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class LoginResponse {
  final String token;
  final String username;

  LoginResponse({
    required this.token,
    required this.username,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    final loginResponse = LoginResponse(
      token: json['token'] as String,
      username: json['username'] as String,
    );

    // Save the token to shared preferences here
    saveTokenToSharedPreferences(loginResponse.token);
    print(loginResponse.token);

    return loginResponse;
  }
}

Future<List<LoginResponse>> fetchLoginData(
    String username, String pwd, BuildContext context) async {
  final Map<String, dynamic> requestBody = {
    "userName": username,
    "password": pwd,
    "type": "string"
    // Add more key-value pairs as needed
  };
  final response =
      await http.post(Uri.parse('http://localhost:5183/api/Auth/Login'),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode(requestBody));
  ;
  print(response.statusCode);
  if (response.statusCode == 200) {
    final jsonData = json.decode('[' + response.body + ']');
    List<dynamic> jsonList = jsonData as List;
    List<LoginResponse> student =
        jsonList.map((json) => LoginResponse.fromJson(json)).toList();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => BottomNavigation()));

    return student;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

Future<void> saveTokenToSharedPreferences(String token) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString('userToken', token);
}
