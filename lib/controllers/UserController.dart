import 'package:aurora/models/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart';

class UserController extends ChangeNotifier {
  String name = '';
  Future<void> postUser(String userName, String email, String password) async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();

    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map<String, dynamic> user = {
      'name': userName,
      'email': email,
      'password': password
    };

    String jsonUser = jsonEncode(user);

    var url = 'http://10.0.2.2:8090/user';

    var headers = {'Content-Type': 'application/json'};

    var response =
        await http.post(Uri.parse(url), headers: headers, body: jsonUser);

    if (response.statusCode == 200) {
      debugPrint('User posted successfully!');
      await prefs.setString('email', email);
    } else {
      debugPrint('Failed to post user: ${response.statusCode}');
    }
    notifyListeners();
  }

  Future<User> _getUser() async {
    var url = 'http://10.0.2.2:8090/user/1';
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

    var url = 'http://10.0.2.2:8090/user/login';

    var headers = {'Content-Type': 'application/json'};

    var response =
        await http.post(Uri.parse(url), headers: headers, body: jsonUser);

    if (response.statusCode == 200) {
      await prefs.setString('email', email);
    } else {
      debugPrint('Failed: ${response.statusCode}');
    }
    notifyListeners();
    return response;
  }

  Future<User> getUserByEmail(String email) async {
    var url = 'http://10.0.2.2:8090/user/teste/$email';
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

  Future<void> updateUser(String name, String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    String? jsonUserString = prefs.getString('email');
    User? user2;

    if (jsonUserString != null) {
      user2 = await UserController().getUserByEmail(jsonUserString);
    }

    Map<String, dynamic> user = {
      'id': user2?.id,
      'name': name,
      'email': email,
      'password': password
    };
    
    String jsonUser = jsonEncode(user);

    var url = 'http://10.0.2.2:8090/user';
    var headers = {'Content-Type': 'application/json'};
    var response =
        await http.patch(Uri.parse(url), headers: headers, body: jsonUser);
    if (response.statusCode == 200) {
      debugPrint('User updated successfully!');
    } else {
      debugPrint('Failed to post user: ${response.statusCode}');
    }
    notifyListeners();
  }

  Future<bool> isAuthenticated() async {
    final prefs = await SharedPreferences.getInstance();
    String? jsonUserString = prefs.getString('email');
    User? user;
    if (jsonUserString != null) {
      user = await UserController().getUserByEmail(jsonUserString);
      return true;
    } else {
      return false;
    }
  }
}
