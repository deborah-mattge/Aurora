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
    var url = 'http://10.0.2.2:8092/dailyGoal';
    var headers = {'Content-Type': 'application/json'};
    var response =
        await http.post(Uri.parse(url), headers: headers, body: jsonHabit);

    if (response.statusCode == 200) {
      debugPrint('Meta do dia atualizada!');
    } else {
      debugPrint('Falha ao atualizar meta do dia: ${response.body}');
    }
    notifyListeners();
  }

  Future<List<DailyGoal>> getAll(num id) async {
    var url = 'http://10.0.2.2:8092/dailyGoal/$id';
    var headers = {'Content-Type': 'application/json'};
    var response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      debugPrint('GET DE GOAL FUNCIONANDO!');
      final responseJson = jsonDecode(response.body);
      List<DailyGoal> dailiesList = [];
      for (var daily in responseJson) {
        dailiesList.add(DailyGoal.fromJson(daily));
      }
      return dailiesList;
    } else {
      debugPrint('FALHA AO DAR GET EM GOAL: ${response.statusCode}');
      return [];
    }
  }

  Future<void> updateDailyGoal(num id, String newGoal) async {
    Map<String, dynamic> dailyGoal = {"habitId": id, "newGoal": newGoal};

    String jsonDaily = jsonEncode(dailyGoal);

    var url = 'http://10.0.2.2:8092/dailyGoal/update-goal';
    var headers = {'Content-Type': 'application/json'};
    var response =
        await http.patch(Uri.parse(url), headers: headers, body: jsonDaily);

    if (response.statusCode == 200) {
      debugPrint('Daily Goal editado com sucesso!');
    } else {
      debugPrint('Falha ao editar Daily Goal: ${response.body}');
    }
    notifyListeners();
  }

  Future<DailyGoal> getOneDaily(num dailyId) async {
    var url = 'http://10.0.2.2:8092/dailyGoal/daily/$dailyId';
    var headers = {'Content-Type': 'application/json'};
    debugPrint(dailyId.toString() +"goaallll");
    var response = await http.get(Uri.parse(url), headers: headers);
    debugPrint(dailyId.toString() +"goaallll2");

    if (response.statusCode == 200) {
      debugPrint('GET DE HÁBITO FUNCIONANDO!');
      final responseJson = jsonDecode(response.body);
      return DailyGoal.fromJson(responseJson);
    } else {
      debugPrint('FALHA AO DAR GET EM DAYLi: ${response.statusCode}');
      throw Exception('Failed to load daily goal');
    }
  }

  Future<void> updateQuantity(num id, int newQuantity) async {
    Map<String, dynamic> dailyGoal = {"id": id, "newQuantity": newQuantity};

    String jsonDaily = jsonEncode(dailyGoal);

    var url = 'http://10.0.2.2:8092/dailyGoal/quantity';
    var headers = {'Content-Type': 'application/json'};
    var response =
        await http.patch(Uri.parse(url), headers: headers, body: jsonDaily);

    if (response.statusCode == 200) {
      debugPrint('Daily Goal editado com sucesso!');
    } else {
      debugPrint('Falha ao editar Daily Goal: ${response.body}');
    }
    notifyListeners();
  }

  Future<void> updateBoolean(num id, bool newValue) async {
    Map<String, dynamic> dailyGoal = {"id": id, "newBool": newValue};

    String jsonDaily = jsonEncode(dailyGoal);

    var url = 'http://10.0.2.2:8092/dailyGoal/boolean';
    var headers = {'Content-Type': 'application/json'};
    var response =
        await http.patch(Uri.parse(url), headers: headers, body: jsonDaily);

    if (response.statusCode == 200) {
      debugPrint('DailyGoal editado!');
    } else {
      debugPrint('Falha ao editar dailyGoal: ${response.body}');
    }
    notifyListeners();
  }

  Future<DailyGoal> getByDay(num habitId) async {
    debugPrint("$habitId");

    var url = 'http://10.0.2.2:8092/dailyGoal/day/$habitId';
    var headers = {'Content-Type': 'application/json'};
    var response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      debugPrint('GET DE HÁBITO FUNCIONANDO!');
      final responseJson = jsonDecode(response.body);
      return DailyGoal.fromJson(responseJson);
    } else {
      debugPrint('FALHA AO DAR GET EM BY DAY: ${response.statusCode}');
      throw Exception('Failed to load daily goal');
    }
  }

  Future<DailyGoal> getByDay2(num dayId, num monthId, num habitId) async {
    debugPrint("$habitId");

    var url = 'http://10.0.2.2:8092/dailyGoal/$dayId/$monthId/habit/$habitId';
    var headers = {'Content-Type': 'application/json'};
    var response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      debugPrint('GET DE HÁBITO FUNCIONANDO!');
      final responseJson = jsonDecode(response.body);
      return DailyGoal.fromJson(responseJson);
    } else {
      debugPrint('FALHA AO DAR GET BY DAY 2: ${response.statusCode}');
      throw Exception('Failed to load daily goal');
    }
  }

  Future<List<DailyGoal>> getAllByDay(num dayId, num monthId) async {
    var url = 'http://10.0.2.2:8092/dailyGoal/day/$dayId/month/$monthId';
    var headers = {'Content-Type': 'application/json'};
    var response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      debugPrint('GET DE HÁBITO FUNCIONANDO!');
      final responseJson = jsonDecode(response.body);
      List<DailyGoal> dailiesList = [];
      for (var daily in responseJson) {
        dailiesList.add(DailyGoal.fromJson(daily));
      }
      return dailiesList;
    } else {
      debugPrint('FALHA AO DAR GET EM HÁBITO: ${response.statusCode}2');
      return [];
    }
  }

  Future<void> setDone(num id) async {
    var url = 'http://10.0.2.2:8092/dailyGoal/done/$id';
    var headers = {'Content-Type': 'application/json'};
    var response = await http.patch(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      debugPrint('DailyGoal editado!');
    } else {
      debugPrint('Falha ao editar dailyGoal: ${response.body}');
    }
    notifyListeners();
  }
}
