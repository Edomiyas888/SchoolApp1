import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class Event {
  int? id;
  String eventName;
  bool? priority;
  String? startDateTime;
  String? endDateTime;
  String? description;
  dynamic? attatchmentFile;
  dynamic? attatchmentFilePath;
  dynamic? schoolId;
  dynamic? school;
  dynamic? branchId;
  dynamic? branch;

  Event({
    this.id,
    required this.eventName,
    this.priority,
    this.startDateTime,
    this.endDateTime,
    this.description,
    this.attatchmentFile,
    this.attatchmentFilePath,
    this.schoolId,
    this.school,
    this.branchId,
    this.branch,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'] as int?,
      eventName: json['eventName'] as String,
      priority: json['priority'] as bool?,
      startDateTime: json['startDateTime'] as String?,
      endDateTime: json['endDateTime'] as String?,
      description: json['description'] as String?,
      attatchmentFile: json['attatchmentFile'],
      attatchmentFilePath: json['attatchmentFilePath'],
      schoolId: json['schoolId'],
      school: json['school'],
      branchId: json['branchId'],
      branch: json['branch'],
    );
  }
}

Future<List<Event>> fetchAlbum() async {
  String? token;
  final prefs = await SharedPreferences.getInstance();
  token = prefs.getString('userToken');

  final response = await http
      .get(Uri.parse('http://localhost:5183/api/AcademicEvents'), headers: {
    'Authorization': 'Bearer $token',
    'Content-Type': 'application/json',
  });
  print(response.statusCode);
  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body);
    List<dynamic> jsonList = jsonData as List;
    List<Event> events = jsonList.map((json) => Event.fromJson(json)).toList();

    return events;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
