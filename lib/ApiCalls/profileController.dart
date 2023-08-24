import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';

class Student {
  int id;
  dynamic photo;
  String photoPath;
  dynamic priorCertificateFile;
  String priorCertificatePath;
  String firstName;
  String middleName;
  String lastName;
  String gender;
  String motherFullName;
  DateTime dob;
  String placeOfBirth;
  String phone1;
  String phone2;
  String city;
  String subCity;
  String email;
  String addressInfo;
  String status;
  dynamic enrollments;
  int userId;
  dynamic user;
  int branchId;
  dynamic branch;

  Student({
    required this.id,
    this.photo,
    required this.photoPath,
    this.priorCertificateFile,
    required this.priorCertificatePath,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.gender,
    required this.motherFullName,
    required this.dob,
    required this.placeOfBirth,
    required this.phone1,
    required this.phone2,
    required this.city,
    required this.subCity,
    required this.email,
    required this.addressInfo,
    required this.status,
    this.enrollments,
    required this.userId,
    this.user,
    required this.branchId,
    this.branch,
  });

  factory Student.fromRawJson(String str) => Student.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Student.fromJson(Map<String, dynamic> json) => Student(
        id: json["id"],
        photo: json["photo"],
        photoPath: json["photoPath"],
        priorCertificateFile: json["priorCertificateFile"],
        priorCertificatePath: json["priorCertificatePath"],
        firstName: json["firstName"],
        middleName: json["middleName"],
        lastName: json["lastName"],
        gender: json["gender"],
        motherFullName: json["motherFullName"],
        dob: DateTime.parse(json["dob"]),
        placeOfBirth: json["placeOfBirth"],
        phone1: json["phone1"],
        phone2: json["phone2"],
        city: json["city"],
        subCity: json["subCity"],
        email: json["email"],
        addressInfo: json["addressInfo"],
        status: json["status"],
        enrollments: json["enrollments"],
        userId: json["userId"],
        user: json["user"],
        branchId: json["branchId"],
        branch: json["branch"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "photo": photo,
        "photoPath": photoPath,
        "priorCertificateFile": priorCertificateFile,
        "priorCertificatePath": priorCertificatePath,
        "firstName": firstName,
        "middleName": middleName,
        "lastName": lastName,
        "gender": gender,
        "motherFullName": motherFullName,
        "dob": dob.toIso8601String(),
        "placeOfBirth": placeOfBirth,
        "phone1": phone1,
        "phone2": phone2,
        "city": city,
        "subCity": subCity,
        "email": email,
        "addressInfo": addressInfo,
        "status": status,
        "enrollments": enrollments,
        "userId": userId,
        "user": user,
        "branchId": branchId,
        "branch": branch,
      };
}

Future<List<Student>> fetchProfile() async {
  String? token;
  final prefs = await SharedPreferences.getInstance();
  token = prefs.getString('userToken');
  final response = await http
      .get(Uri.parse('http://localhost:5183/api/Students/1'), headers: {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  });

  print(response.statusCode);
  if (response.statusCode == 200) {
    final jsonData = json.decode('[' + response.body + ']');
    List<dynamic> jsonList = jsonData as List;
    List<Student> student =
        jsonList.map((json) => Student.fromJson(json)).toList();

    return student;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
