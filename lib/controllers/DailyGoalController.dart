import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DailyGoalController extends ChangeNotifier {
  Future<void> _postQuantityDaily(int currentStatus) async {
    Map<String, dynamic> quantity = {
      "habit": {"id": 1},
      "quantity": {"currentStatus": currentStatus}
    };

    String jsonHabit = jsonEncode(quantity);
    var url = 'http://10.0.2.2:8080/dailyGoal';
    var headers = {'Content-Type': 'application/json'};
    var response =
        await http.post(Uri.parse(url), headers: headers, body: jsonHabit);

    if (response.statusCode == 200) {
      debugPrint('Meta do dia atualizada!');
    } else {
      debugPrint('Meta do dia atualizada!');
    }
    notifyListeners();
  }
}
