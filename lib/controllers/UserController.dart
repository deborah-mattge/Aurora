import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class UserController extends ChangeNotifier {
  Future<void> _postUser(String userName) async {
    Map<String, dynamic> user = {'name': userName};

    String jsonUser = jsonEncode(user);

    var url = 'http://localhost:8080/user';

    var headers = {'Content-Type': 'application/json'};

    var response =
        await http.post(Uri.parse(url), headers: headers, body: jsonUser);

    if (response.statusCode == 200) {
      debugPrint('Usuário postado com sucesso!');
    } else {
      debugPrint('Falha ao postar usuário: ${response.statusCode}');
    }
    notifyListeners();
  }
}
