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
    var url = 'http://10.0.2.2:8090/dailyGoal';
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
  var url = 'http://10.0.2.2:8090/dailyGoal/$id';
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

    var url = 'http://10.0.2.2:8090/dailyGoal/update-goal';
    var headers = {'Content-Type': 'application/json'};
    var response = await http.patch(Uri.parse(url), headers: headers, body: jsonDaily);

    if (response.statusCode == 200) {
      debugPrint('Daily Goal editado com sucesso!');
    } else {
      debugPrint('Falha ao editar Daily Goal');
    }
    notifyListeners();
  }

    Future<DailyGoal> getOneDaily(num dailyId) async {
    var url = 'http://10.0.2.2:8090/dailyGoal/daily/$dailyId';
    var headers = {'Content-Type': 'application/json'};
    var response = await http.get(Uri.parse(url), headers: headers);
    final responseJson = jsonDecode(response.body);

    if (response.statusCode == 200) {
      debugPrint('GET DE HÁBITO 2 FUNCIONANDO!');
    } else {
      debugPrint('FALHA AO DAR GET EM HÁBITO] ${response.statusCode}');
    }
    
    return DailyGoal.fromJson(responseJson);
  }

  Future<void> updateQuantity(num id, int newQuantity) async{
  Map<String, dynamic> dailyGoal = {
      "id": id,
      "newQuantity": newQuantity
    };

    String jsonDaily = jsonEncode(dailyGoal);

    var url = 'http://10.0.2.2:8090/dailyGoal/quantity';
    var headers = {'Content-Type': 'application/json'};
    var response = await http.patch(Uri.parse(url), headers: headers, body: jsonDaily);

    if (response.statusCode == 200) {
      debugPrint('Daily Goal editado com sucesso!');
    } else {
      debugPrint('Falha ao editar Daily Goal');
    }
    notifyListeners();
  }

  Future<void> updateBoolean(num id, bool newValue) async {
    Map<String, dynamic> dailyGoal = {
      "id": id,
      "newBoolean": newValue
    };

    String jsonDaily = jsonEncode(dailyGoal);

    var url = 'http://10.0.2.2:8090/dailyGoal/boolean';
    var headers = {'Content-Type': 'application/json'};
    var response = await http.patch(Uri.parse(url), headers: headers, body: jsonDaily);

    if(response.statusCode == 200) {
      debugPrint('DailyGoal editado!');
    } else {
      debugPrint('Falha ao editar dailyGoal');
    }
    notifyListeners();
  }

  Future<DailyGoal> getByDay(num habitId) async {
    var url = 'http://10.0.2.2:8090/dailyGoal/day/$habitId';
    var headers = {'Content-Type': 'application/json'};
    var response = await http.get(Uri.parse(url), headers: headers);
    final responseJson = jsonDecode(response.body);

    if (response.statusCode == 200) {
      debugPrint('GET DE HÁBITO 2 FUNCIONANDO!');
    } else {
      debugPrint('FALHA AO DAR GET EM HÁBITO] ${response.statusCode}');
    }
    
    return DailyGoal.fromJson(responseJson);
  }
}
