import 'package:aurora/models/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart';

class UserController extends ChangeNotifier {
  String name = '';
  Future<void> postUser(String userName, String email, String password) async {
    Map<String, dynamic> user = {
      'name': userName,
      'email': email,
      'password': password
    };

    String jsonUser = jsonEncode(user);

    var url = 'http://localhost:8080/user';

    var headers = {'Content-Type': 'application/json'};

    var response =
        await http.post(Uri.parse(url), headers: headers, body: jsonUser);

    if (response.statusCode == 200) {
      debugPrint('User posted successfully!');
    } else {
      debugPrint('Failed to post user: ${response.statusCode}');
    }
    notifyListeners();
  }

  Future<User> _getUser() async {
    var url = 'http://localhost:8080/user/1';
    var headers = {'Content-Type': 'application/json'};
    var response = await http.get(Uri.parse(url), headers: headers);
    final responseJson = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode == 200) {
      debugPrint('GET DE USUÁRIO FUNCIONANDO!');
    } else {
      debugPrint('FALHA AO DAR GET EM USUÁRIO ${response.statusCode}');
    }
    return User.fromJson(responseJson);
  }

  Future<Response> authenticateUser(String email, String password) async {
    //shared Preferences is like angular LocalStorage
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    Map<String, dynamic> user = {'email': email, 'password': password};
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonUser = jsonEncode(user);

    var url = 'http://localhost:8080/user/login';

    var headers = {'Content-Type': 'application/json'};

    var response =
        await http.post(Uri.parse(url), headers: headers, body: jsonUser);

    if (response.statusCode == 200) {
      await _sharedPreferences.setString('loggedUser', jsonUser);
      await prefs.setString('email', email);
    } else {
      debugPrint('Failed: ${response.statusCode}');
    }
    notifyListeners();
    return response;
  }

  Future<User> getUserByEmail(String email) async {
    var url = 'http://localhost:8080/user/teste/$email';
    var headers = {'Content-Type': 'application/json'};
    var response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body) as Map<String, dynamic>;
      debugPrint('GET DE USUÁRIO FUNCIONANDO!');
      return User.fromJson(responseJson);
    } else {
      throw Exception('Failed to load user by email');
    }
  }

  Future<User> updateUser(User user) async {
    String jsonUser = jsonEncode(user);
    var url = 'http://localhost:8080/user';
    var headers = {'Content-Type': 'application/json'};
    var response =
        await http.patch(Uri.parse(url), headers: headers, body: jsonUser);
    if (response.statusCode == 200) {
      debugPrint('User posted successfully!');
    } else {
      debugPrint('Failed to post user: ${response.statusCode}');
    }
    notifyListeners();
    return user;
  }
}
