import 'package:aurora/models/DailyGoal.dart';
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
    var url = 'http://localhost:8080/dailyGoal';
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

Future<List<DailyGoal>> getAll(num id) async {
  debugPrint(id.toString());
  var url = 'http://localhost:8080/dailyGoal/$id';
  var headers = {'Content-Type': 'application/json'};
  var response = await http.get(Uri.parse(url), headers: headers);

  if (response.statusCode == 200) {
    debugPrint('GET DE GOAL!');
  } else {
    debugPrint('FALHA AO DAR GET EM GOAL] ${response.statusCode}');
  }

  List<DailyGoal> dailiesList = [];
  var responseJson = jsonDecode(response.body);
  
  for (var daily in responseJson) {
    dailiesList.add(DailyGoal.fromJson(daily));
  }
  return dailiesList;
}



  Future<void> updateDailyGoal(num id, String newGoal) async{
  Map<String, dynamic> dailyGoal = {
      "habitId": id,
      "newGoal": newGoal
    };

    String jsonDaily = jsonEncode(dailyGoal);

    var url = 'http://localhost:8080/dailyGoal/update-goal';
    var headers = {'Content-Type': 'application/json'};
    var response = await http.patch(Uri.parse(url), headers: headers, body: jsonDaily);

    if (response.statusCode == 200) {
      debugPrint('Daily Goal editado com sucesso!');
    } else {
      debugPrint('Falha ao editar Daily Goal');
    }
    notifyListeners();
  }
}
