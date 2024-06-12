import 'package:aurora/models/Habit.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HabitController extends ChangeNotifier {

  Future<void> postHabits(String name, String colorTag, TypeLabel typeLabel,  periodLabel, String reference, String finishDate, String meta) async {
    Map<String, dynamic> habit = {
      "name": name,
      "reference": reference,
      "habitCategory": periodLabel.toString().split('.').last,
      "goalKind": typeLabel.toString().split('.').last,
      "color": colorTag,
      "finalDate": finishDate,
      "goal" : meta,
      "user": {"id": 1}
    };

    String jsonHabit = jsonEncode(habit);

    var url = 'http://localhost:8080/habit';

    var headers = {'Content-Type': 'application/json'};

    var response =
        await http.post(Uri.parse(url), headers: headers, body: jsonHabit);

    if (response.statusCode == 200) {
      debugPrint('Hábito postado com sucesso!');
    } else {
      debugPrint('Falha ao postar hábito');
    }
    notifyListeners();
  }

  Future<List<Habit>> getHabits(num id) async {
    var url = 'http://localhost:8080/habit/user/$id';
    var headers = {'Content-Type': 'application/json'};
    var response = await http.get(Uri.parse(url), headers: headers);
    final responseJson = jsonDecode(response.body);

    if (response.statusCode == 200) {
      debugPrint('GET DE HÁBITO FUNCIONANDO!');
    } else {
      debugPrint('FALHA AO DAR GET EM HÁBITO] ${response.statusCode}');
    }

    List<Habit> habitsList = [];

    for (var habitFor in responseJson) {
      habitsList.add(Habit.fromJson(habitFor));
    }
    return habitsList;
  }

  Future<Habit> getOneHabit(num habitId, num userId) async {

    var url = 'http://localhost:8080/habit/$habitId/user/$userId';
    var headers = {'Content-Type': 'application/json'};
    var response = await http.get(Uri.parse(url), headers: headers);
    final responseJson = jsonDecode(response.body);

    if (response.statusCode == 200) {
      debugPrint('GET DE HÁBITO 2 FUNCIONANDO!');
    } else {
      debugPrint('FALHA AO DAR GET EM HÁBITO] ${response.statusCode}');
    }

    return Habit.fromJson(responseJson);
  }

  Future<void> updateHabit(
      int habitId,
      String habitName,
      String reference,
      PeriodLabel period,
      TypeLabel typeLabel,
      Color color,
      String parse) async {
    Map<String, dynamic> habit = {
      "id": habitId,
      "name": habitName,
      "reference": reference,
      "habitCategory": period.toString().split('.').last,
      "goalKind": typeLabel.toString().split('.').last,
      "color": '#${color.value.toRadixString(16).padLeft(8, '0')}',
      "finalDate": parse
    };

    String jsonHabit = jsonEncode(habit);

    var url = 'http://localhost:8080/habit/update';

    var headers = {'Content-Type': 'application/json'};

    var response =
        await http.patch(Uri.parse(url), headers: headers, body: jsonHabit);

    if (response.statusCode == 200) {
      debugPrint('Hábito editado com sucesso!');
    } else {
      debugPrint('Falha ao editar hábito');
    }
    notifyListeners();
  }

  Future<List<Habit>> getHabitsByCategory(
      int userId, PeriodLabel category) async {
    List<Habit> allHabits = await getHabits(userId);
    return allHabits.where((habit) => habit.habitCategory == category).toList();
  }
}
