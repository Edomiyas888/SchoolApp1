import 'dart:convert';
import 'dart:html';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Users1 {
  final int id;
  final String userName;
  final int userRoleId;
  final String roleName;
  final String fullName;
  final String photoPath;
  final int unreadMessageCount;

  Users1({
    required this.id,
    required this.userName,
    required this.userRoleId,
    required this.roleName,
    required this.fullName,
    required this.photoPath,
    required this.unreadMessageCount,
  });
  factory Users1.fromJson(Map<String, dynamic> json) {
    return Users1(
      id: json['id'] as int,
      userName: json['userName'] as String? ?? 'x',
      userRoleId: json['userRoleId'] != null ? json['userRoleId'] as int : 0,
      roleName: json['roleName'] as String? ?? 'r',
      fullName: json['fullName'] as String? ?? '',
      photoPath: json['photoPath'] as String? ?? '',
      unreadMessageCount: json['unreadMessageCount'] != null
          ? json['unreadMessageCount'] as int
          : 0,
    );
  }
}

class Messages {
  final int id;
  final String message;
  final int senderUserAccountId;
  final int receiverUserAccountId;

  Messages({
    required this.id,
    required this.message,
    required this.senderUserAccountId,
    required this.receiverUserAccountId,
  });

  factory Messages.fromJson(Map<String, dynamic> json) {
    return Messages(
      id: json['id'] as int,
      message: json['message'] as String,
      senderUserAccountId: json['senderUserAccountId'] as int,
      receiverUserAccountId: json['receiverUserAccountId'] as int,
    );
  }
}

Future<List<Messages>> fetchThread(int id) async {
  String? token;
  final prefs = await SharedPreferences.getInstance();
  token = prefs.getString('userToken');
  final url = await http.get(
    Uri.parse('http://localhost:5183/api/Chat/thread/1/$id'),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );

  try {
    final response = await (url);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      // Parse the JSON data into a List of YourDataModel objects
      final List<Messages> dataList =
          data.map((dynamic item) => Messages.fromJson(item)).toList();

      return dataList;
    } else {
      // Handle errors here, e.g., response.statusCode
      print('Error: ${response.statusCode}');
      throw Exception('Failed to fetch data');
    }
  } catch (e) {
    // Handle exceptions
    print('Exception: $e');
    throw Exception('Failed to fetch data');
  }
}

Future sendMessage(String text, int id) async {
  String? token;
  final prefs = await SharedPreferences.getInstance();
  token = prefs.getString('userToken');
  final Map<String, dynamic> requestBody = {
    "receiverUserId": id,
    "senderUserId": 1,
    "messageBody": text,
  };
  final url = await http.post(Uri.parse('http://localhost:5183/api/Chat/chat/'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestBody));

  try {
    final response = await (url);

    if (response.statusCode == 200) {
      print(response);
      return true;
    } else {
      // Handle errors here, e.g., response.statusCode
      print('Error: ${response.statusCode}');
      throw Exception('Failed to fetch data');
    }
  } catch (e) {
    // Handle exceptions
    print('Exception: $e');
    throw Exception('Failed to fetch data');
  }
}

Future<List<Users1>> fetchUsers() async {
  String? token;
  final prefs = await SharedPreferences.getInstance();
  token = prefs.getString('userToken');
  final url = Uri.parse(
    'http://localhost:5183/api/Chat/users/1',
  ); // Replace with your API endpoint

  try {
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    });
    print(response.body);
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);

      final List<Users1> attendanceList =
          jsonData.map((json) => Users1.fromJson(json)).toList();

      return attendanceList;
    } else {
      throw Exception('Failed to fetch data');
    }
  } catch (e) {
    throw Exception('Failed to fetch data: $e');
  }
}
