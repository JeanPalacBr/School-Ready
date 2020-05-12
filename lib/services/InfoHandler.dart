import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';

class UserInfo {
  final String token;
  final String username;
  final String name;

  UserInfo({this.token, this.username, this.name});

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      token: json['token'],
      username: json['username'],
      name: json['name'],
    );
  }
}

class CourseInfo {
  final int id;
  final int students;
  final String professor;
  final String name;

  CourseInfo({this.id, this.name, this.professor, this.students});

  factory CourseInfo.fromJson(Map<String, dynamic> json) {
    return CourseInfo(
      id: json['id'],
      name: json['name'],
      professor: json['professor'],
      students: json['students'],
    );
  }
}

class CToken {
  final bool valid;
  CToken({this.valid});
  factory CToken.fromJson(Map<String, dynamic> json) {
    return CToken(
      valid: json['valid'],
    );
  }
}

Future<UserInfo> signIn({String email, String password}) async {
  final http.Response response = await http.post(
    'https://movil-api.herokuapp.com/signin',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{'email': email, 'password': password}),
  );

  print('${response.body}');
  print('${response.statusCode}');
  if (response.statusCode == 200) {
    print('${response.body}');
    return UserInfo.fromJson(json.decode(response.body));
  } else {
    print("signup failed");
    print('${response.body}');
    throw Exception(response.body);
  }
}

Future<UserInfo> signUp(
    {String email, String password, String username, String name}) async {
  final http.Response response = await http.post(
    'https://movil-api.herokuapp.com/signup',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'password': password,
      'username': username,
      'name': name
    }),
  );

  print('${response.body}');
  print('${response.statusCode}');
  if (response.statusCode == 200) {
    print('${response.body}');
    return UserInfo.fromJson(json.decode(response.body));
  } else {
    print("signup failed");
    print('${response.body}');
    throw Exception(response.body);
  }
}

Future<List<CourseInfo>> showCourses(String username, String token) async {
  Uri uri = Uri.https("movil-api.herokuapp.com", '$username/courses',
      {'parametro': "valorParametro"});
  final http.Response response = await http.get(
    uri,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: "Bearer " + token,
    },
  );
  print('${response.body}');
  print('${response.statusCode}');
  if (response.statusCode == 200) {
    print('${response.body}');
    List<dynamic> jsonlist = json.decode(response.body) as List;
    List<CourseInfo> coursesList =
        jsonlist.map((e) => CourseInfo.fromJson(e)).toList();
    return coursesList;
  } else {
    print("request failed");
    print('${response.body}');
    throw Exception(response.body);
  }
}

Future<CourseInfo> createCourses(String username, String token) async {
  Uri uri = Uri.https("movil-api.herokuapp.com", '$username/courses',
      {'parametro': "valorParametro"});
  final http.Response response = await http.post(
    uri,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: "Bearer " + token,
    },
  );
  print('${response.body}');
  print('${response.statusCode}');
  if (response.statusCode == 200) {
    print('${response.body}');
    return CourseInfo.fromJson(json.decode(response.body));
  } else {
    print("request failed");
    print('${response.body}');
    throw Exception(response.body);
  }
}

Future<CToken> checkToken(String token) async {
  final http.Response response = await http.post(
    'https://movil-api.herokuapp.com/check/token',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{'token': token}),
  );
  print('${token}');
  print('${response.body}');
  print('${response.statusCode}');
  if (response.statusCode == 200) {
    print('${response.body}');
    return CToken.fromJson(json.decode(response.body));
  } else {
    print("signup failed");
    print('${response.body}');
    throw Exception(response.body);
  }
}
